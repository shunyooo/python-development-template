FROM nvidia/cuda:11.3.1-cudnn8-devel-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo

# install basic dependencies and python
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get install -y --no-install-recommends sudo git curl gcc \
    python3.10 python3.10-dev python3.10-distutils \ 
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# install pip and symlink python
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.10 && \
    ln -s /usr/bin/python3.10 /usr/bin/python

WORKDIR /app
RUN pip install --no-cache-dir --upgrade pip==22.3.1 && \
    pip install --no-cache-dir poetry==1.2.2 && \
    rm -rf /root/.cache/pip

# Install pip dependencies
COPY pyproject.toml /app/
RUN poetry install --no-root --no-interaction

# git settings
# COPY .gitconfig /root/.gitconfig

COPY . /app/
