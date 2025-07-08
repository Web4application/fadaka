import streamlit as st
import pandas as pd

# Load data
df = pd.read_csv("erc1155_mints.csv", header=None)
df.columns = [
    "tx_hash", "block_number", "timestamp", "datetime", 
    "from_address", "to_contract", "to_address", 
    "meta1", "meta2", "value", "token_type", "confirmed"
]

st.title("🧾 ERC-1155 Token Mint Viewer")

# Filter by wallet or token
wallet = st.text_input("🔍 Filter by Wallet Address (to_address):")
token_id = st.text_input("🔍 Filter by Token ID:")

filtered = df
if wallet:
    filtered = filtered[filtered['to_address'].str.lower() == wallet.lower()]

if token_id:
    filtered = filtered[filtered['meta1'] == token_id]

# Show result
st.subheader("🔢 Matching Transfers")
st.write(filtered)

# Summary
st.subheader("📊 Summary")
st.write(f"Total Transfers: {len(filtered)}")
if not filtered.empty:
    st.write("Most Recent:", filtered.iloc[-1]["datetime"])
