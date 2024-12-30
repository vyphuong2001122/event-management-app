const Event = require('../models/Event');

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
