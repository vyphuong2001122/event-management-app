const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const FacebookStrategy = require('passport-facebook').Strategy;
const bcrypt = require('bcrypt');
const User = require('../models/userModel');
const LocalStrategy = require('passport-local').Strategy;

// Serialize & Deserialize
passport.serializeUser((user, done) => done(null, user.id));
passport.deserializeUser((id, done) => {
    User.findById(id).then(user => done(null, user)).catch(err => done(err));
});

// Local Strategy
passport.use(new LocalStrategy(async(email, password, done) => {
    const user = await User.findByEmail(email);
    if (!user) return done(null, false, { message: 'No user found' });
    const isValid = await bcrypt.compare(password, user.password);
    return done(null, isValid ? user : false);
}));

// Google Strategy
passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: '/auth/google/callback',
}, (accessToken, refreshToken, profile, done) => {
    // Handle Google login
}));

// Facebook Strategy
passport.use(new FacebookStrategy({
    clientID: process.env.FACEBOOK_APP_ID,
    clientSecret: process.env.FACEBOOK_APP_SECRET,
    callbackURL: '/auth/facebook/callback',
}, (accessToken, refreshToken, profile, done) => {
    // Handle Facebook login
}));