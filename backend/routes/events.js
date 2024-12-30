const express = require('express');
const eventController = require('../controllers/eventController');
const authenticateJWT = require('../middlewares/authMiddleware');

const router = express.Router();

// Event CRUD routes
router.post('/create', authenticateJWT, eventController.createEvent);
router.get('/', authenticateJWT, eventController.getAllEvents);
router.get('/:id', authenticateJWT, eventController.getEventById);
router.put('/:id', authenticateJWT, eventController.updateEvent);
router.delete('/:id', authenticateJWT, eventController.deleteEvent);

module.exports = router;
