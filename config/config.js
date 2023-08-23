const dotenv = require('dotenv');

dotenv.config();

const {
    PORT,
    HOST,
    HOST_URL,
    MONGOURI,
    FIREBASE_AUTH_DOMAIN,
    FIREBASE_API_KEY,
    FIREBASE_PROJECT_ID,
    FIREBASE_STORAGE_BUCKET,
    FIREBASE_MESSAGING_SENDER_ID,
    FIREBASE_APP_ID,
    FIREBASE_DATABASE_URL,
    type,
    project_id,
    private_key_id,
    private_key,
    client_email,
    client_id,
    auth_uri,
    token_uri,
    auth_provider_x509_cert_url,
    client_x509_cert_url,
    B2_APPLICATION_KEY,
    B2_ACCOUNT_ID,
    B2_BUCKET_ID,

} = process.env;


module.exports = {
    PORT: PORT,
    host: HOST,
    url: HOST_URL,
    firebaseConfig: {
        apiKey: FIREBASE_API_KEY,
        authDomain: FIREBASE_AUTH_DOMAIN,
        databaseURL: FIREBASE_DATABASE_URL,
        projectId: FIREBASE_PROJECT_ID,
        storageBucket : FIREBASE_STORAGE_BUCKET,
        messagingSenderId: FIREBASE_MESSAGING_SENDER_ID,
        appId: FIREBASE_APP_ID,
    },
    firebaseServiceAccount: {
        type: type,
        project_id: project_id,
        private_key_id: private_key_id,
        private_key: private_key,
        client_email: client_email,
        client_id: client_id,
        auth_uri: auth_uri,
        token_uri: token_uri,
        auth_provider_x509_cert_url: auth_provider_x509_cert_url,
        client_x509_cert_url: client_x509_cert_url,
    },
    mongoURI: MONGOURI,
    blackBlaze: {
        applicationKeyId: B2_ACCOUNT_ID,
        applicationKey: B2_APPLICATION_KEY,
        bucketId: B2_BUCKET_ID,
    },
};