const { v3: uuidv3 } = require('uuid');
const s3 = require('../services/s3.service.js');
const Content = require('../models/content.model.js');
const fs = require('fs').promises;

class videoController {
    static async upload(req, res, next) {
        try {
            const { title, description, userId } = req.body;
            const namespace = uuidv3('http://localhost:3000', uuidv3.URL);
            const contentId = uuidv3(req.file.originalname, namespace);

            const fileData = await fs.readFile('./uploads/videos/' + req.file.filename);

            const uploadParams = {
                Bucket: process.env.AWS_BUCKET_NAME,
                Key: "content-videos/" + req.file.filename,
                ContentType: req.file.mimetype,
                ACL: 'public-read',
                Body: fileData,
            };

            s3.upload(uploadParams, async (err, data) => {
                if (err) {
                    console.error('Error uploading video to S3 bucket', err);
                    res.status(500).send('Error uploading video to S3 bucket');
                    return;
                }

                const downloadURL = data.Location;

                try {
                    const content = new Content({
                        title: title,
                        description: description,
                        contentId: contentId,
                        userId: userId,
                        downloadUrl: downloadURL,
                    });

                    await content.save();

                    fs.unlink('./uploads/videos/' + req.file.filename, (unlinkErr) => {
                        if (unlinkErr) {
                            console.error('Error deleting uploaded video:', unlinkErr);
                        }
                    });

                    res.status(200).send({ message: 'Video uploaded successfully', data });
                } catch (saveErr) {
                    console.error('Error while uploading video:', saveErr);
                    res.status(500).send('Error uploading video');
                }
            });
        } catch (error) {
            console.error('Error while uploading video:', error);

            if (error.name === 'ValidationError') {
                res.status(400).send('Validation error: ' + error.message);
            } else if (error.name === 'MongoError' && error.code === 11000) {
                res.status(409).send('Duplicate key error');
            } else {
                res.status(500).send('Internal server error');
            }
        }
    }
    static async getVideo(req, res, next) {
        try {
            // Get the page number and items per page from the query parameters
            const pageNumber = parseInt(req.query.pageNumber) || 1; // Default to page 1 if not provided
            const itemsPerPage = parseInt(req.query.itemsPerPage) || 10; // Default to 10 items per page if not provided
    
            // Calculate the skip value based on the page number and items per page
            const skipValue = (pageNumber - 1) * itemsPerPage;
    
            // Fetch videos based on pagination parameters
            const content = await Content.find()
                .sort({ date: -1 })
                .skip(skipValue)
                .limit(itemsPerPage);
    
            res.status(200).send(content);
        } catch (err) {
            console.log('Error getting videos', err);
            res.status(500).send('Error getting videos');
        }
    }
    static async likeVideo(req, res, next) {
        const { contentId, userId } = req.body;
        
        try {
            // Find the content by contentId
            const content = await Content.findOne({ contentId });
    
            if (!content) {
                return res.status(404).json({ error: 'Content not found' });
            }
    
            // Check if the user has already liked the content
            if (content.likes.includes(userId)) {
                return res.status(400).json({ error: 'User already liked the content' });
            }
    
            // Add the userId to the likes array
            content.likes.push(userId);
            
            // Save the updated content
            await content.save();
    
            res.status(200).json({ message: 'Like added successfully', content });
        } catch (error) {
            console.error('Error while adding like:', error);
            res.status(500).json({ error: 'Error adding like' });
        }
    }
    

}

module.exports = videoController;
