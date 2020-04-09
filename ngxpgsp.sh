bash <(curl -f -L -sS https://ngxpagespeed.com/install)      --nginx-version latest

> /lib/systemd/system/nginx.service

echo "[Unit]" >>  /lib/systemd/system/nginx.service
echo "Description=nginx - high performance web server" >>  /lib/systemd/system/nginx.service
echo "Documentation=http://nginx.org/en/docs/" >>  /lib/systemd/system/nginx.service
echo "After=network-online.target remote-fs.target nss-lookup.target" >>  /lib/systemd/system/nginx.service
echo "Wants=network-online.target" >>  /lib/systemd/system/nginx.service
echo " " >>  /lib/systemd/system/nginx.service
echo "[Service]" >>  /lib/systemd/system/nginx.service
echo "Type=forking" >>  /lib/systemd/system/nginx.service
echo "PIDFile=/var/run/nginx.pid" >>  /lib/systemd/system/nginx.service
echo "ExecStart=/usr/local/sbin/nginx -c /etc/nginx/nginx.conf" >>  /lib/systemd/system/nginx.service
echo "ExecReload=/bin/kill -s HUP $MAINPID" >>  /lib/systemd/system/nginx.service
echo "ExecStop=/bin/kill -s TERM $MAINPID" >>  /lib/systemd/system/nginx.service
echo " " >>  /lib/systemd/system/nginx.service
echo "[Install]" >>  /lib/systemd/system/nginx.service
echo "WantedBy=multi-user.target" >>  /lib/systemd/system/nginx.service

-------------


pagespeed on;
pagespeed RespectVary on;
pagespeed HonorCsp on;
pagespeed DisableRewriteOnNoTransform off;
pagespeed LowercaseHtmlNames on;
pagespeed XHeaderValue "VemDelivery modified ngx_pagespeed";



# Needs to exist and be writable by nginx.  Use tmpfs for best performance.
pagespeed FileCachePath /var/ngx_pagespeed_cache;

# Ensure requests for pagespeed optimized resources go to the pagespeed handler
# and no extraneous headers get set.
location ~ "\.pagespeed\.([a-z]\.)?[a-z]{2}\.[^.]{10}\.[^.]+" {
  add_header "" "";
}
location ~ "^/pagespeed_static/" { }
location ~ "^/ngx_pagespeed_beacon$" { }
