import 'package:chatview_utils/chatview_utils.dart';

import 'database/database_service.dart';
import 'enum.dart';
import 'models/chat_room_participant.dart';
import 'storage/storage_service.dart';

/// Callback function used for updating reactions.
typedef ReactionCallback = ({String userId, String emoji});

/// A record that encapsulates cloud-based services, including database and
/// storage. This allows managing both services within a single variable.
typedef CloudServicesRecord = ({
  DatabaseService database,
  StorageService storage,
});

/// A callback function for uploading a media to cloud storage.
/// Returns the download URL as a [String] or `null` if the upload fails.
typedef UploadMediaCallback = Future<String?> Function(
  Message message, {
  String? uploadPath,
  String? fileName,
});

/// A callback function for deleting a specific media from storage.
/// Returns `true` if the deletion is successful, otherwise `false`.
typedef DeleteMediaCallback = Future<bool> Function(Message message);

/// A callback function for deleting all media associated with a specific
/// [chatId] from storage.
/// Returns `true` if the operation is successful, otherwise `false`.
typedef DeleteChatMediaCallback = Future<bool> Function(String chatId);

/// Represents a record of chat room participants,
/// including the current user and other users in the chat.
typedef ChatRoomParticipantsRecord = ({
  ChatRoomParticipant? currentUser,
  List<ChatRoomParticipant> otherUsers,
});

/// A record type representing a user's information along with their status.
typedef UserInfoWithStatusRecord = ({
  ChatUser? user,
  UserActiveStatus? userActiveStatus,
});

/// Represents information about a group, including its name and participants.
typedef GroupInfoRecord = ({String groupName, Map<String, Role> participants});

/// Maps a query results of [Message] objects to a custom type [T].
typedef MessageQueryMapper<T> = T Function(dynamic docSnapshot);

/// A callback function that extracts a chat room ID from a given snapshot.
typedef ChatRoomIdCallback<T> = String Function(T snapshot);

/// A callback function for filtering operations.
typedef WhereCallback<T> = bool Function(T item);

/// A record type representing a chat item along with its associated status.
typedef ChatStatusRecord<T> = ({ChatListItem chat, T status});
