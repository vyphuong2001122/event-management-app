const express = require('express');
const router = express.Router();
const { getUserTickets } = require('../controllers/ticketController');
const { authenticateJWT } = require('../middlewares/authMiddleware');

router.get('/myticket', authenticateJWT, getUserTickets);

module.exports = router;