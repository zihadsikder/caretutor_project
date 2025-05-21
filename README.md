### Flutter Notes App

A comprehensive note-taking application built with Flutter that allows users to create, read, update, and delete notes. The app features user authentication, real-time data synchronization with Firebase, and a clean, intuitive user interface.

## Features

- **User Authentication**: Secure login and registration with email and password
- **Create Notes**: Add new notes with title and description
- **View Notes**: Browse all your notes in a clean, organized list
- **Edit Notes**: Update existing notes
- **Delete Notes**: Remove unwanted notes with swipe-to-delete functionality
- **Search**: Quickly find notes with the search feature
- **Responsive Design**: Works seamlessly on various device sizes
- **Offline Support**: Access your notes even without an internet connection


## Technologies Used

- **Flutter**: UI framework for cross-platform app development
- **GetX**: State management, dependency injection, and navigation
- **Go Router**: Advanced routing and navigation
- **Firebase Authentication**: User authentication and management
- **Cloud Firestore**: Real-time database for storing notes
- **GetStorage**: Local storage for offline capabilities


## Firebase Configuration

### Authentication Setup

1. In the Firebase Console, go to **Authentication** > **Sign-in method**
2. Enable **Email/Password** provider
3. Save the changes


### Firestore Setup

1. In the Firebase Console, go to **Firestore Database**
2. Click **Create database**
3. Choose **Start in production mode** or **Start in test mode** (for development)
4. Select a location for your database
5. Set up security rules:
## Usage

### Authentication

- Launch the app and you'll be presented with the login/signup screen
- Create a new account or log in with existing credentials


### Managing Notes

- **View Notes**: All your notes are displayed on the home screen
- **Create Note**: Tap the floating action button to create a new note
- **Edit Note**: Tap on any note to edit its content
- **Delete Note**: Swipe left on a note to delete it
- **Search**: Use the search bar at the top to find specific notes

### Installation Steps

1. **Clone the repository**


git clone https://github.com/yourusername/flutter-notes-app.git
cd flutter-notes-app

Install dependencies

flutter pub get
