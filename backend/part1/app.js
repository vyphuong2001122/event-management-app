const express = require('express');
const path = require('path');
const app = express();
const authRoutes = require('./routes/authRoutes');

app.use(express.json());
app.use(express.static('public'));

app.use('/auth', authRoutes);

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public/html/login.html'));
});

app.listen(3000, () => {
    console.log('Server running on http://localhost:3000');
});