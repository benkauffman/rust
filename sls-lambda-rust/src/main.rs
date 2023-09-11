use lambda_http::{run, service_fn, Error, Request, RequestExt};
use log;
use serde_json::{json, Value};

async fn handler(request: Request) -> Result<Value, Error> {
    log::debug!("request: {:?}", request);
    // let _context = request.lambda_context_ref();

    let name = request
        .query_string_parameters_ref()
        .and_then(|params| params.first("name"))
        .unwrap_or_else(|| "stranger");
    // let name = params
    // let name = request
    //     .query_string_parameters_ref()
    //     .and_then(|params| params.first("name"))
    //     .unwrap_or_else(|| "stranger");

    Ok(json!({ "message": format!("Hello, {}!", name) }))
}

#[tokio::main]
async fn main() -> Result<(), Error> {
    run(service_fn(handler)).await?;
    Ok(())
}
