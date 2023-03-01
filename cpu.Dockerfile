FROM python:3.10-slim

# Install poetry
WORKDIR /app
RUN pip install --no-cache-dir --upgrade pip==22.3.1 && \
    pip install --no-cache-dir poetry==1.2.2 && \
    rm -rf /root/.cache/pip

# Install pip dependencies
COPY pyproject.toml poetry.lock /app/
RUN poetry install --no-root --no-interaction

# git settings
COPY .gitconfig /root/.gitconfig

COPY . /app/
