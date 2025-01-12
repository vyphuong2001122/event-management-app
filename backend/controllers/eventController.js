const Event = require('../models/Event');
const User = require('../models/User');
const EventRegistration = require('../models/EventRegistration');
const { v4: uuidv4 } = require('uuid');
const { v4 } = require('bcrypt');

// Create a new event
exports.createEvent = async (req, res) => {
  try {
    const { name, description, date, location, category } = req.body;

    // Validate required fields
    if (!name || !date || !location || !category) {
      return res.status(400).json({ success: false, message: 'All required fields must be provided.' });
    }

    // Create the event
    const event = await Event.create({ name, description, date, location, category });

    res.status(201).json({ success: true, message: 'Event created successfully.', data: event });
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

    const events = await Event.findAll({ where: filter });

    res.status(200).json({ success: true, data: events });
  } catch (err) {
    console.error('Error fetching events:', err);
    res.status(500).json({ success: false, message: 'Failed to fetch events.' });
  }
};

// Get a single event by ID
exports.getEventById = async (req, res) => {
  try {
    const { id } = req.params;

    const event = await Event.findByPk(id);

    if (!event) {
      return res.status(404).json({ success: false, message: 'Event not found.' });
    }

    res.status(200).json({ success: true, data: event });
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

// Sign up for an event
exports.signUpForEvent = async (req, res) => {
  try {
    const { userId, eventId } = req.body;

    // Validate input
    if (!userId || !eventId) {
      return res.status(400).json({ success: false, message: 'User ID and Event ID are required.' });
    }

    // Check if event exists
    const event = await Event.findByPk(eventId);
    if (!event) {
      return res.status(404).json({ success: false, message: 'Event not found.' });
    }

    // Check if user exists
    const user = await User.findByPk(userId);
    if (!user) {
      return res.status(404).json({ success: false, message: 'User not found.' });
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