2026-06-19 09:22:02.029 | INFO     | uvicorn.protocols.http.httptools_impl:send:483 - 192.168.1.24:0 - "GET /api/v1/configs/terminal_servers HTTP/1.1" 200
2026-06-19 09:22:44.054 | INFO     | uvicorn.protocols.http.httptools_impl:send:483 - 192.168.1.24:0 - "POST /api/v1/configs/tool_servers/verify HTTP/1.1" 200
2026-06-19 09:22:53.604 | INFO     | uvicorn.protocols.http.httptools_impl:send:483 - 192.168.1.24:0 - "GET /_app/version.json HTTP/1.1" 200
2026-06-19 09:22:54.047 | INFO     | open_webui.utils.oauth:get_oauth_client_info_with_dynamic_client_registration:503 - Dynamic client registration successful at https://mcp.partenon.medgaz.com/register, client_id: mcp-client-1781860974045
2026-06-19 09:22:54.054 | INFO     | uvicorn.protocols.http.httptools_impl:send:483 - 192.168.1.24:0 - "POST /api/v1/configs/oauth/clients/register?type=mcp HTTP/1.1" 200
2026-06-19 09:22:57.958 | INFO     | open_webui.internal.config:commit_async:173 - Persisting 'TOOL_SERVER_CONNECTIONS'
2026-06-19 09:22:57.959 | INFO     | uvicorn.protocols.http.httptools_impl:send:483 - 192.168.1.24:0 - "POST /api/v1/configs/tool_servers HTTP/1.1" 200
2026-06-19 09:23:26.607 | INFO     | uvicorn.protocols.http.httptools_impl:send:483 - 192.168.1.24:0 - "GET /api/v1/chats/187ac1e6-c2fb-4f32-9b59-42753cfb7d15 HTTP/1.1" 200
2026-06-19 09:23:26.636 | INFO     | uvicorn.protocols.http.httptools_impl:send:483 - 192.168.1.24:0 - "GET /api/v1/chats/187ac1e6-c2fb-4f32-9b59-42753cfb7d15/tags HTTP/1.1" 200
2026-06-19 09:23:26.664 | INFO     | uvicorn.protocols.http.httptools_impl:send:483 - 192.168.1.24:0 - "GET /api/tasks/chat/187ac1e6-c2fb-4f32-9b59-42753cfb7d15 HTTP/1.1" 200
2026-06-19 09:23:26.762 | WARNING  | open_webui.utils.oauth:get_oauth_token:816 - No OAuth session found for user ab26de12-9cc9-424a-8539-7dbbd70cb030, client_id mcp:ms-365
2026-06-19 09:23:26.764 | INFO     | uvicorn.protocols.http.httptools_impl:send:483 - 192.168.1.24:0 - "GET /api/v1/tools/ HTTP/1.1" 200
2026-06-19 09:23:26.783 | INFO     | uvicorn.protocols.http.httptools_impl:send:483 - 192.168.1.24:0 - "GET /api/v1/skills/ HTTP/1.1" 200
2026-06-19 09:23:29.979 | INFO     | uvicorn.protocols.http.httptools_impl:send:483 - 192.168.1.24:0 - "GET /oauth/clients/mcp%3Ams-365/authorize HTTP/1.1" 500
Exception in ASGI application
Traceback (most recent call last):
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 101, in map_httpcore_exceptions
    yield
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 394, in handle_async_request
    resp = await self._pool.handle_async_request(req)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpcore/_async/connection_pool.py", line 256, in handle_async_request
    raise exc from None
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpcore/_async/connection_pool.py", line 236, in handle_async_request
    response = await connection.handle_async_request(
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpcore/_async/connection.py", line 101, in handle_async_request
    raise exc
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpcore/_async/connection.py", line 78, in handle_async_request
    stream = await self._connect(request)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpcore/_async/connection.py", line 156, in _connect
    stream = await stream.start_tls(**kwargs)
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpcore/_backends/anyio.py", line 67, in start_tls
    with map_exceptions(exc_map):
  File "/usr/lib/python3.12/contextlib.py", line 158, in __exit__
    self.gen.throw(value)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpcore/_exceptions.py", line 14, in map_exceptions
    raise to_exc(exc) from exc
httpcore.ConnectError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: self-signed certificate in certificate chain (_ssl.c:1000)

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/uvicorn/protocols/http/httptools_impl.py", line 416, in run_asgi
    result = await app(  # type: ignore[func-returns-value]
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/uvicorn/middleware/proxy_headers.py", line 60, in __call__
    return await self.app(scope, receive, send)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/fastapi/applications.py", line 1160, in __call__
    await super().__call__(scope, receive, send)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/applications.py", line 90, in __call__
    await self.middleware_stack(scope, receive, send)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/middleware/errors.py", line 186, in __call__
    raise exc
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/middleware/errors.py", line 164, in __call__
    await self.app(scope, receive, _send)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/middleware/sessions.py", line 88, in __call__
    await self.app(scope, receive, send_wrapper)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/middleware/cors.py", line 88, in __call__
    await self.app(scope, receive, send)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/open_webui/utils/asgi_middleware.py", line 213, in __call__
    await self.app(scope, receive, send)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/open_webui/utils/asgi_middleware.py", line 177, in __call__
    await self.app(scope, receive, send_with_timing)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/open_webui/utils/asgi_middleware.py", line 98, in __call__
    await self.app(scope, receive, send)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/middleware/base.py", line 193, in __call__
    response = await self.dispatch_func(request, call_next)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/open_webui/utils/security_headers.py", line 11, in dispatch
    response = await call_next(request)
               ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/middleware/base.py", line 168, in call_next
    raise app_exc from app_exc.__cause__ or app_exc.__context__
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/middleware/base.py", line 144, in coro
    await self.app(scope, receive_or_disconnect, send_no_error)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/open_webui/utils/asgi_middleware.py", line 264, in __call__
    await self.app(scope, receive, send)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette_compress/__init__.py", line 104, in __call__
    return await self._zstd(scope, receive, send)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette_compress/_zstd_legacy.py", line 107, in __call__
    await self.app(scope, receive, wrapper)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/middleware/exceptions.py", line 63, in __call__
    await wrap_app_handling_exceptions(self.app, conn)(scope, receive, send)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/_exception_handler.py", line 53, in wrapped_app
    raise exc
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/_exception_handler.py", line 42, in wrapped_app
    await app(scope, receive, sender)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/fastapi/middleware/asyncexitstack.py", line 18, in __call__
    await self.app(scope, receive, send)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/routing.py", line 660, in __call__
    await self.middleware_stack(scope, receive, send)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/routing.py", line 680, in app
    await route.handle(scope, receive, send)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/routing.py", line 276, in handle
    await self.app(scope, receive, send)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/fastapi/routing.py", line 130, in app
    await wrap_app_handling_exceptions(app, request)(scope, receive, send)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/_exception_handler.py", line 53, in wrapped_app
    raise exc
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/starlette/_exception_handler.py", line 42, in wrapped_app
    await app(scope, receive, sender)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/fastapi/routing.py", line 116, in app
    response = await f(request)
               ^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/fastapi/routing.py", line 670, in app
    raw_response = await run_endpoint_function(
                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/fastapi/routing.py", line 324, in run_endpoint_function
    return await dependant.call(**values)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/open_webui/main.py", line 2786, in oauth_client_authorize
    return await oauth_client_manager.handle_authorize(request, client_id=client_id)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/open_webui/utils/oauth.py", line 969, in handle_authorize
    return await client.authorize_redirect(request, redirect_uri_str, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/authlib/integrations/starlette_client/apps.py", line 36, in authorize_redirect
    rv = await self.create_authorization_url(redirect_uri, **kwargs)
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/authlib/integrations/base_client/async_app.py", line 100, in create_authorization_url
    metadata = await self.load_server_metadata()
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/authlib/integrations/base_client/async_app.py", line 79, in load_server_metadata
    resp = await client.request(
           ^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/authlib/integrations/httpx_client/oauth2_client.py", line 119, in request
    return await super().request(method, url, auth=auth, **kwargs)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1540, in request
    return await self.send(request, auth=auth, follow_redirects=follow_redirects)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1629, in send
    response = await self._send_handling_auth(
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1657, in _send_handling_auth
    response = await self._send_handling_redirects(
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1694, in _send_handling_redirects
    response = await self._send_single_request(request)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpx/_client.py", line 1730, in _send_single_request
    response = await transport.handle_async_request(request)
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 393, in handle_async_request
    with map_httpcore_exceptions():
  File "/usr/lib/python3.12/contextlib.py", line 158, in __exit__
    self.gen.throw(value)
  File "/home/sergiomcp/.venv/lib/python3.12/site-packages/httpx/_transports/default.py", line 118, in map_httpcore_exceptions
    raise mapped_exc(message) from exc
httpx.ConnectError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: self-signed certificate in certificate chain (_ssl.c:1000)
