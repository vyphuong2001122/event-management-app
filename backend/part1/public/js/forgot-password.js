const bcrypt = require('bcrypt');
const User = require('../models/userModel');

/**
 * Đặt lại mật khẩu
 */
exports.resetPassword = (req, res) => {
    const { email, newPassword } = req.body;

    if (!email || !newPassword) {
        return res.status(400).send('Email and new password are required');
    }

    // Hash mật khẩu mới
    bcrypt.hash(newPassword, 10, (err, hashedPassword) => {
        if (err) {
            console.error('Error hashing new password:', err);
            return res.status(500).send('Internal server error');
        }

        // Cập nhật mật khẩu trong cơ sở dữ liệu
        User.updatePassword(email, hashedPassword, (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).send('Failed to reset password');
            }

            res.status(200).send('Password has been reset successfully');
        });
    });
};