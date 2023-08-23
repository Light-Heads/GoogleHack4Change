const express = require('express');
const router = express.Router();

// Routes for uploading video to the server
const {uploadVideo} = require('../middleware/storage.js');
const videoController = require('../controllers/videoController.js');


router.route('/upload').post(uploadVideo.single('video'), videoController.upload);
router.route('/videos').get(videoController.getVideo);
router.route('/like').post(videoController.likeVideo);



module.exports = router;
