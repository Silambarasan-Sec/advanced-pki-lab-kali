server {
    listen 443 ssl;
    server_name localhost;

    ssl_certificate     /etc/nginx/server.crt;
    ssl_certificate_key /etc/nginx/server.key;

    ssl_client_certificate /etc/nginx/rootCA.crt;
    ssl_verify_client on;
    ssl_verify_depth 2;

    # optional CRL if using revocation
    # ssl_crl /etc/nginx/sub.crl;

    location / {
        root /var/www/html;
        index index.html index.htm;
    }
}
