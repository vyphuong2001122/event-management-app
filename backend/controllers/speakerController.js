const { Speaker, Guest, Event } = require('../models/index');

const isOrganizerOrAdmin = (role) => ['organizer', 'admin'].includes(role);

// Get All Speakers
const getAllSpeakers = async (req, res) => {
  try {
    const speakers = await Speaker.findAll();
    res.status(200).json({ success: true, data: speakers });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Get Speaker by ID
const getSpeakerById = async (req, res) => {
  try {
    const { id } = req.params;
    const speaker = await Speaker.findByPk(id);

    if (!speaker) {
      return res.status(404).json({ success: false, message: 'Speaker not found' });
    }

    res.status(200).json({ success: true, data: speaker });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Get All Guests
const getAllGuests = async (req, res) => {
  try {
    const guests = await Guest.findAll();
    res.status(200).json({ success: true, data: guests });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Get Guest by ID
const getGuestById = async (req, res) => {
  try {
    const { id } = req.params;
    const guest = await Guest.findByPk(id);

    if (!guest) {
      return res.status(404).json({ success: false, message: 'Guest not found' });
    }

    res.status(200).json({ success: true, data: guest });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Get Speakers by Event ID
const getSpeakersByEventId = async (req, res) => {
  try {
    const { eventId } = req.params;

    const speakers = await Speaker.findAll({
      where: { eventId },
      include: [{ model: Event, attributes: ['id', 'name'] }],
    });

    if (!speakers.length) {
      return res.status(404).json({ success: false, message: 'No speakers found for this event' });
    }

    res.status(200).json({ success: true, data: speakers });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Get Guests by Event ID
const getGuestsByEventId = async (req, res) => {
  try {
    const { eventId } = req.params;

    const guests = await Guest.findAll({
      where: { eventId },
      include: [{ model: Event, attributes: ['id', 'name'] }],
    });

    if (!guests.length) {
      return res.status(404).json({ success: false, message: 'No guests found for this event' });
    }

    res.status(200).json({ success: true, data: guests });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Create Speaker
const createSpeaker = async (req, res) => {
  try {
    if (!isOrganizerOrAdmin(req.user.role)) {
      return res.status(403).json({ success: false, message: 'Unauthorized' });
    }

    const { name, bio, profilePicture } = req.body;
    const speaker = await Speaker.create({ name, bio, profilePicture });

    res.status(201).json({ success: true, data: speaker });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Create Guest
const createGuest = async (req, res) => {
  try {
    if (!isOrganizerOrAdmin(req.user.role)) {
      return res.status(403).json({ success: false, message: 'Unauthorized' });
    }

    const { name, details } = req.body;
    const guest = await Guest.create({ name, details });

    res.status(201).json({ success: true, data: guest });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Update Speaker
const updateSpeaker = async (req, res) => {
  try {
    if (!isOrganizerOrAdmin(req.user.role)) {
      return res.status(403).json({ success: false, message: 'Unauthorized' });
    }

    const { id } = req.params;
    const { name, bio, profilePicture } = req.body;

    const speaker = await Speaker.findByPk(id);
    if (!speaker) {
      return res.status(404).json({ success: false, message: 'Speaker not found' });
    }

    await speaker.update({ name, bio, profilePicture });
    res.status(200).json({ success: true, data: speaker });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Update Guest
const updateGuest = async (req, res) => {
  try {
    if (!isOrganizerOrAdmin(req.user.role)) {
      return res.status(403).json({ success: false, message: 'Unauthorized' });
    }

    const { id } = req.params;
    const { name, details } = req.body;

    const guest = await Guest.findByPk(id);
    if (!guest) {
      return res.status(404).json({ success: false, message: 'Guest not found' });
    }

    await guest.update({ name, details });
    res.status(200).json({ success: true, data: guest });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Delete Speaker
const deleteSpeaker = async (req, res) => {
  try {
    if (!isOrganizerOrAdmin(req.user.role)) {
      return res.status(403).json({ success: false, message: 'Unauthorized' });
    }

    const { id } = req.params;
    const speaker = await Speaker.findByPk(id);
    if (!speaker) {
      return res.status(404).json({ success: false, message: 'Speaker not found' });
    }

    await speaker.destroy();
    res.status(200).json({ success: true, message: 'Speaker deleted' });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Delete Guest
const deleteGuest = async (req, res) => {
  try {
    if (!isOrganizerOrAdmin(req.user.role)) {
      return res.status(403).json({ success: false, message: 'Unauthorized' });
    }

    const { id } = req.params;
    const guest = await Guest.findByPk(id);
    if (!guest) {
      return res.status(404).json({ success: false, message: 'Guest not found' });
    }

    await guest.destroy();
    res.status(200).json({ success: true, message: 'Guest deleted' });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = {
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
  getSpeakersByEventId,
  getGuestsByEventId,
};