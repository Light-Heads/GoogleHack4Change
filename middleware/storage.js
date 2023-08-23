const multer = require('multer');
const path = require('path');

// Set up storage and file filter for image uploads
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        if (file.mimetype.startsWith('video')) {
            cb(null, path.join(__dirname, '../uploads/videos')); // Destination folder for uploaded videos
        } else if (file.mimetype.startsWith('image')) {
            cb(null, path.join(__dirname, '../uploads/images')); // Destination folder for uploaded images
        } else {
            cb(new Error('Invalid file type'));
        }
    },
    filename: function (req, file, cb) {
        cb(null, Date.now() + '-' + file.originalname); // Use a timestamp-based filename
    }
});

const videoFilter = (req, file, cb) => {
    // Accept only videos
    if (
        file.mimetype === 'video/mp4' ||
        file.mimetype === 'video/mpeg' ||
        file.mimetype === 'video/ogg' ||
        file.mimetype === 'video/quicktime' ||
        file.mimetype === 'video/webm'
    ) {
        cb(null, true);
    } else {
        cb(null, false);
    }
};

const imageFilter = (req, file, cb) => {
    // Accept only images
    if (
        file.mimetype === 'image/jpeg' ||
        file.mimetype === 'image/png' ||
        file.mimetype === 'image/jpg' ||
        file.mimetype === 'image/gif'
    ) {
        cb(null, true);
    } else {
        cb(null, false);
    }
};

const uploadVideo = multer({
    storage: storage,
    fileFilter: videoFilter,
    onError: function (err, next) {
        console.error('Error during video upload:', err);
        next(err);
    }
});

const uploadImage = multer({
    storage: storage,
    fileFilter: imageFilter,
    onError: function (err, next) {
        console.error('Error during image upload:', err);
        next(err);
    }
});

module.exports = { uploadVideo, uploadImage };
