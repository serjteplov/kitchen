import type {Plugin} from "@opencode-ai/plugin"
import { appendFile } from "node:fs/promises"

const EVENT_LOG = "/tmp/opencode/attention-events.log"

function buildMessage(type: string, pattern?: string | string[]): string {
    return [
        "OpenCode requires attention!",
        `Action needs confirmation.`,
        `Type: ${type}`,
        pattern
            ? `Pattern: ${Array.isArray(pattern) ? pattern.join(", ") : pattern}`
            : null,
    ]
        .filter(Boolean)
        .join("\n")
}

export const AttentionNotifyPlugin: Plugin = async ({$}) => {
    return {
        event: async ({event}) => {
            const evt = event as { type: string; properties?: Record<string, unknown> }

            // DEBUG: log every event type to discover which permission event fires
            appendFile(EVENT_LOG, `${new Date().toISOString()} ${evt.type}\n`).catch(() => {})

            if (
                (evt.type === "permission.asked" ||
                 evt.type === "permission.v2.asked" ||
                 evt.type === "permission.updated" ||
                 evt.type === "permission.prompt.fullscreen") &&
                evt.properties
            ) {
                const type = (evt.properties.type as string) ?? "unknown"
                const pattern = evt.properties.pattern as string | string[] | undefined
                const message = buildMessage(type, pattern)
                try {
                    await $`notify-send -u critical -i dialog-warning "OpenCode" ${message}`
                } catch {
                    // silently ignore — shell error should not reach terminal
                }
            }

            if (event.type === "session.idle") {
                try {
                    await $`notify-send -u normal "OpenCode" "Session is idle — waiting for input"`
                } catch {
                    // silently ignore — shell error should not reach terminal
                }
            }
        },
    }
}
