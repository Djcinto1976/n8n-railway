# Usa a imagem oficial do n8n
FROM n8nio/n8n:1.88.0

# Instala o Python e pacotes auxiliares como pip e build-essential
USER root
RUN apt-get update && apt-get install -y python3 python3-pip

# Cria uma pasta para seu script
WORKDIR /usr/local/mcp

# Copia o script e requisitos
COPY ./mcp_extrator.py ./mcp_extrator.py
COPY ./requirements.txt ./requirements.txt

# Instala as dependências do Python
RUN pip3 install --no-cache-dir -r requirements.txt

# Retorna o usuário original do n8n
USER node