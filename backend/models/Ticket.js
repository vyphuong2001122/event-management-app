const { DataTypes } = require('sequelize');
const sequelize = require('../config/db.config');

const Ticket = sequelize.define('Ticket', {
    userId: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    eventId: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    status: {
        type: DataTypes.ENUM('pending', 'confirmed', 'cancelled'),
        allowNull: false,
        defaultValue: 'pending',
    },
}, {
    timestamps: true,
});

module.exports = Ticket;