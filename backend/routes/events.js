const express = require('express');
const eventController = require('../controllers/eventController');
const {authenticateJWT, requireOrganizer} = require('../middlewares/authMiddleware');

const router = express.Router();

// Event CRUD routes
router.post('/create', authenticateJWT, requireOrganizer, eventController.createEvent);
router.get('/', authenticateJWT, eventController.getAllEvents);
router.get('/:id', authenticateJWT, eventController.getEventById);
router.put('/:id', authenticateJWT, requireOrganizer, eventController.updateEvent);
router.delete('/:id', authenticateJWT, requireOrganizer, eventController.deleteEvent);
// Event registration and attendance routes
router.post('/register', eventController.signUpForEvent);
router.post('/validate-attendance', authenticateJWT, requireOrganizer, eventController.validateAttendance);

module.exports = router;
