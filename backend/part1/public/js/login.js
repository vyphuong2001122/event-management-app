const bcrypt = require('bcrypt');
const User = require('../models/userModel');

/**
 * Đăng nhập
 */
exports.login = (req, res) => {
    const { account, password } = req.body;

    if (!account || !password) {
        return res.status(400).send('Account and password are required');
    }

    // Tìm người dùng theo email hoặc tên tài khoản
    User.findByAccount(account, (err, user) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).send('Internal server error');
        }

        if (!user) {
            return res.status(404).send('User not found');
        }

        // Kiểm tra mật khẩu
        bcrypt.compare(password, user.password, (err, isMatch) => {
            if (err) {
                console.error('Error comparing passwords:', err);
                return res.status(500).send('Internal server error');
            }

            if (!isMatch) {
                return res.status(401).send('Invalid credentials');
            }

            res.status(200).send('Login successful');
        });
    });
};