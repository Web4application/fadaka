package assembly

import (
    "encoding/json"
    "fmt"
    "os"
)

var SignatureMap map[string]string

func LoadSignatureMap() {
    SignatureMap = make(map[string]string)
    file, err := os.ReadFile("assembly/signature_map.json")
    if err != nil {
        fmt.Println("Could not load signature map:", err)
        return
    }
    json.Unmarshal(file, &SignatureMap)
}

func DecodeSelector(hex4Bytes string) string {
    if sig, ok := SignatureMap[hex4Bytes]; ok {
        return sig
    }
    return "Unknown function selector"
}
