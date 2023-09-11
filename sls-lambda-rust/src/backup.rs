use log;
use lambda_runtime::{run, service_fn, Error, LambdaEvent};
use serde_json::{json, Value};

#[tokio::main]
async fn main() -> Result<(), Error> {
    run(service_fn(func)).await?;
    Ok(())
}

async fn func(event: LambdaEvent<Value>) -> Result<Value, Error> {
    log::info!("event: {:?}", event);
    let (event, _context) = event.into_parts();
    let name = event["name"].as_str().unwrap_or("world");

    Ok(json!({ "message": format!("Hello, {}!", name) }))
}

#[cfg(test)]
mod tests {
    use super::*;
    use lambda_runtime::Context;

    #[tokio::test]
    async fn handler_default_parameter() {
        let event = LambdaEvent::new(json!({}), Context::default());
        assert_eq!(
            func(event.clone()).await.expect("expected Ok(_) value"),
            json!({"message": "Hello, world!"})
        )
    }

    #[tokio::test]
    async fn handler_custom_parameter() {
        let event = LambdaEvent::new(json!({"name": "Ben"}), Context::default());
        assert_eq!(
            func(event.clone()).await.expect("expected Ok(_) value"),
            json!({"message": "Hello, Ben!"})
        )
    }
}
