const {Event, User, EventRegistration, Guest, Speaker, Review} = require('../models/index')

const { v4: uuidv4 } = require('uuid');
const { v4 } = require('bcrypt');

// Create a new event
exports.createEvent = async (req, res) => {
  try {
    const { name, description, date, location, category, speakers, guests } = req.body;

    // Validate required fields
    if (!name || !date || !location || !category) {
      return res.status(400).json({ success: false, message: 'All required fields must be provided.' });
    }

    // Create the event
    const event = await Event.create({ name, description, date, location, category });

    // Associate speakers with the event
    if (Array.isArray(speakers) && speakers.length > 0) {
      const speakerInstances = await Speaker.findAll({ where: { id: speakers } });
      await event.addSpeakers(speakerInstances);
    }

    // Associate guests with the event
    if (Array.isArray(guests) && guests.length > 0) {
      const guestInstances = await Guest.findAll({ where: { id: guests } });
      await event.addGuests(guestInstances);
    }

    // Fetch the event with its related speakers and guests
    const createdEvent = await Event.findByPk(event.id, {
      include: [
        { model: Speaker, through: { attributes: [] } },
        { model: Guest, through: { attributes: [] } },
      ],
    });

    res.status(201).json({ success: true, message: 'Event created successfully.', data: createdEvent });
  } catch (err) {
    console.error('Error creating event:', err);
    res.status(500).json({ success: false, message: 'Failed to create event.' });
  }
};

// Get all events with optional filtering by category
exports.getAllEvents = async (req, res) => {
  try {
    const { category } = req.query;
    const filter = category ? { category } : {};

    const events = await Event.findAll({ where: filter, include: [
      {
        model: Review,
        attributes: ['rating'],
      },
    ] });

    // Compute average rating for each event
    const eventData = events.map(event => {
      const reviews = event.Reviews || [];
      const totalRating = reviews.reduce((sum, review) => sum + review.rating, 0);
      const averageRating = reviews.length > 0 ? (totalRating / reviews.length) : 0;

      return {
        ...event.toJSON(),
        average_rating: averageRating,
      };
    });

    res.status(200).json({ success: true, data: eventData });
  } catch (err) {
    console.error('Error fetching events:', err);
    res.status(500).json({ success: false, message: 'Failed to fetch events.' });
  }
};

// Get a single event by ID
exports.getEventById = async (req, res) => {
  try {
    const { id } = req.params;

    const event = await Event.findByPk(id, {
      include: [
        {
          model: Speaker,
          through: { attributes: [] }, // Hide the join table attributes
        },
        {
          model: Guest,
          through: { attributes: [] },
        },
        {
          model: Review,
          attributes: ['id', 'rating', 'comment', 'userId', 'createdAt'],
          include: [
            {
              model: User,
              attributes: ['id', 'name'], // Include user details for the review
            },
          ],
        },
      ],
    });

    if (!event) {
      return res.status(404).json({ success: false, message: 'Event not found.' });
    }

    // Calculate average rating
    const reviews = event.Reviews || [];
    const totalRating = reviews.reduce((sum, review) => sum + review.rating, 0);
    const averageRating = reviews.length > 0 ? (totalRating / reviews.length) : null;

    res.status(200).json({
      success: true,
      data: {
        ...event.toJSON(),
        average_rating: averageRating,
      },
    });
  } catch (err) {
    console.error('Error fetching event:', err);
    res.status(500).json({ success: false, message: 'Failed to fetch event.' });
  }
};

// Update an event
exports.updateEvent = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, description, date, location, category } = req.body;

    const event = await Event.findByPk(id);

    if (!event) {
      return res.status(404).json({ success: false, message: 'Event not found.' });
    }

    // Update fields
    event.name = name || event.name;
    event.description = description || event.description;
    event.date = date || event.date;
    event.location = location || event.location;
    event.category = category || event.category;

    await event.save();

    res.status(200).json({ success: true, message: 'Event updated successfully.', data: event });
  } catch (err) {
    console.error('Error updating event:', err);
    res.status(500).json({ success: false, message: 'Failed to update event.' });
  }
};

// Delete an event
exports.deleteEvent = async (req, res) => {
  try {
    const { id } = req.params;

    const event = await Event.findByPk(id);

    if (!event) {
      return res.status(404).json({ success: false, message: 'Event not found.' });
    }

    await event.destroy();

    res.status(200).json({ success: true, message: 'Event deleted successfully.' });
  } catch (err) {
    console.error('Error deleting event:', err);
    res.status(500).json({ success: false, message: 'Failed to delete event.' });
  }
};

// User sign up for an event
exports.signUpForEvent = async (req, res) => {
  try {
    const { id: eventId } = req.params; // Extract eventId from URL
    const userId = req.user.id; // Extract userId from the token middleware

    // Validate input
    if (!eventId) {
      return res.status(400).json({ success: false, message: 'Event ID is required.' });
    }

    // Check if event exists
    const event = await Event.findByPk(eventId);
    if (!event) {
      return res.status(404).json({ success: false, message: 'Event not found.' });
    }

    // Check if already registered
    const existingRegistration = await EventRegistration.findOne({ where: { userId, eventId } });
    if (existingRegistration) {
      return res.status(400).json({ success: false, message: 'User already registered for this event.' });
    }

    // Generate a unique QR key
    const qrKey = uuidv4();

    // Create registration
    const registration = await EventRegistration.create({ userId, eventId, qrKey });

    res.status(201).json({
      success: true,
      message: 'User successfully registered for the event.',
      data: { qrKey, registration },
    });
  } catch (err) {
    console.error('Error registering for event:', err);
    res.status(500).json({ success: false, message: 'Failed to register for the event.' });
  }
};

// Validate participant attendance
exports.validateAttendance = async (req, res) => {
  try {
    const { qrKey } = req.body;

    // Validate input
    if (!qrKey) {
      return res.status(400).json({ success: false, message: 'QR Key is required.' });
    }

    // Find the registration
    const registration = await EventRegistration.findOne({ where: { qrKey } });
    if (!registration) {
      return res.status(404).json({ success: false, message: 'Invalid QR key or participant not found.' });
    }

    if (registration.attended) {
      res.status(500).json({ success: false, message: 'This QR code is already scanned' });
    }

    // Mark as attended
    registration.attended = true;
    await registration.save();

    res.status(200).json({
      success: true,
      message: 'Attendance validated successfully.',
      data: { userId: registration.userId, eventId: registration.eventId },
    });
  } catch (err) {
    console.error('Error validating attendance:', err);
    res.status(500).json({ success: false, message: 'Failed to validate attendance.' });
  }
};