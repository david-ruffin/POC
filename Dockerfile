# Use a base image with Python 3.9 and OpenSSL 1.1.1n
FROM python:3.9-slim-buster

# Create a new directory for shared access
WORKDIR /data

# Copy the Labfiles directory to the container
COPY ./Labfiles /data/Labfiles

# Install the required packages from a requirements.txt file
COPY requirements.txt /data
RUN pip install -r /data/requirements.txt

# Install system packages required for Python libraries
RUN apt-get update && \
    apt-get install -y git libgl1-mesa-glx vim wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# docker build -t open-ai-poc .
# docker run -it open-ai-poc:latest /bin/bash
# cd /data/Labfiles/01-analyze-images/Python/image-analysis/
# echo "AI_SERVICE_ENDPOINT=" > .env && echo "AI_SERVICE_KEY=" >> .env
# python image-analysis.py images/street.jpg
