import 'package:chatview_utils/chatview_utils.dart';
import '../storage_service.dart';

class ChatViewLocalStorage implements StorageService {
  @override
  Future<bool> deleteMedia(Message message) async => true;

  @override
  Future<String?> uploadMedia({
    required int retry,
    required Message message,
    required String chatId,
    String? path,
    String? fileName,
  }) async => null;

  @override
  Future<bool> deleteAllMedia(String chatId) async => true;
}
