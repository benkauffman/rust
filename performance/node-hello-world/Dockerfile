# Use the official Node.js runtime as the base image
FROM node:latest

RUN apt-get update && apt-get install -y curl

# Set the working directory in the container to /usr/src/app
WORKDIR /usr/src/app

# copy package.json and package-lock.json
COPY ./package.json .
COPY ./package-lock.json .

# Install any needed packages specified in package.json
RUN npm install

# Copy the current directory contents into the container at /usr/src/app
COPY . /usr/src/app/

# Make port 8081 available to the world outside this container
EXPOSE 8081

# Run when the container launches
CMD ["node", "."]

# Add a healthcheck
HEALTHCHECK --interval=15s --timeout=3s \
    CMD curl -f http://localhost:8081/_health || exit 1