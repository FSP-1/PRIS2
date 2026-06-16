$body = @{
    model = "qwen-coder"
    messages = @(
        @{
            role = "user"
            content = "Use create_file to create hello.md"
        }
    )
    tools = @(
        @{
            type = "function"
            function = @{
                name = "create_file"
                description = "Create a file"
                parameters = @{
                    type = "object"
                    properties = @{
                        path = @{
                            type = "string"
                        }
                    }
                    required = @("path")
                }
            }
        }
    )
    tool_choice = "auto"
} | ConvertTo-Json -Depth 20

Invoke-RestMethod `
    -Uri "http://192.168.2.45:8080/v1/chat/completions" `
    -Method Post `
    -ContentType "application/json" `
    -Body $body
