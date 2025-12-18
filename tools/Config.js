module.exports = {
    // Blockchain Configuration
    blockchain: {
        difficulty: 4,                // Number of leading zeros required for proof of work (mining difficulty)
        miningReward: 100,            // Reward for mining a new block
        networkName: 'Fadaka Network', // Name of the blockchain network (can be used for logging or UI purposes)
    },

    // Wallet Configuration
    wallet: {
        defaultBalance: 1000,         // Default balance for new wallets (optional)
        keyPairGeneration: {
            modulusLength: 2048,      // RSA key length for public/private key generation
        },
    },

    // API Configuration
    api: {
        port: 3000,                   // Port for the API server to run on
        enableCors: true,             // Enable or disable Cross-Origin Resource Sharing (CORS)
        apiVersion: '1.0.0',          // API versioning
        allowedOrigins: ['http://localhost:3000', 'https://fadaka-app.com'], // Allowed client origins for CORS
    },

    // Logging Configuration
    logging: {
        level: 'info',                // Logging level: 'debug', 'info', 'warn', 'error'
        logToFile: true,              // Option to log to a file (if true, specify file path)
        logFilePath: './logs/blockchain.log', // File path for logging (optional)
    },

    // Network Configuration (Optional, for future enhancements if the blockchain becomes a public network)
    network: {
        nodes: [
            'http://node1.fadaka.com:3000',
            'http://node2.fadaka.com:3000',
        ],                             // Array of other node URLs in the network
        peerDiscovery: true,           // Enable peer discovery between nodes
        syncInterval: 300000,          // Interval to synchronize nodes (in ms)
    },

    // Security Configuration (Optional, can enhance security aspects in the future)
    security: {
        encryption: {
            algorithm: 'aes-256-cbc', // Algorithm used for encrypting sensitive data (e.g., wallet private keys)
            key: 'your-secret-key-here', // Encryption key (use environment variables for production)
        },
        rateLimit: {
            enabled: true,            // Enable rate limiting for API requests
            maxRequests: 100,         // Max number of requests per minute
            windowMs: 60000,          // Time window in milliseconds (e.g., 60,000ms = 1 minute)
        },
    },
};

require('dotenv').config();

module.exports = {
    security: {
        encryption: {
            key: process.env.ENCRYPTION_KEY, // Use environment variable
        },
    },
};
