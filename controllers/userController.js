const User = require('../models/user.model');
const s3 = require('../services/s3.service');
const fs = require('fs');

class userController {
    static async addUser(req, res, next) {
        try {
            const {
                name,
                userId,
                phone,
                role,
                verificationId,
                polygonId,
                district,
                city,
                state,
                locality,
                location,
                image
            } = req.body;
            
            // You can include image upload logic here if needed

            try {
                const user = new User({
                    name: name,
                    userId: userId,
                    phone: phone,
                    role: role,
                    verificationId: verificationId,
                    location: location,
                    polygonId: polygonId,
                    district: district,
                    city: city,
                    state: state,
                    locality: locality,
                    image: image,
                });

                await user.save();

                res.status(201).json({ message: 'User added successfully', user: user });
            } catch (saveErr) {
                console.error('Error while saving user:', saveErr);
                res.status(500).json({ error: 'Error while saving user' });
            }
        } catch (err) {
            console.error('Error while uploading image:', err);
            res.status(500).json({ error: 'Error uploading image' });
        }
    }

    static async getUser(req, res, next) {
        try {
            const userId = req.params.userid; 

            const user = await User.findOne({ userId: userId });
            if (!user) {
                res.status(404).json({ error: 'User not found' });
                return;
            }
            res.status(200).json({ user: user });
        } catch (err) {
            console.error('Error while getting user:', err);
            res.status(500).json({ error: 'Error while getting user' });
        }
    }
}

module.exports = userController;
