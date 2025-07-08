import os
from pydantic import BaseSettings, AnyUrl

class Settings(BaseSettings):
    fadaka_rpc: AnyUrl = "http://localhost:8545"
    contract_addr: str = "0xb99925ea17c3780e8b96b4254b911364434be7cc"
    refresh_seconds: int = 60
    basic_auth_user: str = "admin"
    basic_auth_pass: str = "change-me"

settings = Settings(_env_file=".env", _env_file_encoding="utf-8")
