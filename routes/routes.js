const express = require('express');
const router = express.Router();

router.use('/api', require('./content.routes.js'));
router.use('/api', require('./user.routes.js'));

module.exports = router;

