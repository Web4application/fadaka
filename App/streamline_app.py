import streamlit as st, pandas as pd, requests
from datetime import datetime
from .settings import settings
from .blockchain import fetch_events, token_uri, w3

st.set_page_config(page_title="Fadaka ERC‑1155 Dashboard", layout="wide")
st.title("📦 Fadaka ERC‑1155 Live Dashboard")

# Block input
start_block = st.number_input("Fetch from block", value=0, step=1)
events = fetch_events(start_block)

if not events:
    st.warning("No events yet."); st.stop()

df = pd.DataFrame(events)
df["datetime"] = pd.to_datetime(df["ts"], unit="s", utc=True)

# Sidebar filters
st.sidebar.header("Filters")
wallet = st.sidebar.text_input("Wallet (from/to)")
tok   = st.sidebar.text_input("Token ID")

if wallet:
    wallet = wallet.lower()
    df = df[(df["from"].str.lower()==wallet) | (df["to"].str.lower()==wallet)]
if tok:
    df = df[df["token_id"] == int(tok)]

st.subheader(f"Results ({len(df)})")
st.dataframe(df)

# Preview metadata (first 10 unique IDs)
st.subheader("🖼️ Token Preview")
for tid in df["token_id"].unique()[:10]:
    try:
        meta_url = token_uri(int(tid))
        meta_json = requests.get(meta_url).json()
        st.markdown(f"**ID {tid}** – {meta_json.get('name','')}")
        if "image" in meta_json:
            st.image(meta_json["image"], width=150)
        st.write(meta_json.get("description",""))
    except Exception as e:
        st.write(f"ID {tid}: couldn’t fetch metadata ({e})")
