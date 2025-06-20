use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn sign_transaction(tx_hex: &str, priv_key: &str) -> String {
    // Simulate a signature process
    format!("signed({})_with_key({})", tx_hex, priv_key)
}

#[wasm_bindgen]
pub fn hello_fadaka() -> String {
    "Hello from Fadaka WASM!".to_string()
}
