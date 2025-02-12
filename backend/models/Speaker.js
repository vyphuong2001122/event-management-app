const { DataTypes } = require('sequelize');
const sequelize = require('../config/db.config');

const Speaker = sequelize.define('Speaker', {
  name: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  bio: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  profilePicture: {
    type: DataTypes.STRING,
    allowNull: true,
  },
}, {
  timestamps: true,
});

module.exports = Speaker;
