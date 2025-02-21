# Event Management Application

This project leverages **Flutter** and **Firebase** to develop a cross-platform mobile application for managing events efficiently. The app supports Android, iOS, and Web platforms, providing an intuitive and user-friendly experience.

## Features

### Roles
- attendee
- organizer
- admin

### Attendee
- Event registration with e-tickets.
- Schedule viewing and notifications.
- QR code-based check-in/out.
- Event feedback and ratings.

### Event Organizers
- Event creation and management.
- Schedule organization for sessions and activities.
- Real-time participant tracking.
- Reporting and analysis (attendance, feedback, etc.).
- Volunteer and budget management.

### Admins
- User account management
- Speakers and guests management
- Event list management.

### Utilities
- Multi-lingual (currently supports English and Vietnamese)
- Dark mode

## Installation and Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/vyphuong2001122/event-management-app.git
2. cd event-management-app/frontend/
3. flutter pub get
4. flutter run
5. Login with accounts
   - Admin role: admin@gmail.com / 123456
   - Organizer role: organizer@gmail.com / 123456
   - User role: test@gmail.com

## Directory Structure
    lib/
    ├── models/          # Data models
    ├── view/            # UI screens
    │   ├── widgets/     # Reusable components
    ├── controllers/     # Provider controllers
    ├── widgets/         # Reusable components
    ├── api.dart         # API and database services
    ├── colors.dart      # Reusable colors
    └── main.dart        # Entry point

## Contributors
Nguyễn Lê Phương Vy
Nguyễn Quốc Thịnh

## Accounts
- Firebase: Login with Google account (519h0363@student.tdtu.edu.vn)
