# Usar a imagem base do Ubuntu com suporte a GPU da Nvidia
FROM nvidia/cuda:12.2.2-base-ubuntu22.04

# Definir variáveis de ambiente
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependências básicas
RUN apt-get update && apt-get install -y \
    openssh-server \
    python3.10 \
    python3-pip \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Criar usuário "jun" com senha "1234"
RUN useradd -m -s /bin/bash jun && \
    echo 'jun:1234' | chpasswd

# Configurar o SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/#Port 22/Port 23/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Instalar bibliotecas Python adicionais (opcional)
RUN python3.10 -m pip install --upgrade pip

# Expor a porta 23 para SSH
EXPOSE 23

# Comando para iniciar o SSH
CMD ["/usr/sbin/sshd", "-D"]