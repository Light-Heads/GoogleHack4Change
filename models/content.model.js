const mongoose = require('mongoose');
const schema = mongoose.Schema;

const contentSchema = new schema({
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: false,
        default: "No description provided"
    },
    contentId: {
        type: String,
        required: true
    },
    userId: {
        type: mongoose.Schema.Types.ObjectId,
        required: true
    },
    date: {
        type: String,
        required: false,
        default: Date.now()
    },
    downloadUrl: {
        type: String,
    },
    likes: {
        type: [String],
        required: false,
        default: []
    },
        
});

const Content = mongoose.model('Content', contentSchema);

module.exports = Content;