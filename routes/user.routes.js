const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController.js');
const workerController = require('../controllers/workerController.js');
const productController = require('../controllers/productController.js');

router.route('/addUser').post(userController.addUser);
router.route('/getUser/:userid').get(userController.getUser);
router.route('/work').post(workerController.addWork);
router.route('/work').get(workerController.getWork);
router.route('/getWorkById/:userId').get(workerController.getWorkById);
router.route('/work').delete(workerController.deleteWork);
router.route('/products').get(productController.getProducts);

module.exports = router;
