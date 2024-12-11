const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');
const path = require('path');

const connection = require('./mysql');

const app = express();

app.use(session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'static')));

// http://localhost:3000/
app.get('/', function(request, response) {
    // Render login template
    response.sendFile(path.join(__dirname + '/signup.html'));
});

app.post('/signup', (req, res) => {
    const { username, email, password } = req.body;

    // Insert the user into the database
    connection.query('INSERT INTO users (username, email, password) VALUES (?, ?, ?)', [username, email, password], function(error, results, fields) {
        if (err) {
            console.error('Error inserting data:', err.message);
            res.status(500).send('An error occurred while signing up. Please try again.');
        } else {
            console.log('User added to database:', result.insertId);
            res.send(`Welcome, ${username}! Your signup was successful.`);
        }
    });
});


const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});