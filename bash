go run cmd/fadaka_keys.go generate
go run cmd/fadaka_keys.go sign fadaka_private.pem tx.json
go run cmd/fadaka_keys.go verify fadaka_public.pem signed_tx.json

cd contracts/hello
make build

go run vm/runner.go

fadaka-cli deploy SovereignIdentity --upgradeable
fadaka-cli deploy DAOModerator --trust-gated
fadaka-cli deploy QuestEngine --agent Web4Node
fadaka-cli deploy VaultTreasury --strategy AI
