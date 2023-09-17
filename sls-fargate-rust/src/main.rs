use actix_web::{get, web, App, HttpServer, Responder};

use log;

#[get("/")]
async fn index() -> impl Responder {
    log::info!("Saying hello to the world");
    "Hello, World!"
}

#[get("/{name}")]
async fn hello(name: web::Path<String>) -> impl Responder {
    log::info!("Saying hello to {}", &name);
    format!("Hello {}!", &name)
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    simple_logger::init_with_env().unwrap();
    log::info!("Starting server at http://0.0.0.0:8080");
    HttpServer::new(|| App::new().service(index).service(hello))
        .bind(("0.0.0.0", 8080))?
        .run()
        .await
}
