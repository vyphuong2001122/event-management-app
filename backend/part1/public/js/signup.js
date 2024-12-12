const bcrypt = require('bcrypt');
const User = require('../models/userModel');

/**
 * Đăng ký tài khoản mới
 */
exports.register = (req, res) => {
    const { name, email, password } = req.body;

    // Kiểm tra thông tin đầu vào
    if (!name || !email || !password) {
        return res.status(400).send('All fields are required');
    }

    // Hash mật khẩu trước khi lưu
    bcrypt.hash(password, 10, (err, hashedPassword) => {
        if (err) {
            console.error('Error hashing password:', err);
            return res.status(500).send('Internal server error');
        }

        // Tạo người dùng mới trong cơ sở dữ liệu
        User.create({ name, email, password: hashedPassword }, (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).send('Failed to register user');
            }
            res.status(201).send('User registered successfully');
        });
    });
};