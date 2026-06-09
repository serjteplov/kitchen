import type {Plugin} from "@opencode-ai/plugin"
import type {Event} from "@opencode-ai/sdk"
import {appendFile} from "node:fs/promises"

export const MetricsPlugin: Plugin = async () => {
    return {
        event: async (input: { event: Event }) => {
            if (input.event.type === "session.idle") {
                const line = [
                    new Date().toISOString(),
                    input.event.properties.sessionID,
                ].join("\t") + "\n"
                await appendFile("/tmp/opencode-metrics.tsv", line)
            }
        },
    }
}
