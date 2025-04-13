FROM node:18-slim

USER root

RUN apt-get update && apt-get install -y \
    python3 python3-pip \
    libxml2-dev libxslt1-dev zlib1g-dev \
    curl gnupg gnupg2 ca-certificates

RUN npm install -g n8n@1.88.0

WORKDIR /usr/local/mcp
COPY ./mcp_extrator.py ./mcp_extrator.py
COPY ./requirements.txt ./requirements.txt

# ⚠️ Instala pacotes Python mesmo com PEP 668 ativado
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

USER node

EXPOSE 5678
CMD ["n8n"]

