const { model, Schema } = require('mongoose');

const workSchema = new Schema({
    title: {
        type: String,
        required: true,
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
    location: {
        type: {
            type: String, // GeoJSON type (e.g., 'Point')
            enum: ['Point'],
            required: true
        },
        coordinates: {
            type: [Number], // [longitude, latitude]
            required: true,
        },
    },
    district: {
        type: String,
    },
    requirement: {
        type: String,
    },
    price : {
        type: String,
    },
    date: {
        type: String,
    },
});

workSchema.index({ location: '2dsphere' });

module.exports = model('Work', workSchema);
