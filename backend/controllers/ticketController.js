const { Event, EventRegistration } = require('../models/index');

exports.getUserTickets = async(req, res) => {
    try {
        const userId = req.user.id; // Lấy ID người dùng từ middleware

        // Lấy danh sách vé của user, bao gồm thông tin sự kiện
        const tickets = await EventRegistration.findAll({
            where: { userId },
            attributes: ['id', 'eventId', 'qrKey', 'attended', 'createdAt'],
            include: [{
                model: Event,
                attributes: ['name', 'description', 'location', 'date'], // Chọn các trường từ Event
            }, ],
        });

        // Trả về danh sách vé
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