'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
    up: async(queryInterface, Sequelize) => {
        await queryInterface.removeIndex('Users', 'ten_khoa');
    },
    down: async(queryInterface, Sequelize) => {
        await queryInterface.addIndex('Users', ['column_name'], {
            unique: true,
            name: 'ten_khoa',
        });
    },
};