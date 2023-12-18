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
RUN pip install azure-ai-vision

# Keep the container running
CMD ["tail", "-f", "/dev/null"]

# docker build -t my-python-app .
# docker run -it my-python-app:latest /bin/bash

