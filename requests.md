# Get request '/'
~~~
GET / HTTP/1.1
Host: localhost:8080
Connection: keep-alive
sec-ch-ua: "Microsoft Edge";v="93", " Not;A Brand";v="99", "Chromium";v="93"
sec-ch-ua-mobile: ?0
sec-ch-ua-platform: "Windows"
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.44
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9
Sec-Fetch-Site: none
Sec-Fetch-Mode: navigate
Sec-Fetch-User: ?1
Sec-Fetch-Dest: document
Accept-Encoding: gzip, deflate, br
Accept-Language: de,de-DE;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6
~~~

# Get request '/favicon.ico'
~~~
GET /favicon.ico HTTP/1.1
Host: localhost:8080
Connection: keep-alive
sec-ch-ua: "Microsoft Edge";v="93", " Not;A Brand";v="99", "Chromium";v="93"
sec-ch-ua-mobile: ?0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.63 Safari/537.36 Edg/93.0.961.44
sec-ch-ua-platform: "Windows"
Accept: image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8
Sec-Fetch-Site: same-origin
Sec-Fetch-Mode: no-cors
Sec-Fetch-Dest: image
Referer: http://localhost:8080/
Accept-Encoding: gzip, deflate, br
Accept-Language: de,de-DE;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6
~~~

# Post request '/hello'
~~~
POST /hello HTTP/1.1
Content-Type: application/json
User-Agent: PostmanRuntime/7.28.4
Accept: */*
Cache-Control: no-cache
Postman-Token: 1b03016b-e12b-472b-b768-af5d4c24311b
Host: localhost:8080
Accept-Encoding: gzip, deflate, br
Content-Length: 76

{
    "value1" : {
        "subvalue": 22
    },
    "value2" : "bar"
}
~~~

# Get request '/hellos/1'
~~~
GET /hellos/1 HTTP/1.1
User-Agent: PostmanRuntime/7.28.4
Accept: */*
Cache-Control: no-cache
Postman-Token: bd037b59-0f9b-4c7a-ba9c-57572607b2c7
Host: localhost:8080
Accept-Encoding: gzip, deflate, br

~~~