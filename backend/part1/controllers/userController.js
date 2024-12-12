const User = require('../models/userModel');
const bcrypt = require('bcrypt');
const nodemailer = require('nodemailer');

/**
 * Đăng ký tài khoản mới
 */
exports.register = (req, res) => {
    const { name, email, password } = req.body;

    // Hash mật khẩu trước khi lưu vào database
    bcrypt.hash(password, 10, (err, hashedPassword) => {
        if (err) {
            console.error('Bcrypt error:', err);
            return res.status(500).send('Failed to hash password');
        }

        User.create({ name, email, password: hashedPassword }, (err, results) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).send('Failed to register user');
            }

            res.status(201).send('User registered successfully');
        });
    });
};

/**
 * Đăng nhập
 */
exports.login = (req, res) => {
    const { account, password } = req.body;

    // Tìm người dùng theo email, name, hoặc phone
    User.findByAccount(account, (err, user) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).send('Internal server error');
        }

        if (!user) {
            return res.status(404).send('User not found');
        }

        // So sánh mật khẩu
        bcrypt.compare(password, user.password, (err, isMatch) => {
            if (err) {
                console.error('Bcrypt error:', err);
                return res.status(500).send('Internal server error');
            }

            if (!isMatch) {
                return res.status(401).send('Invalid credentials');
            }

            // Đăng nhập thành công
            res.status(200).send('Login successful');
        });
    });
};

/**
 * Xử lý quên mật khẩu
 */
exports.forgotPassword = (req, res) => {
    const { email } = req.body;

    User.findByEmail(email, (err, user) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).send('Internal server error');
        }

        if (!user) {
            return res.status(404).send('Email not found');
        }

        // Tạo mã thông báo đặt lại mật khẩu (simple random token)
        const resetToken = Math.random().toString(36).substring(2);

        // Cấu hình transporter của Nodemailer
        const transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: 'your-email@gmail.com', // Thay bằng email của bạn
                pass: 'your-email-password', // Thay bằng mật khẩu ứng dụng
            },
        });

        const mailOptions = {
            from: 'your-email@gmail.com', // Email của bạn
            to: email,
            subject: 'Password Reset Request',
            text: `Use this token to reset your password: ${resetToken}`,
        };

        transporter.sendMail(mailOptions, (err, info) => {
            if (err) {
                console.error('Nodemailer error:', err);
                return res.status(500).send('Failed to send email');
            }

            // Lưu token vào cơ sở dữ liệu nếu cần thiết (ở đây bỏ qua)
            res.status(200).send('Password reset token sent to your email');
        });
    });
};

/**
 * Đặt lại mật khẩu
 */
exports.resetPassword = (req, res) => {
    const { email, newPassword } = req.body;

    // Hash mật khẩu mới trước khi lưu
    bcrypt.hash(newPassword, 10, (err, hashedPassword) => {
        if (err) {
            console.error('Bcrypt error:', err);
            return res.status(500).send('Failed to hash new password');
        }

        User.updatePassword(email, hashedPassword, (err, results) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).send('Failed to reset password');
            }

            res.status(200).send('Password has been reset successfully');
        });
    });
};