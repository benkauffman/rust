# Performance Testing Project

This project aims to evaluate and compare the performance of different web frameworks across various programming languages. The services are containerized using Docker to ensure a consistent testing environment, and the performance metrics are collected and visualized using Prometheus and Grafana.

## Project Structure

This repository is organized as follows:

- Service directories for each language/framework (e.g., `rust-hello-world`, `node-hello-world`, `python-hello-world`, `go-hello-world`, `java-hello-world`)
- `artillery`: contains the configuration for performance testing using [Artillery](https://artillery.io/).
- `docker-compose.yml`: the Docker Compose file to orchestrate the services.
- `package.json`: contains scripts for building and running the Docker containers.
- `prometheus.yml`: configuration file for Prometheus.
- `volumes`: directory to hold persistent data for Prometheus and Grafana.

## Prerequisites

Make sure you have the following installed on your machine:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Usage

1. **Build the Docker images:**

    ```bash
    npm run build
    ```

    To rebuild all images from scratch, you can use:

    ```bash
    npm run build:clean
    ```

2. **Start the services:**

    ```bash
    npm run start
    ```

    This command will spin up all the services defined in `docker-compose.yml`. Once all services are up and running, Artillery will kick off the performance tests against the hello-world endpoints of each service.

3. **Access the monitoring dashboards:**

    - Prometheus: [http://localhost:9090](http://localhost:9090)
    - Grafana: [http://localhost:3000](http://localhost:3000) (username: `admin`, password: `admin`)

4. **Stop the services:**

    Press `Ctrl+C` in the terminal where `npm run start` is running.

    Alternatively, you can stop and remove all containers with the following command:

    ```bash
    docker-compose down
    ```

5. **View test results:**

    Once the tests are completed, the results will be available in the `volumes/artillery` directory.

## Performance Testing

Performance testing is carried out by the `artillery` service, which sends HTTP requests to each hello-world service and collects metrics on the responses. The performance tests are triggered by a `start-testing` service which sends a GET request to the `artillery` service.

## Monitoring

Metrics collected from the services are scraped by Prometheus, and Grafana is used to visualize the metrics in real-time. You can create your own dashboards or import existing ones from the root of this repo.