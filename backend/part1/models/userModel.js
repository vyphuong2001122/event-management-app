const db = require('../config/db');

/**
 * Tạo người dùng mới trong cơ sở dữ liệu.
 * @param {Object} user - Thông tin người dùng (name, email, password).
 * @param {Function} callback - Hàm callback xử lý kết quả.
 */
exports.create = (user, callback) => {
    const query = 'INSERT INTO users (name, email, password) VALUES (?, ?, ?)';
    db.query(query, [user.name, user.email, user.password], callback);
};

/**
 * Tìm người dùng dựa trên email hoặc tên tài khoản.
 * @param {string} account - Email hoặc tên tài khoản của người dùng.
 * @param {Function} callback - Hàm callback xử lý kết quả.
 */
exports.findByAccount = (account, callback) => {
    const query = 'SELECT * FROM users WHERE email = ? OR name = ?';
    db.query(query, [account, account], (err, results) => {
        if (err) {
            return callback(err);
        }
        callback(null, results[0]); // Trả về người dùng đầu tiên (nếu có).
    });
};

/**
 * Cập nhật mật khẩu của người dùng.
 * @param {string} email - Email của người dùng.
 * @param {string} newPassword - Mật khẩu mới đã được hash.
 * @param {Function} callback - Hàm callback xử lý kết quả.
 */
exports.updatePassword = (email, newPassword, callback) => {
    const query = 'UPDATE users SET password = ? WHERE email = ?';
    db.query(query, [newPassword, email], callback);
};