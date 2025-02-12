const express = require('express');
const { createEventReview, createSpeakerReview } = require('../controllers/reviewController');
const { authenticateJWT } = require('../middlewares/authMiddleware'); // Ensure the user is logged in

const router = express.Router();

router.post('/event/:eventId', authenticateJWT, createEventReview);
router.post('/speaker/:speakerId', authenticateJWT, createSpeakerReview);

module.exports = router;
