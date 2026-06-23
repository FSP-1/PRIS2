ms-365_list-mail-messages

Parameters
{
  "search": "'from:Sergio Pereyra ext'",
  "select": "id,subject,from,receivedDateTime"
}
Content
[{'type': 'text', 'text': '{"error":"Microsoft Graph API error: 400 Bad Request - {\"error\":{\"code\":\"BadRequest\",\"message\":\"Syntax error: character ''' is not valid at position 0 in ''from:Sergio Pereyra ext''.\",\"innerError\":{\"date\":\"2026-06-23T09:28:38\",\"request-id\":\"401da0cd-257f-4f7e-a34d-965c0fea6b38\",\"client-request-id\":\"401da0cd-257f-4f7e-a34d-965c0fea6b38\"}}}"}', 'annotations': None, 'meta': None}]


{
  "tool_calls": [
    {
      "name": "ms-365_list-mail-messages",
      "arguments": {
        "$search": "from:Sergio Pereyra",
        "$select": "id,subject,receivedDateTime",
        "$top": 10
      },
      "options": {"includeResponse": false}
    }
  ]
}
