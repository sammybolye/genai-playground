# Use the base image
FROM us-docker.pkg.dev/deeplearning-platform-release/gcr.io/workbench-container:latest

# Create the directory for Code Server binary
RUN mkdir -p /opt/code-server/bin

# Download the Code Server binary
RUN wget https://github.com/coder/code-server/releases/download/v4.96.2/code-server_4.96.2_amd64.deb && \
    dpkg -i code-server_4.96.2_amd64.deb

# Set ownership to the jupyter user
RUN chown -R jupyter:jupyter /usr/bin/code-server

# Create the utilities directory
RUN mkdir -p /opt/utilities

# Copy the start-codeserver.sh script
COPY start-codeserver.sh /opt/utilities/start-codeserver.sh

COPY jupyter-notebook-config.py /tmp/jupyter-notebook-config.py

RUN cat /tmp/jupyter-notebook-config.py >> /opt/jupyter/.jupyter/jupyter_notebook_config.py
COPY vscode.svg /opt/jupyter/.jupyter/vscode.svg

RUN chown jupyter:jupyter /opt/jupyter/.jupyter/vscode.svg

# Make the script executable
RUN chmod +x /opt/utilities/start-codeserver.sh

# Set ownership to the jupyter user
RUN chown -R jupyter:jupyter /opt/utilities
