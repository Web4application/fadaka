const crypto = require('crypto');

const config = require('../config/config');

/**
 * Generate SHA256 hash of a given input
 * @param {string} data - The data to hash
 * @returns {string} - The resulting hash in hex format
 */
function generateHash(data) {
    return crypto.createHash('sha256').update(data).digest('hex');
}

/**
 * Generate a key pair (Public and Private keys)
 * @returns {Object} - The key pair object containing publicKey and privateKey
 */
function generateKeyPair() {
    const { modulusLength } = config.wallet.keyPairGeneration;

    const { publicKey, privateKey } = crypto.generateKeyPairSync('rsa', {
        modulusLength,
        publicKeyEncoding: {
            type: 'spki',
            format: 'pem',
        },
        privateKeyEncoding: {
            type: 'pkcs8',
            format: 'pem',
        },
    });

    return { publicKey, privateKey };
}

/**
 * Sign data using the private key
 * @param {string} privateKey - The private key in PEM format
 * @param {Object} data - The data to sign
 * @returns {string} - The signature in hex format
 */
function signData(privateKey, data) {
    const sign = crypto.createSign('SHA256');
    sign.update(JSON.stringify(data));
    sign.end();
    return sign.sign(privateKey, 'hex');
}

/**
 * Verify the signature using the public key
 * @param {string} publicKey - The public key in PEM format
 * @param {Object} data - The original data
 * @param {string} signature - The signature in hex format
 * @returns {boolean} - True if the signature is valid, false otherwise
 */
function verifySignature(publicKey, data, signature) {
    const verify = crypto.createVerify('SHA256');
    verify.update(JSON.stringify(data));
    verify.end();
    return verify.verify(publicKey, signature, 'hex');
}

/**
 * Encrypt data using AES-256-CBC
 * @param {string} plaintext - The data to encrypt
 * @returns {Object} - The encrypted data object containing iv and encrypted text
 */
function encryptData(plaintext) {
    const { algorithm, key } = config.security.encryption;
    const iv = crypto.randomBytes(16);
    const cipher = crypto.createCipheriv(algorithm, Buffer.from(key), iv);
    let encrypted = cipher.update(plaintext, 'utf8', 'hex');
    encrypted += cipher.final('hex');

    return {
        iv: iv.toString('hex'),
        encryptedData: encrypted,
    };
}

/**
 * Decrypt data using AES-256-CBC
 * @param {Object} encryptionData - The data object containing iv and encrypted text
 * @returns {string} - The decrypted plaintext
 */
function decryptData(encryptionData) {
    const { algorithm, key } = config.security.encryption;
    const iv = Buffer.from(encryptionData.iv, 'hex');
    const encryptedData = encryptionData.encryptedData;

    const decipher = crypto.createDecipheriv(algorithm, Buffer.from(key), iv);
    let decrypted = decipher.update(encryptedData, 'hex', 'utf8');
    decrypted += decipher.final('utf8');

    return decrypted;
}

module.exports = {
    generateHash,
    generateKeyPair,
    signData,
    verifySignature,
    encryptData,
    decryptData,
};
