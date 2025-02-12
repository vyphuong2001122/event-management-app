const {Event, Review, Speaker} = require('../models/index')
const { Op } = require('sequelize');

// Create a review for an event
exports.createEventReview = async (req, res) => {
  try {
    const { eventId } = req.params;
    const { rating, comment } = req.body;
    const userId = req.user.id; // Extract from token

    // Validate rating
    if (!rating || rating < 1 || rating > 5) {
      return res.status(400).json({ success: false, message: 'Rating must be between 1 and 5.' });
    }

    // Check if event exists
    const event = await Event.findByPk(eventId);
    if (!event) {
      return res.status(404).json({ success: false, message: 'Event not found.' });
    }

    // Create the review
    const review = await Review.create({ userId, eventId, rating, comment });

    res.status(201).json({ success: true, message: 'Review added successfully.', data: review });
  } catch (err) {
    console.error('Error adding event review:', err);
    res.status(500).json({ success: false, message: 'Failed to add review.' });
  }
};

// Create a review for a speaker
exports.createSpeakerReview = async (req, res) => {
  try {
    const { speakerId } = req.params;
    const { rating, comment } = req.body;
    const userId = req.user.id; // Extract from token

    // Validate rating
    if (!rating || rating < 1 || rating > 5) {
      return res.status(400).json({ success: false, message: 'Rating must be between 1 and 5.' });
    }

    // Check if speaker exists
    const speaker = await Speaker.findByPk(speakerId);
    if (!speaker) {
      return res.status(404).json({ success: false, message: 'Speaker not found.' });
    }

    // Create the review
    const review = await Review.create({ userId, speakerId, rating, comment });

    res.status(201).json({ success: true, message: 'Review added successfully.', data: review });
  } catch (err) {
    console.error('Error adding speaker review:', err);
    res.status(500).json({ success: false, message: 'Failed to add review.' });
  }
};
