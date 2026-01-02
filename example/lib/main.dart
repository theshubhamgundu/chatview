import 'package:chatview_connect/chatview_connect.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize with local service (no Firebase needed)
  ChatViewConnect.initialize(
    ChatViewCloudService.local,
  );

  // Sets the mock current user ID
  ChatViewConnect.instance.setCurrentUserId(
    'mock_user_id',
  );
  
  runApp(const ChatViewConnectExampleApp());
}
