const  AWS  = require('aws-sdk');
const dotenv = require('dotenv');
dotenv.config();

const s3 = new AWS.S3({
    accessKeyId: process.env.AWS_ACCESS_KEY_,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
    region: process.env.AWS_S3_REGION,
});



module.exports = s3;

