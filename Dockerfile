FROM n8nio/n8n

# Troca para o usuário root temporariamente
USER root

# Instala o pacote n8n-nodes-mcp globalmente
RUN npm install -g n8n-nodes-mcp

RUN echo "app.set('trust proxy', 1);" >> /usr/local/lib/node_modules/n8n/dist/src/Server.js

# Volta para o usuário padrão do n8n
USER node





