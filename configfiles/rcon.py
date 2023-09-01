import asyncio
from pavlov import PavlovRCON
import json
from http.server import BaseHTTPRequestHandler, HTTPServer

async def run_rcon_commands(server: str, port: int, password: str, commands : list[str]) -> list[str]:
    try:
        pavlov = PavlovRCON(server,port, password)
        result = []
        for command in commands:
            ret = await pavlov.send(command)
            print(f'{command} => {ret}')
            result.append(ret)
        return {"success": True, "result": result}
    except Exception as e:
        return {"success": False, "error": str(e)}


class MyRequestHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        # Set response status code
        self.send_response(200)

        if self.path != '/rcon':
            return
        if self.headers.get('User-Agent') != 'PavlovMenu':
            return
        if self.headers.get('Content-Type') != 'application/json':
            return
        
        # Set response headers
        self.send_header('Content-Type', 'application/json')
        self.end_headers()
        # get body as json
        content_len = int(self.headers.get('Content-Length'))
        post_body = self.rfile.read(content_len)
        json_body = json.loads(post_body)
        if 'server' not in json_body or 'port' not in json_body or 'password' not in json_body or 'commands' not in json_body:
            return
        result = asyncio.run(run_rcon_commands(json_body['server'], json_body['port'], json_body['password'], json_body['commands']))
        # Send JSON response
        self.wfile.write(json.dumps(result).encode())



def run(server_class=HTTPServer, handler_class=MyRequestHandler, http_bind_address='0.0.0.0', http_port=12345):
    try:
        # Create server instance
        server_address = (http_bind_address, http_port)
        httpd = server_class(server_address, handler_class)
        print(f'Starting server at http://{http_bind_address}:{http_port}...')
        httpd.serve_forever()
    except KeyboardInterrupt:
        # Handle keyboard interrupt (Ctrl+C)
        print('\nKeyboard Interrupt received, stopping server...')
        httpd.server_close()


run(http_bind_address='127.0.0.1', http_port=11085)
