FROM node:18-slim

# Instala dependências
RUN apt-get update && apt-get install -y \
    python3 python3-pip \
    libxml2-dev libxslt1-dev zlib1g-dev \
    curl gnupg gnupg2 ca-certificates

# Instala versão fixa do n8n
RUN npm install -g n8n@1.88.0

# Diretório para o script
WORKDIR /usr/local/mcp
COPY ./mcp_extrator.py ./mcp_extrator.py
COPY ./requirements.txt ./requirements.txt

# Instala libs Python
RUN pip3 install --no-cache-dir -r requirements.txt

EXPOSE 5678

CMD ["n8n"]
