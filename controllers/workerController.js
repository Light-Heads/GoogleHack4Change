const Work = require('../models/work.model');

class workerController {
    static async addWork(req, res, next) {
        const {
            title,
            name,
            userId,
            phone,
            location,
            district,
            city,
            state,
            locality,
            price,
        } = req.body;
        try {
            console.log("Test");
            const work = new Work({
                title: title,
                name: name,
                phone: phone,
                location: location,
                userId: userId,
                district: district,
                city: city,
                state: state,
                locality: locality,
                work: work,
                price: price,
            });
            await work.save();
            res.status(200).send({ message: 'Work added successfully' });
        }
        catch (error) {
            console.error('Error while adding work:', error);
            if (error.name === 'ValidationError') {
                res.status(400).send('Validation error: ' + error.message);
            }
            else if (error.name === 'MongoError' && error.code === 11000) {
                res.status(409).send('Duplicate key error');
            }
            else {
                res.status(500).send('Error adding work');
            }
        }
    }
    static async getWork(req, res, next) {
        const { location, radius } = req.body; // Get location and radius from query parameters
        const radiusInKm = radius ? parseFloat(radius) : 20; // Use provided radius or default to 20 km
        const radiusInMeters = radiusInKm * 1000; // Convert radius to meters
        try {
            const workers = await Work.find({
                location: {
                    $near: {
                        $maxDistance: radiusInMeters,
                        $geometry: {
                            type: 'Point',
                            coordinates: [location[0], location[1]],
                        },
                    },
                },
            });
            res.status(200).send({ workers: workers });
        } catch (error) {
            console.error('Error while getting workers:', error);
            res.status(500).send('Error getting workers');
        }
    }
    static async deleteWork(req, res, next) {
        try {
            const { id } = req.body._id;
            await Work.findByIdAndDelete(id);
            res.status(200).send({ message: 'Work deleted successfully' });
        } catch (error) {
            console.error('Error while deleting work:', error);
            res.status(500).send('Error deleting work');
        }
    }
    static async getWorkById(req, res, next) {
        try {
            const { id } = req.params.userId;
            const work = await Work.findById(id);
    
            if (!work) {
                res.status(404).send('Work not found');
                return;
            }
    
            res.status(200).send({ work: work });
        } catch (error) {
            console.error('Error while getting work:', error);
            res.status(500).send('Error getting work');
        }
    }

}

module.exports = workerController;