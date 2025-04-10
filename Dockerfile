FROM n8nio/n8n:1.88.0

# Troca para usuário root para poder instalar pacotes globalmente
USER root

# Limpa o cache do npm e instala o pacote n8n-nodes-mcp
RUN npm cache clean --force && npm install -g n8n-nodes-mcp

# Verifica se o pacote foi instalado corretamente
RUN npm list -g n8n-nodes-mcp

# Copia o arquivo Server.js local para dentro do container
COPY Server.js /Server.js

# Cria o diretório caso não exista e copia o arquivo Server.js para o local correto
RUN mkdir -p /usr/local/lib/node_modules/n8n/dist/src && \
    cp /Server.js /usr/local/lib/node_modules/n8n/dist/src/

# Volta ao usuário padrão do n8n
USER node
