# Use the official Node.js runtime as the base image
FROM node:latest

RUN apt-get update && apt-get install -y curl

# install artillery globally for load testing
RUN npm install -g artillery

# Set the working directory in the container to /usr/src/app
WORKDIR /usr/src/app

# copy package.json and package-lock.json
COPY ./package.json .
COPY ./package-lock.json .

# Install any needed packages specified in package.json
RUN npm install

# Copy the required files to run the app
COPY ./index.js .
COPY ./config.yaml .

# Make port 3001 available to the world outside this container
EXPOSE 3001

# Run when the container launches
CMD ["node", "."]

# Add a healthcheck
HEALTHCHECK --interval=15s --timeout=3s \
    CMD curl -f http://localhost:3001/_health || exit 1