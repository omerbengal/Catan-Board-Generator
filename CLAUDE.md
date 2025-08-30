# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

### Flutter Development
- **Install dependencies**: `flutter pub get`
- **Run app**: `flutter run`
- **Build for release**: `flutter build apk` (Android) or `flutter build ios` (iOS)
- **Clean build files**: `flutter clean`
- **Static analysis**: `flutter analyze`
- **Run tests**: `flutter test`

### Database Management
- Firebase Realtime Database is used for session management and multiplayer functionality
- Firebase configuration files: `firebase_options.dart`, `android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`

## Architecture Overview

### Core Structure
This is a Flutter app that generates randomized Catan board layouts with multiplayer session support. The app follows a provider-based state management pattern.

### Key Components

#### State Management
- **GameProvider** (`lib/providers/game_provider.dart`): Central state management using ChangeNotifier
  - Manages session codes, player UIDs, turn tracking, dice rolls, and user lists
  - Handles Firebase Realtime Database synchronization
  - Contains complex logic for settings dialog state management to prevent unwanted rebuilds

#### Main Navigation
- **MainScreen** (`lib/screens/mainScreen.dart`): TabView container with three main sections:
  - Regular Catan board generation
  - Expansion board generation  
  - Dice rolling with session management

#### Firebase Integration
- **FirebaseService** (`lib/services/firebase_service.dart`): Handles all Firebase operations
- Sessions are stored in Firebase Realtime Database with auto-generated session codes
- Real-time synchronization for multiplayer dice rolling and turn management

#### Screen Hierarchy
```
MainScreen (PageView container)
├── RegularBoardScreen - Standard Catan board generation
├── ExpansionBoardScreen - Extended board layouts
└── DiceScreen - Multiplayer dice rolling with sessions
    ├── SessionButtons - Join/Create session UI
    ├── DiceSection - Dice rolling interface
    └── StatsSection - Game statistics
```

#### Dialog Components
- **CreateSessionDialog**: Session creation with player name input
- **JoinSessionDialog**: Join existing session by code
- **SettingsDialog**: Complex session management including:
  - Player name changes
  - User order randomization/reordering
  - Sophisticated state restoration logic to handle Firebase updates

### Key Implementation Details

#### Session Management
- Session codes are 6-character alphanumeric strings generated via `id_generator.dart`
- User lists maintain order for turn-based gameplay
- Settings dialog includes complex state management to handle concurrent Firebase updates while maintaining UI consistency

#### Asset Organization
- Game assets stored in `assets/images/` (resource tiles, numbers)
- Board layouts in `assets/expansion/` for extended gameplay
- Sound effects in `assets/sounds/`
- New UI elements in `assets/new/`

### Development Notes
- The app uses `analysis_options.yaml` with Flutter lints for code quality
- Provider pattern ensures reactive UI updates across all screens
- Firebase integration requires platform-specific configuration files
- Turn-based logic is synchronized across all connected players in real-time