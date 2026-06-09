import type {Plugin} from "@opencode-ai/plugin"

const BANNED_BASH_PATTERNS = [
    /rm\s+-rf/,
    /chmod\s+777/,
    />\s*\/dev\/sd/,
    /mkfs/,
    /killall/,
    /shutdown/,
    /curl.*\|\s*bash/,
    /wget.*\|\s*bash/,
]

const PROTECTED_FILE_PATTERNS = [
    ".env",
    "id_rsa",
    "id_ed25519",
    "passwd",
    "shadow",
    ".git/config",
]

export const SecurityGuardPlugin: Plugin = async () => {
    return {
        "tool.execute.before": async (input, output) => {
            const {tool} = input

            if (tool === "bash") {
                const command: string = output.args?.command ?? ""
                for (const pattern of BANNED_BASH_PATTERNS) {
                    if (pattern.test(command)) {
                        throw new Error(
                            `Security: command "${command}" blocked by local policy. Destructive commands are not allowed.`,
                        )
                    }
                }
            }

            if (tool === "read" || tool === "write" || tool === "edit") {
                const filePath: string = (output.args?.filePath ?? "").toLowerCase()
                for (const secureFile of PROTECTED_FILE_PATTERNS) {
                    if (filePath.includes(secureFile)) {
                        throw new Error(
                            `Security: access to "${filePath}" blocked. This file contains sensitive data.`,
                        )
                    }
                }
            }
        },
    }
}
