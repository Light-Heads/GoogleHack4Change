const { model, Schema } = require('mongoose');

const productSchema = new Schema({
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
    },
    description: {
        type: String
    },
    price: {
        type: String
    },
    brand:{
        type: String
    },
    imageURL:{
        type: String
    }
});

const product = model('Product', productSchema);

module.exports = product;
