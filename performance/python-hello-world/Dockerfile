# Use a base image with Python
FROM python:latest

# Optionally set a working directory
WORKDIR /usr/src/app

# Copy your source code into the image
COPY ./requirements.txt ./requirements.txt

# Install required dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy your source code into the image
COPY ./server.py ./server.py

# Expose the necessary port (if your app serves HTTP, for example)
EXPOSE 8082

# Specify the command to run your app
CMD ["python", "server.py"]

# Adjust the healthcheck to match your app's behavior
HEALTHCHECK --interval=15s --timeout=3s \
    CMD curl -f http://localhost:8082/_health || exit 1