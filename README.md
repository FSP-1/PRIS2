sergiomcp@sergiomcp:~/ms-365-mcp-server$  nslookup mcp.partenon.medgaz.com
Server:         127.0.0.53
Address:        127.0.0.53#53

Name:   mcp.partenon.medgaz.com
Address: 192.168.2.33

sergiomcp@sergiomcp:~/ms-365-mcp-server$  sudo ss -tuln | grep -E ':443|:80'
[sudo] password for sergiomcp: 
tcp   LISTEN 0      2048                0.0.0.0:8080       0.0.0.0:*          
tcp   LISTEN 0      511                 0.0.0.0:80         0.0.0.0:*          
tcp   LISTEN 0      128               127.0.0.1:44383      0.0.0.0:*          
tcp   LISTEN 0      511                 0.0.0.0:443        0.0.0.0:*          
sergiomcp@sergiomcp:~/ms-365-mcp-server$  curl -k https://mcp.partenon.medgaz.com/.well-known/openid-configuration 2>&1 | head -20
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   171  100   171    0     0   2675      0 --:--:-- --:--:-- --:--:--  2714
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Error</title>
</head>
<body>
<pre>Cannot GET /.well-known/openid-configuration</pre>
</body>
</html>
sergiomcp@sergiomcp:~/ms-365-mcp-server$  ps aux | grep -E "(node|tsx)" | grep -v grep
sergiom+   20023  0.3  0.7 1798892 162244 ?      Sl   05:59   0:22 /home/sergiomcp/.vscode-server/cli/servers/Stable-93cfdd489c3b228840d0f86ec77c3636277c93ea/server/node /home/sergiomcp/.vscode-server/cli/servers/Stable-93cfdd489c3b228840d0f86ec77c3636277c93ea/server/out/server-main.js --connection-token=remotessh --accept-server-license-terms --agent-host-bridge-port=44383 --agent-host-bridge-host=127.0.0.1 --agent-host-bridge-connection-token=7215fcac-9870-4264-b1e1-0eb4c04f12b8 --start-server --enable-remote-auto-shutdown --socket-path=/tmp/code-67599d39-d979-48ca-8ca6-29e3b2bb118c
sergiom+   20086  0.0  0.3 1660436 79072 ?       Sl   05:59   0:02 /home/sergiomcp/.vscode-server/cli/servers/Stable-93cfdd489c3b228840d0f86ec77c3636277c93ea/server/node /home/sergiomcp/.vscode-server/cli/servers/Stable-93cfdd489c3b228840d0f86ec77c3636277c93ea/server/out/bootstrap-fork --type=fileWatcher
sergiom+   20328  3.6  4.7 30447376 978476 ?     Sl   05:59   3:32 /home/sergiomcp/.vscode-server/cli/servers/Stable-93cfdd489c3b228840d0f86ec77c3636277c93ea/server/node --dns-result-order=ipv4first /home/sergiomcp/.vscode-server/cli/servers/Stable-93cfdd489c3b228840d0f86ec77c3636277c93ea/server/out/bootstrap-fork --type=extensionHost --transformURIs --useHostProxy=false
sergiom+   20334  0.3  0.4 1560092 84888 ?       Sl   05:59   0:22 /home/sergiomcp/.vscode-server/cli/servers/Stable-93cfdd489c3b228840d0f86ec77c3636277c93ea/server/node /home/sergiomcp/.vscode-server/cli/servers/Stable-93cfdd489c3b228840d0f86ec77c3636277c93ea/server/out/bootstrap-fork --type=ptyHost --logsPath /home/sergiomcp/.vscode-server/data/logs/20260619T055916
sergiom+   20856  0.0  0.3 1528904 80828 ?       Sl   05:59   0:02 /home/sergiomcp/.vscode-server/cli/servers/Stable-93cfdd489c3b228840d0f86ec77c3636277c93ea/server/node /home/sergiomcp/.vscode-server/cli/servers/Stable-93cfdd489c3b228840d0f86ec77c3636277c93ea/server/extensions/json-language-features/server/dist/node/jsonServerMain --node-ipc --clientProcessId=20328
sergiom+   21058  0.0  0.3 1490940 75004 ?       Sl   06:01   0:01 /home/sergiomcp/.vscode-server/cli/servers/Stable-93cfdd489c3b228840d0f86ec77c3636277c93ea/server/node /home/sergiomcp/.vscode-server/cli/servers/Stable-93cfdd489c3b228840d0f86ec77c3636277c93ea/server/extensions/markdown-language-features/dist/serverWorkerMain --node-ipc --clientProcessId=20328
sergiom+   26635  0.2  0.5 1557604 114916 pts/3  Sl+  07:20   0:02 node /home/sergiomcp/ms-365-mcp-server/node_modules/.bin/ms-365-mcp-server --http 3000 --org-mode --public-url https://mcp.partenon.medgaz.com -v
sergiomcp@sergiomcp:~/ms-365-mcp-server$  netstat -tulnp | grep 3000 || ss -tulnp | grep 3000
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
tcp6       0      0 :::3000                 :::*                    LISTEN      26635/node          
sergiomcp@sergiomcp:~/ms-365-mcp-server$  curl -k http://10.10.10.130:3000/.well-known/oauth-authorization-server 2>&1 | head -30
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   514  100   514    0     0  29791      0 --:--:-- --:--:-- --:--:-- 30235
{"issuer":"https://mcp.partenon.medgaz.com","authorization_endpoint":"https://mcp.partenon.medgaz.com/authorize","token_endpoint":"http://10.10.10.130:3000/token","response_types_supported":["code"],"response_modes_supported":["query"],"grant_types_supported":["authorization_code","refresh_token"],"token_endpoint_auth_methods_supported":["none"],"code_challenge_methods_supported":["S256"],"scopes_supported":["Mail.ReadWrite","Mail.Send","User.Read"],"registration_endpoint":"http://10.10.10.130:3000/register"}sergiomcp@sergiomcp:~/ms-365-mcp-server$  curl -k https://192.168.2.33/.well-known/oauth-authorization-server 2>&1 | head -30
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   506  100   506    0     0  10219      0 --:--:-- --:--:-- --:--:-- 10326
{"issuer":"https://mcp.partenon.medgaz.com","authorization_endpoint":"https://mcp.partenon.medgaz.com/authorize","token_endpoint":"https://192.168.2.33/token","response_types_supported":["code"],"response_modes_supported":["query"],"grant_types_supported":["authorization_code","refresh_token"],"token_endpoint_auth_methods_supported":["none"],"code_challenge_methods_supported":["S256"],"scopes_supported":["Mail.ReadWrite","Mail.Send","User.Read"],"registration_endpoint":"https://192.168.2.33/register"}sergiomcp@sergiomcp:~/ms-365-mcp-server$  cat ~/.open-webui/config.yaml 2>/dev/null || echo "Config no encontrada"
Config no encontrada
sergiomcp@sergiomcp:~/ms-365-mcp-server$  server {
    listen 443 ssl;
            # Dominios que sirven este certificado
        server_name 192.168.2.33 mcp.partenon.medgaz.com;
        
        # Certificados SSL
        ssl_certificate     /home/sergiomcp/ms-365-mcp-server/cert/mcp.partenon.medgaz.com.crt;
        ssl_certificate_key /home/sergiomcp/ms-365-mcp-server/cert/mcp.partenon.medgaz.com.key;
        ssl_trusted_certificate /home/sergiomcp/ms-365-mcp-server/cert/chain.mcp.partenon.medgaz.com.p7b;

    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;

    location / {
        proxy_pass http://127.0.0.1:3000;

        proxy_http_version 1.1;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
} sergiomcp@sergiomcp:~/ms-365-mcp-server$ npx -y @softeria/ms-365-mcp-server --http 3000 --org-mode --public-url https://mcp.partenon.medgaz.com -v
info: Microsoft 365 MCP Server starting... {"timestamp":"2026-06-19 07:20:40"}
info: Secrets Check: {"CLIENT_ID":"d76fd0b7...","CLIENT_SECRET":"NOT SET","NODE_ENV":"NOT SET","TENANT_ID":"26993cfd-47e1-4636-9257-ca607c192da1","timestamp":"2026-06-19 07:20:40"}
info: Server listening on all interfaces (0.0.0.0:3000) {"timestamp":"2026-06-19 07:20:40"}
info:   - MCP endpoint: http://localhost:3000/mcp {"timestamp":"2026-06-19 07:20:40"}
info:   - OAuth endpoints: http://localhost:3000/auth/* {"timestamp":"2026-06-19 07:20:40"}
info:   - OAuth discovery: http://localhost:3000/.well-known/oauth-authorization-server {"timestamp":"2026-06-19 07:20:40"} <img width="1710" height="1273" alt="image" src="https://github.com/user-attachments/assets/ba4f9745-225d-4a40-9957-1c1137293c8d" />
<img width="816" height="672" alt="image" src="https://github.com/user-attachments/assets/d832d890-90bb-4e45-b333-9fb51988e975" />
