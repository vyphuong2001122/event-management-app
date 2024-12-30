const sequelize = require('../config/db');
const User = require('./User');
const Event = require('./Event');
const Ticket = require('./Ticket');
const Notification = require('./Notification');
const Schedule = require('./Schedule');
const Feedback = require('./Feedback');
const Speaker = require('./Speaker');
const Guest = require('./Guest');

// Define relationships
User.hasMany(Ticket, { foreignKey: 'userId' });
Ticket.belongsTo(User, { foreignKey: 'userId' });

Event.hasMany(Ticket, { foreignKey: 'eventId' });
Ticket.belongsTo(Event, { foreignKey: 'eventId' });

Event.hasMany(Schedule, { foreignKey: 'eventId' });
Schedule.belongsTo(Event, { foreignKey: 'eventId' });

Event.hasMany(Feedback, { foreignKey: 'eventId' });
Feedback.belongsTo(Event, { foreignKey: 'eventId' });

User.hasMany(Feedback, { foreignKey: 'userId' });
Feedback.belongsTo(User, { foreignKey: 'userId' });

Event.hasMany(Speaker, { foreignKey: 'eventId' });
Speaker.belongsTo(Event, { foreignKey: 'eventId' });

Event.hasMany(Guest, { foreignKey: 'eventId' });
Guest.belongsTo(Event, { foreignKey: 'eventId' });

// Export models and sequelize instance
module.exports = {
  sequelize,
  User,
  Event,
  Ticket,
  Notification,
  Schedule,
  Feedback,
  Speaker,
  Guest,
};
