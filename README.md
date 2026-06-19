sergiomcp@sergiomcp:/usr/local/share/ca-certificates$ getent hosts mcp.partenon.medgaz.com
192.168.2.33    mcp.partenon.medgaz.com
sergiomcp@sergiomcp:/usr/local/share/ca-certificates$ dig @192.168.1.130 mcp.partenon.medgaz.com

; <<>> DiG 9.18.39-0ubuntu0.24.04.5-Ubuntu <<>> @192.168.1.130 mcp.partenon.medgaz.com
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 18389
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4000
;; QUESTION SECTION:
;mcp.partenon.medgaz.com.       IN      A

;; AUTHORITY SECTION:
partenon.medgaz.com.    3600    IN      SOA     mgdc3.partenon.medgaz.com. hostmaster. 826427 900 600 86400 3600

;; Query time: 0 msec
;; SERVER: 192.168.1.130#53(192.168.1.130) (UDP)
;; WHEN: Fri Jun 19 08:54:30 UTC 2026
;; MSG SIZE  rcvd: 123

sergiomcp@sergiomcp:/usr/local/share/ca-certificates$ dig @192.168.1.131 mcp.partenon.medgaz.com

; <<>> DiG 9.18.39-0ubuntu0.24.04.5-Ubuntu <<>> @192.168.1.131 mcp.partenon.medgaz.com
; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 6160
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4000
;; QUESTION SECTION:
;mcp.partenon.medgaz.com.       IN      A

;; AUTHORITY SECTION:
partenon.medgaz.com.    3600    IN      SOA     mgdc2.partenon.medgaz.com. hostmaster. 826427 900 600 86400 3600
server {
    listen 80;
    listen [::]:80;

    server_name mcp.partenon.medgaz.com;

    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    server_name mcp.partenon.medgaz.com;

    ssl_certificate     /etc/nginx/ssl/fullchain.pem;
    ssl_certificate_key /etc/nginx/ssl/mcp.partenon.medgaz.com.key;

    ssl_protocols TLSv1.2 TLSv1.3;

    #
    # OPEN WEBUI
    #
    location / {
        proxy_pass http://127.0.0.1:8080;

        proxy_http_version 1.1;

        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;

        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    #
    # MCP ENDPOINT
    #
    location /mcp {
        proxy_pass http://127.0.0.1:3000/mcp;

        proxy_http_version 1.1;

        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;

        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }

    #
    # OAuth Discovery
    #
    location /.well-known {
        proxy_pass http://127.0.0.1:3000/.well-known;

        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-Host $host;
    }

    #
    # OAuth endpoints
    #
    location /authorize {
        proxy_pass http://127.0.0.1:3000/authorize;

        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-Host $host;
    }

    location /token {
        proxy_pass http://127.0.0.1:3000/token;

        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-Host $host;
    }

    location /register {
        proxy_pass http://127.0.0.1:3000/register;

        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-Host $host;
    }
}
;; Query time: 0 msec
;; SERVER: 192.168.1.131#53(192.168.1.131) (UDP)
;; WHEN: Fri Jun 19 08:54:38 UTC 2026
;; MSG SIZE  rcvd: 123

sergiomcp@sergiomcp:/usr/local/share/ca-certificates$ nslookup mcp.partenon.medgaz.com 192.168.1.131
Server:         192.168.1.131
Address:        192.168.1.131#53

** server can't find mcp.partenon.medgaz.com: NXDOMAIN

sergiomcp@sergiomcp:/usr/local/share/ca-certificates$ 
