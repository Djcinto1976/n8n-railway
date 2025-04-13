# Usa a versão Debian da imagem oficial do n8n
FROM n8nio/n8n:1.88.0-debian

# Habilita root para instalar Python e dependências nativas
USER root

# Atualiza pacotes e instala Python + dependências do PDF
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    && apt-get clean

# Diretório para o script Python
WORKDIR /usr/local/mcp

# Copia o script Python e o requirements.txt
COPY ./mcp_extrator.py ./mcp_extrator.py
COPY ./requirements.txt ./requirements.txt

# Instala as dependências Python necessárias para extração de dados
RUN pip3 install --no-cache-dir -r requirements.txt

# Retorna ao usuário padrão do n8n
USER node
