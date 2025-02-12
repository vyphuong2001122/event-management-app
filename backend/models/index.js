const sequelize = require('../config/db.config');
const User = require('./User');
const Event = require('./Event');
const Speaker = require('./Speaker');
const Guest = require('./Guest');
const Review = require('./Review');
const EventRegistration = require('./EventRegistration');


// Define relationships
User.hasMany(EventRegistration, { foreignKey: 'userId' });
EventRegistration.belongsTo(User, { foreignKey: 'userId' });

Event.hasMany(EventRegistration, { foreignKey: 'eventId' });
EventRegistration.belongsTo(Event, { foreignKey: 'eventId' });

// Event-Speaker many-to-many relationship
Event.belongsToMany(Speaker, { through: 'EventSpeakers' });
Speaker.belongsToMany(Event, { through: 'EventSpeakers' });

// Event-Guest many-to-many relationship
Event.belongsToMany(Guest, { through: 'EventGuests' });
Guest.belongsToMany(Event, { through: 'EventGuests' });

User.hasMany(Review, { foreignKey: 'userId' });
Review.belongsTo(User, { foreignKey: 'userId' });

Event.hasMany(Review, { foreignKey: 'eventId' });
Review.belongsTo(Event, { foreignKey: 'eventId' });

Speaker.hasMany(Review, { foreignKey: 'speakerId' });
Review.belongsTo(Speaker, { foreignKey: 'speakerId' });


// Export models and sequelize instance
module.exports = {
    sequelize,
    User,
    Event,
    Speaker,
    Guest,
    EventRegistration,
    Review,
};