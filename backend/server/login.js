const express = require('express');
const session = require('express-session');
const path = require('path');
const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const FacebookStrategy = require('passport-facebook').Strategy;

const connection = require('./mysql');

const app = express();

// Middleware
app.use(session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
}));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'static')));
app.use(passport.initialize());
app.use(passport.session());

// Passport serialization
passport.serializeUser((user, done) => done(null, user));
passport.deserializeUser((obj, done) => done(null, obj));

// Configure Google Strategy
passport.use(new GoogleStrategy({
    clientID: 'YOUR_GOOGLE_CLIENT_ID',
    clientSecret: 'YOUR_GOOGLE_CLIENT_SECRET',
    callbackURL: '/auth/google/callback'
}, (accessToken, refreshToken, profile, done) => {
    // You can handle user data from Google profile here
    return done(null, profile);
}));

// Configure Facebook Strategy
passport.use(new FacebookStrategy({
    clientID: 'YOUR_FACEBOOK_APP_ID',
    clientSecret: 'YOUR_FACEBOOK_APP_SECRET',
    callbackURL: '/auth/facebook/callback',
    profileFields: ['id', 'displayName', 'emails']
}, (accessToken, refreshToken, profile, done) => {
    // You can handle user data from Facebook profile here
    return done(null, profile);
}));

// Routes
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname + '/login.html'));
});

// Login authentication
app.post('/auth', (req, res) => {
    const { username, password } = req.body;
    if (username && password) {
        connection.query('SELECT * FROM users WHERE username = ? AND password = ?', [username, password], (error, results) => {
            if (error) throw error;
            if (results.length > 0) {
                req.session.loggedin = true;
                req.session.username = username;
                res.redirect('/home');
            } else {
                res.send('Incorrect Username and/or Password!');
            }
        });
    } else {
        res.send('Please enter Username and Password!');
    }
});

// Forgot password
app.get('/forgot-password', (req, res) => {
    res.sendFile(path.join(__dirname + '/forgotpassword.html'));
});

app.post('/reset-password', (req, res) => {
    const email = req.body.email;
    if (email) {
        // Example: Logic to send reset email (e.g., using nodemailer)
        console.log(`Reset password link sent to: ${email}`);
        res.send('A reset link has been sent to your email!');
    } else {
        res.send('Please enter a valid email!');
    }
});

// Home page
app.get('/home', (req, res) => {
    if (req.session.loggedin) {
        res.send('Welcome back, ' + req.session.username + '!');
    } else {
        res.send('Please login to view this page!');
    }
});

// Google Login
app.get('/auth/google', passport.authenticate('google', { scope: ['profile', 'email'] }));

app.get('/auth/google/callback', passport.authenticate('google', { failureRedirect: '/' }), (req, res) => {
    req.session.loggedin = true;
    req.session.username = req.user.displayName;
    res.redirect('/home');
});

// Facebook Login
app.get('/auth/facebook', passport.authenticate('facebook', { scope: ['email'] }));

app.get('/auth/facebook/callback', passport.authenticate('facebook', { failureRedirect: '/' }), (req, res) => {
    req.session.loggedin = true;
    req.session.username = req.user.displayName;
    res.redirect('/home');
});

// Server
app.listen(3000, () => {
    console.log('Server started on http://localhost:3000');
});