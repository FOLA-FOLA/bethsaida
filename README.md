# Bethsaida 👁️

**"See through someone else's eyes"**

Bethsaida is a Flutter mobile application that connects visually impaired individuals with volunteers through live video calls, enabling real-time assistance with daily tasks and navigation. The app supports multiple Nigerian languages and provides an accessible interface for both users seeking help and volunteers wanting to assist.

## 🌟 Features

### Core Functionality
- **Dual User Roles**: Support for both visually impaired users and volunteers
- **Live Video Calling**: Real-time video communication with camera controls
- **Multi-language Support**: Available in English, Yoruba, Igbo, Hausa, and Nigerian Pidgin
- **Accessibility First**: Screen reader compatible with semantic announcements
- **Permission Management**: Automatic camera and microphone permission handling

### User Experience
- **Clean, Modern UI**: Dark theme with high contrast for better visibility
- **Intuitive Navigation**: Simple, accessible interface design
- **Real-time Controls**: Toggle camera, microphone, and switch between front/back cameras
- **Connection Management**: Visual feedback during connection and call states

## 🛠️ Technical Stack

### Framework & Language
- **Flutter**: Cross-platform mobile development
- **Dart**: Programming language

### Key Dependencies
- `camera`: Camera functionality and video streaming
- `permission_handler`: Runtime permission management for camera and microphone access

### Architecture
- **Material Design**: Following Material 3 design principles with custom dark theme
- **State Management**: StatefulWidget for reactive UI updates
- **Navigation**: Flutter's built-in navigation system

## 📋 Prerequisites

Before running this app, ensure you have:

1. **Flutter SDK** (3.0.0 or higher)
2. **Dart SDK** (included with Flutter)
3. **Android Studio** or **VS Code** with Flutter extensions
4. **Physical device** (recommended for camera testing)

## 🚀 Installation & Setup

### 1. Clone the Repository
```bash
git clone <repository-url>
cd bethsaida-app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure Permissions

#### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.INTERNET" />
```

#### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSCameraUsageDescription</key>
<string>Bethsaida needs camera access to help visually impaired users through video calls</string>
<key>NSMicrophoneUsageDescription</key>
<string>Bethsaida needs microphone access for voice communication during calls</string>
```

### 4. Run the Application
```bash
# Debug mode
flutter run

# Release mode
flutter run --release
```

## 📱 App Structure

### Main Screens

1. **Role Selection Screen** (`RoleSelectionScreen`)
   - Language selection dropdown
   - Choice between "I need help seeing" and "I want to help someone see"
   - Multi-language interface

2. **Blind User Home Screen** (`BlindUserHomeScreen`)
   - Permission request handling
   - "Call for help" functionality
   - Connection status feedback

3. **Volunteer Home Screen** (`VolunteerHomeScreen`)
   - Volunteer standby interface
   - "Start helping" button
   - Test call functionality for demo purposes

4. **Call Screen** (`CallScreen`)
   - Live video interface
   - Call controls (mute, video toggle, camera switch)
   - Different views for volunteers and users
   - Call duration tracking

### Language Support

The app includes comprehensive translations for:
- **English**: Default language
- **Yoruba**: West African language widely spoken in Nigeria
- **Igbo**: Major language of southeastern Nigeria
- **Hausa**: Primary language of northern Nigeria  
- **Nigerian Pidgin**: Widely understood across Nigeria

## 🎨 Design System

### Color Palette
- **Primary**: `#00D4AA` (Vibrant teal)
- **Secondary**: `#4ECDC4` (Light teal)
- **Background**: `#121212` (Dark gray)
- **Surface**: `#1E1E1E` (Medium dark gray)
- **Accent**: `#2A2A2A` (Control surfaces)

### Typography
- **Font Family**: Inter (clean, modern, accessible)
- **Weights**: Light (300), Regular (400), Medium (500)
- **High Contrast**: Optimized for low vision users

## 🔧 Key Components

### Camera Management
```dart
CameraController _controller;
Future<void> _initializeControllerFuture;
```
- Handles camera initialization and disposal
- Supports front/back camera switching
- Resolution management for optimal performance

### Permission Handling
```dart
Future<void> _requestPermissions() async {
  final cameraStatus = await Permission.camera.request();
  final micStatus = await Permission.microphone.request();
}
```
- Runtime permission requests
- Graceful handling of permission denials
- User feedback for permission states

### State Management
- Local state management using `setState()`
- Screen-specific state isolation
- Timer management for call duration

## 🌍 Localization Implementation

The app uses a dictionary-based translation system:

```dart
final Map<String, Map<String, String>> _translations = {
  'English': { /* English translations */ },
  'Yoruba': { /* Yoruba translations */ },
  // ... other languages
};
```

### Adding New Languages
1. Add language name to `_languages` list
2. Add translation dictionary to `_translations`
3. Ensure all required keys are present

## 🧪 Testing

### Manual Testing Checklist
- [ ] Language switching works correctly
- [ ] Camera permissions are requested properly
- [ ] Video preview displays correctly
- [ ] Call controls function (mute, video toggle, camera switch)
- [ ] Navigation between screens works
- [ ] Screen reader announcements work (for accessibility testing)

### Device Testing
- Test on both Android and iOS devices
- Verify camera functionality on different device models
- Test with different screen sizes and orientations

## 📦 Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  camera: ^0.10.0  # Camera functionality
  permission_handler: ^10.0.0  # Runtime permissions
```

### Dev Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
```

## 🔒 Privacy & Security

### Data Handling
- No personal data storage
- Temporary camera access only during calls
- No video recording or storage
- Minimal permission requests

### Security Considerations
- Camera access restricted to call duration
- No background camera access
- Permission revocation handling

## 🚀 Future Enhancements

### Planned Features
- **Real Backend Integration**: Connect to actual video calling service
- **User Authentication**: Optional account creation for regular volunteers
- **Call History**: Track successful connections (privacy-compliant)
- **Push Notifications**: Alert volunteers to incoming help requests
- **Geographic Matching**: Connect users with nearby volunteers
- **AI Description**: Automatic scene description for complex visual tasks

### Technical Improvements
- **WebRTC Integration**: For actual peer-to-peer video calling
- **Cloud Infrastructure**: Scalable backend for user matching
- **Performance Optimization**: Better camera handling and memory management
- **Offline Support**: Basic functionality when internet is limited

## 🤝 Contributing

### Development Setup
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-feature`
3. Make your changes and test thoroughly
4. Submit a pull request with detailed description

### Coding Standards
- Follow Dart/Flutter style guide
- Use meaningful variable and function names
- Add comments for complex logic
- Maintain accessibility features

### Translation Contributions
Native speakers are welcome to:
- Improve existing translations
- Add new Nigerian languages
- Review cultural appropriateness of interface text

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

### Common Issues

**Camera not working:**
- Ensure permissions are granted
- Restart the app after granting permissions
- Test on physical device (camera doesn't work in simulator)

**Language not changing:**
- Check that all translation keys are present
- Restart the app if needed

**App crashes on startup:**
- Verify Flutter version compatibility
- Run `flutter clean` and `flutter pub get`
- Check device compatibility

### Contact
For support, feature requests, or bug reports, please create an issue in the repository.

## 🙏 Acknowledgments

- The Bible says: This is pure and undefiled religion in the sight of our God and Father, to visit orphans and widows in their distress, and to keep oneself unstained by the world. (True religion is to help those in need, as well as keeping yourself Holy.)
- Inspired by the mission to make technology more accessible
- Built with consideration for the Nigerian accessibility community.