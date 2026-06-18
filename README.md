por ahora esta server {
    listen 3000;

    location / {
        proxy_pass http://10.10.10.104:3000;

        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        # importante para OAuth / redirects
        proxy_set_header X-Forwarded-Proto $scheme;

        # evita problemas de keepalive
        proxy_set_header Connection "";
    }
}

server {
    listen 443 ssl http2;
    server_name mcp.medgaz.com;

    ssl_certificate     /etc/nginx/certs/fullchain.pem;
    ssl_certificate_key /etc/nginx/certs/privkey.pem;

    location / {

        proxy_pass http://10.10.10.104:3000;

        proxy_http_version 1.1;
        proxy_buffering off;

        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-Proto https;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Real-IP $remote_addr;

        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
