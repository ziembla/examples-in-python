FROM ubuntu:xenial

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
        python3 \
        python3-nose-parameterized \
        python3-numpy \
        python3-sklearn \
        python3-pip \
        python3-bs4 \
        python3-pandas \
        build-essential \
        git \
        sudo
RUN rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip \
    && pip3 install theanets

ARG username
ARG userid

ARG home=/home/${username}
ARG workdir=${home}/thoughtful-ml-py

RUN adduser ${username} --uid ${userid} --gecos '' --disabled-password \
    && echo "${username} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${username} \
    && chmod 0440 /etc/sudoers.d/${username}

RUN ln -s /usr/bin/python3 /usr/bin/python

WORKDIR ${workdir}
RUN chown ${username}:${username} ${workdir}

USER ${username}

RUN echo 'alias ll="ls -alF"' >> ${home}/.bashrc
