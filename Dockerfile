FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y ca-certificates

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak

RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse" > /etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-backports main restricted universe multiverse" >> /etc/apt/sources.list && \
    echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y sudo zsh curl git iputils-ping

ENV USER="david"
ENV PASSWD="david"

RUN useradd -m ${USER} && echo "${USER}:${PASSWD}" | chpasswd

RUN usermod -aG sudo ${USER}

RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER}
WORKDIR /home/${USER}

ENV GIT_USER="fangdawei"
ENV GIT_EMAIL="fangdawei.www@gmail.com"

RUN git config --global user.name ${GIT_USER} && \
    git config --global user.email ${GIT_EMAIL}

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

RUN sed -i 's/^plugins=.*/plugins=(git zsh-autosuggestions)/' ~/.zshrc

RUN sudo apt-get install -y git-core rsync gnupg flex bison build-essential \
zip curl zlib1g-dev libc6-dev-i386 x11proto-core-dev libx11-dev \
lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig

RUN sudo apt-get install -y repo