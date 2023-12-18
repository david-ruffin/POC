# Use a base image with Python 3.9
FROM python:3.9-slim

# Create a new directory for shared access
RUN mkdir /data

# Set full access permissions for the directory
RUN chmod 777 /data

# Copy the Labfiles directory to the container
COPY ./Labfiles /data/Labfiles

# Install pip version 21.2.3
RUN python3.9 -m pip install pip==21.2.3

# Install azure-ai-vision
RUN pip install python-dotenv Pillow matplotlib numpy azure-ai-vision

# Install system packages required for Python libraries
RUN apt-get update && \
    apt-get install -y git libgl1-mesa-glx vi && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Keep the container running
CMD ["tail", "-f", "/dev/null"]

# docker build -t my-python-app .
# docker run -it my-python-app:latest /bin/bash
