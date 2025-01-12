const { Model, DataTypes } = require('sequelize');
const sequelize = require('../config/db.config');


class EventRegistration extends Model {}

EventRegistration.init({
    userId: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    eventId: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    qrKey: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    attended: {
        type: DataTypes.BOOLEAN,
        defaultValue: false,
    },
}, {
    sequelize,
    modelName: 'EventRegistration',
});




module.exports = EventRegistration;