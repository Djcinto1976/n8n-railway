FROM n8nio/n8n

# Troca para usuário root para poder instalar pacotes globalmente
USER root

# Instala o pacote n8n-nodes-mcp
RUN npm install -g n8n-nodes-mcp

# Cria o diretório caso não exista e copia o arquivo Server.js
RUN mkdir -p /usr/local/lib/node_modules/n8n/dist/src && \
    cp /Server.js /usr/local/lib/node_modules/n8n/dist/src/

# Volta ao usuário padrão do n8n
USER node




