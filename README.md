# Task Management App

This is a Flutter-based Task Management app built using **Riverpod** for state management, **SQLite** for storing task data, and **Hive** for storing user preferences such as theme settings. The app supports both light and dark themes and has a responsive design.

## Features

- **Task Management**: Add, edit, delete, and view tasks.
- **Task Status**: Mark tasks as **Completed** or **Pending**.
- **Local Data Storage**:
    - **SQLite**: Used to store task details.
    - **Hive**: Used to store user preferences (e.g., theme settings).
- **State Management**: Managed using **Riverpod**.
- **Responsive Design**: Works seamlessly across mobile and tablet devices.
- **Light and Dark Mode**: User can switch between light and dark themes.
- **Additional Features** (Optional):
    - Search and filter tasks.
    - Local notifications for task reminders.

---

## Prerequisites

To run the project, you need the following installed on your machine:

1. **Flutter** (recommended version: 3.7 or higher)  
   You can install Flutter by following the official documentation: [Flutter Installation](https://flutter.dev/docs/get-started/install).

2. **Dart** (comes with Flutter).

3. **Android Studio** or **Visual Studio Code** (with Flutter and Dart plugins installed).

4. **SQLite** & **Hive** setup (handled by dependencies in `pubspec.yaml`).

---

## Getting Started

### Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/Dev-Harsh87/Task_App.git
