FROM n8nio/n8n:1.88.0

USER root
RUN apt-get update && apt-get install -y python3 python3-pip libxml2-dev libxslt1-dev zlib1g-dev

WORKDIR /usr/local/mcp

COPY ./mcp_extrator.py ./mcp_extrator.py
COPY ./requirements.txt ./requirements.txt

RUN pip3 install --no-cache-dir -r requirements.txt

USER node
