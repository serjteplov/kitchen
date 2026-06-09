import type {Plugin} from "@opencode-ai/plugin"

export const FormatHookPlugin: Plugin = async ({$}) => {
    return {
        "tool.execute.after": async (input, _output) => {
            if (input.tool === "write") {
                const filePath: string = input.args?.filePath ?? ""
                const isFormattable =
                    filePath.endsWith(".kt") ||
                    filePath.endsWith(".kts") ||
                    filePath.endsWith(".java")
                if (isFormattable) {
                    await $`./gradlew ktlintFormat`.quiet()
                }
            }
        },
    }
}
