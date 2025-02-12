const { Event, EventRegistration } = require('../models/index');

exports.getUserTickets = async(req, res) => {
    try {
        const userId = req.user.id; // Get user ID from middleware

        // Get a list of user tickets, including event information
        const tickets = await EventRegistration.findAll({
            where: { userId },
            attributes: ['id', 'eventId', 'qrKey', 'attended', 'createdAt'],
            include: [{
                model: Event,
                attributes: ['name', 'description', 'location', 'date'], // Select fields from Event
            }, ],
        });

        // Returns a list of tickets
        res.status(200).json({
            success: true,
            tickets,
        });
    } catch (error) {
        console.error('Error fetching tickets:', error.message);
        res.status(500).json({
            success: false,
            message: 'Failed to fetch tickets',
        });
    }
};