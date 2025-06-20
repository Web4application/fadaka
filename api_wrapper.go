package main

import (
	"crypto/tls"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
)

func getFadakaPrice() string {
	apiURL := "https://api.mockservice.com/price/fdak"

	// Optional: Set custom TLS config if you need client certificates
	tlsConfig := &tls.Config{
		InsecureSkipVerify: false, // Set to true for testing only
	}

	transport := &http.Transport{TLSClientConfig: tlsConfig}
	client := &http.Client{Transport: transport}

	req, err := http.NewRequest("GET", apiURL, nil)
	if err != nil {
		fmt.Println("❌ Request creation failed:", err)
		return ""
	}

	// Add Fadaka token or any headers if required
	req.Header.Add("Authorization", "Bearer "+os.Getenv("FADAKA_API_TOKEN"))

	resp, err := client.Do(req)
	if err != nil {
		fmt.Println("❌ API call failed:", err)
		return ""
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Println("❌ Failed to read response:", err)
		return ""
	}

	return string(body)
}
