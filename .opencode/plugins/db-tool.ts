import { type Plugin, tool } from "@opencode-ai/plugin"

export const DbToolPlugin: Plugin = async () => {
    return {
        tool: {
            queryDatabase: tool({
                description: "Run a read-only SQL query on the project database",
                args: {
                    sql: tool.schema
                        .string()
                        .describe("SQL SELECT query"),
                    limit: tool.schema
                        .number()
                        .default(20)
                        .describe("Maximum rows to return"),
                },
                async execute(args, context) {
                    // Connect to the database using environment variables:
                    //   SPRING_DATASOURCE_URL, SPRING_DATASOURCE_USERNAME, SPRING_DATASOURCE_PASSWORD
                    // The actual connection implementation should be added here.
                    const result = `Executed: ${args.sql} LIMIT ${args.limit} (context: ${context.directory})`
                    return result
                },
            }),
        },
    }
}
