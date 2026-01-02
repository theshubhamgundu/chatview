# ChatView Connect Example

A Flutter app demonstrating the use of `chatview_connect` — a wrapper around the `chatview` package that supports multiple cloud backends. This example is currently configured to use a **Local Mock Service** for easy demonstration without any external cloud dependencies.

### Prerequisites

1. [Flutter SDK](https://docs.flutter.dev/release/archive#stable-channel) (version 3.22.0 or higher)

### Running the Example App

1. Clone the repository
2. Navigate to the example directory:
   ```bash
   cd example
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Local Mock Service

By default, this example initializes `ChatViewConnect` with `ChatViewCloudService.local`. This means all data (messages, users, chats) is stored in memory and will reset when the app is restarted. This is ideal for testing the UI and integration without needing a Firebase project.

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize with local service (no Firebase needed)
  ChatViewConnect.initialize(
    ChatViewCloudService.local,
  );

  // Sets the mock current user ID
  ChatViewConnect.instance.setCurrentUserId('mock_user_id');
  
  runApp(const ChatViewConnectExampleApp());
}
```

## Code Structure

The example app follows a modular structure:

- `main.dart`: Entry point with ChatViewConnect setup.
- `modules/`: Feature-based screens and components.
    - `chat_list/`: Chat conversations list screen.
    - `chat_detail/`: Individual chat screen.
    - `create_chat/`: Screen for creating new chats.

## Additional Resources

- [ChatView Connect Documentation](https://github.com/theshubhamgundu/chatview)
