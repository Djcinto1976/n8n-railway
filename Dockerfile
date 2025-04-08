FROM n8nio/n8n

# Instala o pacote MCP
RUN npm install -g n8n-nodes-mcp


COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

