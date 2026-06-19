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

;; Query time: 0 msec
;; SERVER: 192.168.1.131#53(192.168.1.131) (UDP)
;; WHEN: Fri Jun 19 08:54:38 UTC 2026
;; MSG SIZE  rcvd: 123

sergiomcp@sergiomcp:/usr/local/share/ca-certificates$ nslookup mcp.partenon.medgaz.com 192.168.1.131
Server:         192.168.1.131
Address:        192.168.1.131#53

** server can't find mcp.partenon.medgaz.com: NXDOMAIN

sergiomcp@sergiomcp:/usr/local/share/ca-certificates$ 
