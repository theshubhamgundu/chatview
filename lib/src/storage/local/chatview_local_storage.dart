import 'dart:io';
import '../storage_service.dart';

class ChatViewLocalStorage implements StorageService {
  @override
  Future<void> deleteMedia(String url) async {}

  @override
  Future<String?> uploadMedia(File file, String path) async => null;
}
