go run cmd/fadaka_keys.go generate
go run cmd/fadaka_keys.go sign fadaka_private.pem tx.json
go run cmd/fadaka_keys.go verify fadaka_public.pem signed_tx.json
