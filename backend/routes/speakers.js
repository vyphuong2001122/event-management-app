const {
  createSpeaker,
  createGuest,
  updateSpeaker,
  updateGuest,
  deleteSpeaker,
  deleteGuest,
  getAllSpeakers,
  getSpeakerById,
  getAllGuests,
  getGuestById,
} = require('../controllers/speakerController');
const { authenticateJWT } = require('../middlewares/authMiddleware');
const express = require('express');
const router = express.Router();

// Speaker routes
router.post('/', authenticateJWT, createSpeaker);
router.get('/', authenticateJWT, getAllSpeakers);
router.get('/:id', authenticateJWT, getSpeakerById);
router.put('/:id', authenticateJWT, updateSpeaker);
router.delete('/:id', authenticateJWT, deleteSpeaker);

// Guest routes
router.post('/guests', authenticateJWT, createGuest);
router.get('/guests', authenticateJWT, getAllGuests);
router.get('/guests/:id', authenticateJWT, getGuestById);
router.put('/guests/:id', authenticateJWT, updateGuest);
router.delete('/guests/:id', authenticateJWT, deleteGuest);

module.exports = router;
