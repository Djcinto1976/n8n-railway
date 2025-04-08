FROM n8nio/n8n

# Troca para o usuário root temporariamente
USER root

# Instala o pacote n8n-nodes-mcp globalmente
RUN npm install -g n8n-nodes-mcp

# Volta para o usuário padrão do n8n
USER node





