

Y pásame la respuesta completa.
{"id":"chatcmpl-9e764bb652778624","object":"chat.completion","created":1782203482,"model":"qwen3.5","choices":[{"index":0,"message":{"role":"assistant","content":"\n\nI'm sorry, but I don't have acce  ss to your Outlook account or the ability to list your folders directly. This would require authentication credentials and direct access to your email client, which isn't possible through my availabl  e tools.\n\nTo view your Outlook folders, you'll need to:\n\n1. Open Microsoft Outlook on your computer or mobile device\n2. Look at the left sidebar where all your folders are listed (typically incl  udes Inbox, Sent Items, Drafts, Calendar, Contacts, etc.)\n3. Or check if you've created custom folders under the main folders section\n\nWould you like help with anything else regarding Outlook or e  mail management?","refusal":null,"annotations":null,"audio":null,"function_call":null,"tool_calls":[],"reasoning":"The user is asking me to list their Outlook folders. However, I don't have any tools   that can access or interact with email clients like Outlook. The only tool available to me is \"test_tool\" which appears to be a test utility that takes a name parameter - it doesn't seem related t  o accessing email accounts or folder lists.\n\nI should let the user know that I cannot access their Outlook account or list their folders directly, as this requires authentication and access to thei  r personal email system which isn't something I can do through these tools.\n"},"logprobs":null,"finish_reason":"stop","stop_reason":null,"token_ids":null,"routed_experts":null}],"service_tier":null,  "system_fingerprint":"vllm-0.22.1-9c4744c2","usage":{"prompt_tokens":261,"total_tokens":504,"completion_tokens":243,"prompt_tokens_details":null},"prompt_logprobs":null,"prompt_token_ids":null,"promp
sergio@sergio:~$ 

set-chat-message-reaction (missing: ChatMessage.Send); unset-chat-message-reaction (missing: ChatMessage.Send); list-pinned-chat-messages (missing: Chat.Read); pin-chat-message (missing: ChatMessage.Send); unpin-chat-message (missing: Chat.ReadWrite); get-presences-by-user-id (missing: Presence.Read.All); copilot-retrieve (missing: ExternalItem.Read.All); get-drive-item (missing: Files.Read); move-rename-onedrive-item (missing: Files.ReadWrite); delete-onedrive-file (missing: Files.ReadWrite); list-folder-files (missing: Files.Read), ... +244 more {"timestamp":"2026-06-23 08:33:47"}
jun 23 08:33:47 sergiomcp env[45446]: info: Tool registration complete: 46 registered, 264 skipped, 0 failed {"timestamp":"2026-06-23 08:33:47"}
jun 23 08:33:47 sergiomcp env[45446]: info: Tool get-current-user called with params: {"select":"id,emailAddress,name"} {"timestamp":"2026-06-23 08:33:47"}
jun 23 08:33:47 sergiomcp env[45446]: info: Making graph request to /me?$select=id,emailAddress,name with options: {"method":"GET","headers":{"Prefer":"outlook.body-content-type=\"text\""}} {"timestamp":"2026-06-23 08:33:47"}
jun 23 08:33:47 sergiomcp env[45446]: info: Calling /me?$select=id,emailAddress,name with options: {"method":"GET","headers":{"Prefer":"outlook.body-content-type=\"text\""}} {"timestamp":"2026-06-23 08:33:47"}
jun 23 08:33:47 sergiomcp env[45446]: info: [GRAPH CLIENT] Final URL being sent to Microsoft: https://graph.microsoft.com/v1.0/me?$select=id,emailAddress,name {"timestamp":"2026-06-23 08:33:47"}
jun 23 08:33:48 sergiomcp env[45446]: info: Response size: 50 characters {"timestamp":"2026-06-23 08:33:48"}
jun 23 08:33:48 sergiomcp env[45446]: {"level":"info","message":{"duration_ms":446,"event":"tool.call","http_method":"GET","request_id":"8e524252-af22-4f79-b3fa-948f19751f4c","status":"success","tool":"get-current-user","user_principal_name":"ext_serper@medgaz.com"},"service":"ms-365-mcp-server","stream":"audit","timestamp":"2026-06-23T08:33:48.328+00:00"}


mcp endpoint   {
    "pathPattern": "/me/messages",
    "method": "get",
    "toolName": "list-mail-messages",
    "presets": ["mail", "outlook", "personal"],
    "scopes": ["Mail.Read"],
    "llmTip": "List read search my Outlook emails across folders. CRITICAL: When searching emails, the $search parameter value MUST be wrapped in double quotes. Format: $search=\"your search query here\". Use KQL (Keyword Query Language) syntax to search specific properties: 'from:', 'subject:', 'body:', 'to:', 'cc:', 'bcc:', 'attachment:', 'hasAttachments:', 'importance:', 'received:', 'sent:'. Examples: $search=\"from:john@example.com\" | $search=\"subject:meeting AND hasAttachments:true\" | $search=\"body:urgent AND received>=2024-01-01\" | $search=\"from:john AND importance:high\". Remember: ALWAYS wrap the entire search expression in double quotes! Reference: https://learn.microsoft.com/en-us/graph/search-query-parameter IMPORTANT: Always use $select to limit returned fields and reduce response size. Recommended default: $select=id,subject,from,toRecipients,receivedDateTime,bodyPreview,isRead,hasAttachments. Use bodyPreview instead of body for listings. To read the full email body, use get-mail-message with the specific message id."
  },
  {
    "pathPattern": "/me/mailFolders",
    "method": "get",
    "toolName": "list-mail-folders",
    "presets": ["mail", "outlook", "personal"],
    "scopes": ["Mail.Read"]
  },
  {
