import http.server
import socketserver
import os

# Definir a porta
PORT = 8022

# Definir o diretório do site
WEB_DIR = os.path.join(os.path.dirname(__file__), "static_site")

# Mudar para o diretório do site
os.chdir(WEB_DIR)

# Criar um servidor HTTP simples
Handler = http.server.SimpleHTTPRequestHandler

# Iniciar o servidor
with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Servindo o site na porta {PORT}. Acesse http://localhost:{PORT}")
    httpd.serve_forever()