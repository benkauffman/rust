const express = require('express');
const promBundle = require("express-prom-bundle");

const app = express();

// Add the options to the prometheus middleware most option are for http_request_duration_seconds histogram metric
const metricsMiddleware = promBundle({
    includeMethod: true,
    includePath: true,
    includeStatusCode: true,
    includeUp: true,
    customLabels: {
        project_name: 'node_hello_world',
        project_type: 'test_metrics_labels'
    },
    promClient: {
        collectDefaultMetrics: {
        }
    }
});

// add the prometheus middleware to all routes
app.use(metricsMiddleware)

// default endpoint 
app.get("/", (req, res) => res.send("Hello, World!"));

// health check endpoint 
app.get("/_health", (req, res) => res.send("Healthy!"));

app.listen(8081, function () {
    console.log('Listening at http://localhost:8081');
});