const express = require('express');
const sequelize = require('./config/db.config');


const app = express();
app.use(express.json());

(async() => {
    try {
        await sequelize.authenticate();
        console.log('Database connected.');

        // Sync models
        await sequelize.sync(); // Use `alter: true` for development, remove for production
        console.log('Database synced.');

        app.listen(3000, () => console.log('Server running on http://localhost:3000'));
    } catch (error) {
        console.error('Database connection error:', error);
    }
})();

const userRoutes = require('./routes/users');
const eventRoutes = require('./routes/events');
const ticketRoutes = require('./routes/tickets');
const speakerRoutes = require('./routes/speakers');

app.use('/users', userRoutes);
app.use('/events', eventRoutes);
app.use('/tickets', ticketRoutes);
app.use('/speakers', speakerRoutes);