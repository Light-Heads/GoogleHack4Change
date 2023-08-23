const mongoose = require('mongoose');
const dotenv = require('dotenv');
dotenv.config();

const mongoDBURI = process.env.MONGOURI;

const connection = async () => {
    try {
        await mongoose.connect(mongoDBURI, {
            useNewUrlParser: true,
            useUnifiedTopology: true
        });
        console.log("Connected to MongoDB");
    } catch (err) {
        console.log("Error connecting to MongoDB", err);
    }
};

module.exports = connection;

