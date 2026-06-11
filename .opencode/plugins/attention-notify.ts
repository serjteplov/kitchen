import type {Plugin} from "@opencode-ai/plugin"

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
            // The binary emits "permission.asked" at runtime but the v1 SDK
            // types name this event "permission.updated". Cast to access it.
            const evt = event as { type: string; properties?: Record<string, unknown> }
            if (evt.type === "permission.asked" && evt.properties) {
                const type = (evt.properties.type as string) ?? "unknown"
                const pattern = evt.properties.pattern as string | string[] | undefined
                const message = buildMessage(type, pattern)
                try {
                    await $`notify-send -u critical -i dialog-warning "OpenCode" ${message}`
                } catch (err) {
                    console.error("[attention-notify] Failed to send permission notification:", err)
                }
            }

            if (event.type === "session.idle") {
                try {
                    await $`notify-send -u normal "OpenCode" "Session is idle — waiting for input"`
                } catch (err) {
                    console.error("[attention-notify] Failed to send idle notification:", err)
                }
            }
        },
    }
}
