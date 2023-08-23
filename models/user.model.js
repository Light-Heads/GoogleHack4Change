const { model, Schema } = require('mongoose');

const userSchema = new Schema({
    name: {
        type: String,
        required: true,
        trim: true
    },
    
    userId: {
        type: String,
        required: true,
    },
    
    phone: {
        type: String,
        required: true,
        trim: true
    },

    role: {
        type: String,
        default: 'farmer'
    },

    verificationId: {
        type: String,
    },

    location: {
        type: [Number],
    },

    polygonId: {
        type: String,
    },

    district: {
        type: String,
    },

    city: {
        type: String,
    },

    state: {
        type: String,
    },

    locality: {
        type: String,
    },

    image: {
        type: String,
    },

    products: {
        type: [String],
    },
});

module.exports = model('User', userSchema);




