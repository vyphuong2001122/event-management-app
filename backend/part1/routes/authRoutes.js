const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// Đăng ký
router.post('/register', userController.register);

// Đăng nhập
router.post('/login', userController.login);

// Quên mật khẩu
router.post('/forgot-password', userController.forgotPassword);

// Đặt lại mật khẩu
router.post('/reset-password', userController.resetPassword);

module.exports = router;