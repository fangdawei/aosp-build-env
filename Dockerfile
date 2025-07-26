FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

RUN apt-get update && \
    apt-get install -y sudo

ENV USER="david"
ENV PASSWD="david"

RUN useradd -m ${USER} && \
    echo "${USER}:${PASSWD}" | chpasswd

RUN usermod -aG sudo ${USER}

RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER}
WORKDIR /home/${USER}

RUN sudo apt-get install -y git-core gnupg flex bison build-essential \
zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev \
lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig

RUN sudo apt-get install -y repo

