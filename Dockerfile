# Use a base image with Python 3.9
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /usr/src/app

RUN chmod -R 777 /usr/src/app


# Install Git
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install pip version 21.2.3
RUN python3.9 -m pip install pip==21.2.3

# Install azure-ai-vision
RUN pip install azure-ai-vision

# Verify the installation
RUN python3.9 -V && python3.9 -m pip -V

# Keep the container running
CMD ["tail", "-f", "/dev/null"]

# docker build -t my-python-app .
# docker run -it my-python-app /bin/bash


