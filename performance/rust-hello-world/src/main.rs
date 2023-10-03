use actix_web::{get, App, HttpServer, Responder};
use actix_web_prom::PrometheusMetricsBuilder;
use std::collections::HashMap;

#[get("/")]
async fn index() -> impl Responder {
    "Hello, World!"
}

#[get("/_health")]
async fn health() -> impl Responder {
    "Healthy!"
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let mut labels = HashMap::new();
    labels.insert("project_name".to_string(), "rust_hello_world".to_string());
    labels.insert(
        "project_type".to_string(),
        "test_metrics_labels".to_string(),
    );
    let prometheus = PrometheusMetricsBuilder::new("api")
        .endpoint("/metrics")
        .const_labels(labels)
        .build()
        .unwrap();

    HttpServer::new(move || {
        App::new()
            .wrap(prometheus.clone())
            .service(index)
            .service(health)
    })
    .bind(("0.0.0.0", 8080))?
    .run()
    .await
}
