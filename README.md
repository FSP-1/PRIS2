$body = @{
    model = "qwen-coder"
    messages = @(
        @{
            role = "user"
            content = "Replace foo by bar in test.txt"
        }
    )
    tools = @(
        @{
            type = "function"
            function = @{
                name = "replace_string_in_file"
                description = "Replace text in a file"
                parameters = @{
                    type = "object"
                    properties = @{
                        path = @{ type = "string" }
                        old = @{ type = "string" }
                        new = @{ type = "string" }
                    }
                    required = @("path","old","new")
                }
            }
        }
    )
    tool_choice = "auto"
} | ConvertTo-Json -Depth 20
