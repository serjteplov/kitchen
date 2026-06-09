import type {Plugin} from "@opencode-ai/plugin"

export const AttentionNotifyPlugin: Plugin = async ({$}) => {
    return {
        "permission.ask": async (input, _output) => {
            const permissionType = input.type ?? "unknown"
            const pattern = input.pattern ?? ""

            const message = [
                "OpenCode requires attention!",
                `Action needs confirmation.`,
                `Type: ${permissionType}`,
                pattern
                    ? `Pattern: ${typeof pattern === "string" ? pattern : pattern.join(", ")}`
                    : null,
            ]
                .filter(Boolean)
                .join("\n")

            try {
                await $`notify-send -u critical -i dialog-warning "OpenCode" ${message}`
            } catch {
                // notify-send is Linux-specific; ignored on other platforms
            }
        },

        event: async ({event}) => {
            if (event.type === "session.idle") {
                try {
                    await $`notify-send -u normal "OpenCode" "Session is idle — waiting for input"`
                } catch {
                    // notify-send is Linux-specific; ignored on other platforms
                }
            }
        },
    }
}
