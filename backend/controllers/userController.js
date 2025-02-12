const User = require('../models/User'); // Import the User model
const { validationResult } = require('express-validator');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');

exports.getAllUsers = async(req, res) => {
    try {
        const users = await User.findAll({ attributes: { exclude: ['password'] } }); // Exclude passwords for security
        res.status(200).json({
            success: true,
            message: 'User fetched successfully',
            data: { users }
        });
    } catch (error) {
        console.error('Error fetching users:', error);
        res.status(500).json({ error: 'Failed to retrieve users' });
    }
};

exports.registerUser = async(req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({
            success: false,
            errors: errors.array(),
        });
    }

    try {
        const { name, email, password } = req.body;

        // Hash the password
        const saltRounds = 10;
        const hashedPassword = await bcrypt.hash(password, saltRounds);

        // Create the new user
        const newUser = await User.create({ name, email, password: hashedPassword });

        // Generate a JWT
        const token = jwt.sign({ id: newUser.id, email: newUser.email, role: newUser.role },
            process.env.JWT_SECRET, { expiresIn: process.env.JWT_EXPIRES_IN } // Token expiration time from .env
        );

        // Return success response with user data and JWT
        const { id, profile_picture, createdAt, updatedAt } = newUser;
        res.status(201).json({
            success: true,
            message: 'User registered successfully',
            data: {
                id,
                name,
                email,
                profile_picture,
                createdAt,
                updatedAt,
            },
            token, // Include the generated JWT in the response
        });
    } catch (error) {
        console.error('Error registering user:', error);
        res.status(500).json({
            success: false,
            error: 'Failed to register user',
        });
    }
};

exports.loginUser = async(req, res) => {
    const { email, password } = req.body;

    try {
        // Find the user by email
        const user = await User.findOne({ where: { email } });
        if (!user) {
            return res.status(401).json({ success: false, message: 'Invalid email or password' });
        }

        // Compare passwords
        const isPasswordValid = await bcrypt.compare(password, user.password);
        if (!isPasswordValid) {
            return res.status(401).json({ success: false, message: 'Invalid email or password' });
        }

        // Generate a JWT
        const token = jwt.sign({ id: user.id, email: user.email, role: user.role }, process.env.JWT_SECRET, {
            expiresIn: process.env.JWT_EXPIRES_IN,
        });

        res.status(200).json({
            success: true,
            message: 'Login successful',
            token,
        });
    } catch (error) {
        console.error('Error during login:', error);
        res.status(500).json({ success: false, error: 'Login failed' });
    }
};

// Get current user profile
exports.getCurrentUserProfile = async(req, res) => {
    try {
        const userId = req.user.id; // Extract user ID from token

        // Fetch user details
        const user = await User.findByPk(userId, {
            attributes: ['id', 'name', 'email', 'role', 'createdAt', 'updatedAt'], // Select only relevant fields
        });

        if (!user) {
            return res.status(404).json({ success: false, message: 'User not found.' });
        }

        res.status(200).json({
            success: true,
            message: 'User profile retrieved successfully.',
            data: user,
        });
    } catch (err) {
        console.error('Error retrieving user profile:', err);
        res.status(500).json({ success: false, message: 'Failed to retrieve user profile.' });
    }
};

exports.updateUserProfile = async(req, res) => {
    try {
        const userId = req.user.id; // Lấy ID của người dùng từ middleware xác thực
        const { name, profile_picture } = req.body; // Lấy thông tin cần cập nhật

        // Tìm user theo ID
        const user = await User.findByPk(userId);

        if (!user) {
            return res.status(404).json({
                success: false,
                message: 'User not found',
            });
        }

        // Chỉ cập nhật các trường cho phép
        await user.update({
            name: name || user.name,
            profile_picture: profile_picture || user.profile_picture,
        });

        return res.status(200).json({
            success: true,
            message: 'Profile updated successfully',
            user: {
                id: user.id,
                name: user.name,
                email: user.email,
                profile_picture: user.profile_picture,
            },
        });
    } catch (error) {
        console.error('Error updating profile:', error.message);
        return res.status(500).json({
            success: false,
            message: 'Failed to update profile',
        });
    }
};

exports.updateUserRole = async (req, res) => {
    try {
        const { userId } = req.params;
        const { role } = req.body;
    
        // Validate role
        const validRoles = ['admin', 'organizer', 'attendee'];
        if (!validRoles.includes(role)) {
            return res.status(400).json({ success: false, message: 'Invalid role specified.' });
        }
    
        // Find user
        const user = await User.findByPk(userId);
        if (!user) {
            return res.status(404).json({ success: false, message: 'User not found.' });
        }
    
        // Update role
        user.role = role;
        await user.save();
    
        res.status(200).json({
            success: true,
            message: 'User role updated successfully.',
            data: { id: user.id, name: user.name, email: user.email, role: user.role },
        });
    } catch (err) {
        console.error('Error updating user role:', err);
        res.status(500).json({ success: false, message: 'Failed to update user role.' });
    }
};
