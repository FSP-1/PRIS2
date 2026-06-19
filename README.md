sergiomcp@sergiomcp:~/ms-365-mcp-server/cert$ systemctl status nginx.service
× nginx.service - A high performance web server and a reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: enabled)
     Active: failed (Result: exit-code) since Fri 2026-06-19 07:31:31 UTC; 2min 7s ago
   Duration: 13min 12.994s
       Docs: man:nginx(8)
    Process: 28489 ExecStartPre=/usr/sbin/nginx -t -q -g daemon on; master_process on; (code=exited, status=1/FAILURE)
        CPU: 21ms

jun 19 07:31:31 sergiomcp systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
jun 19 07:31:31 sergiomcp nginx[28489]: 2026/06/19 07:31:31 [emerg] 28489#28489: SSL_CTX_load_verify_locations("/home/sergiomcp/ms-365-mcp-server>
jun 19 07:31:31 sergiomcp nginx[28489]: nginx: configuration file /etc/nginx/nginx.conf test failed
jun 19 07:31:31 sergiomcp systemd[1]: nginx.service: Control process exited, code=exited, status=1/FAILURE
jun 19 07:31:31 sergiomcp systemd[1]: nginx.service: Failed with result 'exit-code'.
jun 19 07:31:31 sergiomcp systemd[1]: Failed to start nginx.service - A high performance web server and a reverse proxy server.
