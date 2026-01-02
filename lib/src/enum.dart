import 'package:chatview_utils/chatview_utils.dart';

import 'database/database_service.dart';
import 'database/local/chatview_local_database.dart';
import 'storage/local/chatview_local_storage.dart';
import 'storage/storage_service.dart';
import 'typedefs.dart';

/// An enumeration of database types.
enum ChatViewCloudService {
  /// Indicates a Local (Mock) Database.
  local;

  /// Checks if the current database type is Local.
  bool get isLocal => this == local;
}

/// A strongly-typed extension that provides structured access to database
/// and storage services based on the selected [ChatViewCloudService].
extension type const CloudServices._(CloudServicesRecord record) {
  /// Creates an instance of [CloudServices] with the given
  /// [DatabaseService] and [StorageService].
  const CloudServices({
    required DatabaseService database,
    required StorageService storage,
  }) : this._((database: database, storage: storage));

  /// Factory constructor that returns the appropriate implementation of
  /// [CloudServices] based on the provided [ChatViewCloudService].
  factory CloudServices.fromType(ChatViewCloudService type) {
    return switch (type) {
      ChatViewCloudService.local => CloudServices(
          database: ChatViewLocalDatabase(),
          storage: ChatViewLocalStorage(),
        ),
    };
  }

  /// The storage service instance associated with the selected database type.
  StorageService get storage => record.storage;

  /// The database service instance associated with the selected database type.
  DatabaseService get database => record.database;
}

/// An enumeration representing different sorting options for chats.
enum ChatSortBy {
  /// Sorts chats in descending order based on the latest message timestamp.
  newestFirst,

  /// No sorting is applied; chats are retrieved in their default order.
  none;

  /// Returns `true` if the sorting option is set to [newestFirst].
  bool get isNewestFirst => this == newestFirst;

  /// Returns `true` if no sorting is applied.
  bool get isNone => this == none;
}

/// Defines sorting options for messages.
enum MessageSortBy {
  /// Sorts messages by their creation time (`createdAt`).
  createAt('createdAt'),

  /// Sorts messages by their last update time (`update_at`).
  updateAt('update_at'),

  /// No sorting is applied.
  none('');

  const MessageSortBy(this.key);

  /// An internal key associated with the sort type.
  final String key;

  /// Returns `true` if messages are sorted by creation time.
  bool get isCreateAt => this == createAt;

  /// Returns `true` if messages are sorted by update time.
  bool get isUpdateAt => this == updateAt;

  /// Returns `true` if no sorting is applied.
  bool get isNone => this == none;
}

/// An enumeration of messages sorting types.
enum MessageSortOrder {
  /// Sorts messages in ascending order.
  asc,

  /// Sorts messages in descending order.
  desc;

  /// Checks if the sort order type is ascending.
  bool get isAsc => this == asc;

  /// Checks if the sort order type is descending.
  bool get isDesc => this == desc;
}

/// An enumeration of document change types.
enum DocumentType {
  /// Indicates a new document was added.
  added,

  /// Indicates a document was modified.
  modified,

  /// Indicates a document was removed.
  removed;
}

/// Provides utility methods for [TypeWriterStatus].
extension TypeWriterStatusExtension on TypeWriterStatus {
  static TypeWriterStatus parse(String? value) {
    final type = value?.trim().toLowerCase() ?? '';
    if (type.isEmpty) return TypeWriterStatus.typed;
    if (type == TypeWriterStatus.typing.name.toLowerCase()) {
      return TypeWriterStatus.typing;
    } else {
      return TypeWriterStatus.typed;
    }
  }
}

/// Represents the different roles a user can have in the chat system.
enum Role {
  admin,
  user;

  bool get isAdmin => this == admin;
  bool get isUser => this == user;
}

/// Provides utility methods for [RoleExtension].
extension RoleExtension on Role {
  static Role parse(String? value) {
    final type = value?.trim().toLowerCase() ?? '';
    if (type.isEmpty) return Role.admin;
    if (type == Role.admin.name.toLowerCase()) {
      return Role.admin;
    } else {
      return Role.user;
    }
  }
}

/// Represents the membership status of a user in a chat group.
enum MembershipStatus {
  member,
  removed,
  left;

  bool get isMember => this == member;
  bool get isRemoved => this == removed;
  bool get isLeft => this == left;
}

/// Provides utility methods for [MembershipStatusExtension].
extension MembershipStatusExtension on MembershipStatus {
  static MembershipStatus parse(String? value) {
    final type = value?.trim().toLowerCase() ?? '';
    if (type.isEmpty) return MembershipStatus.member;
    if (type == MembershipStatus.removed.name.toLowerCase()) {
      return MembershipStatus.removed;
    } else if (type == MembershipStatus.left.name.toLowerCase()) {
      return MembershipStatus.left;
    } else {
      return MembershipStatus.member;
    }
  }
}
