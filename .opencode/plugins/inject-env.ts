import type { Plugin } from "@opencode-ai/plugin"

export const InjectEnvPlugin: Plugin = async () => {
    return {
        "shell.env": async (_input, output) => {
            output.env.PYTHONUNBUFFERED = "1"
            output.env.FORCE_COLOR = "1"
            output.env.TERM = "xterm-256color"
        },
    }
}
