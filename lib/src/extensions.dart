import 'package:chatview_utils/chatview_utils.dart';

import 'enum.dart';
import 'models/chat_room.dart';
import 'models/chat_room_participant.dart';
import 'typedefs.dart';

/// Extension methods for the `String` class.
extension StringExtension on String {
  /// Validates whether the given string is not empty.
  bool get isValidCollectionName => isNotEmpty;

  /// To get chat id from path
  String? get chatId {
    final values = split('/');
    return values.length >= 2 ? values.lastOrNull : null;
  }
}

/// Extension methods for nullable [DateTime] objects.
extension NullableDateTimeExtension on DateTime? {
  /// Checks if [lastMessageTimestamp] is before the current
  /// DateTime instance.
  bool isMessageBeforeMembership(DateTime? lastMessageTimestamp) {
    final dateTime = this;
    return dateTime != null && lastMessageTimestamp?.compareTo(dateTime) == -1;
  }

  /// Compares this nullable [DateTime] with another nullable [other].
  int compareWith(DateTime? other) {
    final a = this;
    final b = other;
    if (a == null && b == null) {
      return 0;
    } else if (a == null) {
      return -1;
    } else if (b == null) {
      return 1;
    } else {
      return a.compareTo(b);
    }
  }
}

/// An extension on `List<ChatRoomParticipant>` to join user names into
/// a single string.
extension ListOfChatRoomParticipantExtension on List<ChatRoomParticipant> {
  /// Joins user names with a specified separator.
  String? toJoinString([String separator = ' ']) {
    if (isEmpty) return null;
    final valueLength = length;
    final lastIndex = valueLength - 1;
    final stringBuffer = StringBuffer();
    for (var i = 0; i < valueLength; i++) {
      final user = this[i];
      final username = user.chatUser?.name ?? '';
      if (username.isEmpty) continue;
      stringBuffer.write(i == lastIndex ? username : '$username$separator');
    }
    return stringBuffer.toString();
  }
}

/// An extension on `List<ChatUser>` to join user names into a single string.
extension ListOfChatUserDmExtension on List<ChatUser> {
  /// Joins user names with a specified separator.
  String? toJoinString([String separator = ' ']) {
    if (isEmpty) return null;
    final valueLength = length;
    final lastIndex = valueLength - 1;
    final stringBuffer = StringBuffer();
    for (var i = 0; i < valueLength; i++) {
      final user = this[i];
      final username = user.name;
      if (username.isEmpty) continue;
      stringBuffer.write(i == lastIndex ? username : '$username$separator');
    }
    return stringBuffer.toString();
  }

  /// Generates a [GroupInfoRecord] by constructing a group name from
  /// participant names and assigning them roles.
  GroupInfoRecord createGroupInfo() {
    final groupNameBuffer = StringBuffer();
    final usersLength = length;
    final lastLength = usersLength - 1;
    final participants = <String, Role>{};
    for (var i = 0; i < usersLength; i++) {
      final user = this[i];
      final userName = user.name;
      groupNameBuffer.write(i == lastLength ? userName : '$userName, ');
      participants[user.id] = Role.admin;
    }
    return (
      groupName: groupNameBuffer.toString(),
      participants: participants,
    );
  }
}

/// A collection of utility extensions for the `DateTime` class.
extension DateTimeExtension on DateTime {
  /// Checks if the current `DateTime` instance represents
  /// the same date and time (up to the minute) as now.
  bool get isNow {
    final providedDateTime = DateTime(year, month, day, hour, minute);
    final now = DateTime.now();
    final nowDateTime =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);
    return providedDateTime.compareTo(nowDateTime) == 0;
  }
}

/// Extension on [Message] to provide utility methods for
/// comparing message creation timestamps.
extension NullablMessageExtension on Message? {
  /// Compares the creation timestamp of this message with another message.
  int compareCreateAt(Message? message) {
    final dateTime = this?.createdAt;
    return dateTime.compareWith(message?.createdAt);
  }

  /// Compares the update timestamp of this message with another message.
  int compareUpdateAt(Message? message) {
    final dateTime = this?.updateAt;
    return dateTime.compareWith(message?.updateAt);
  }
}

/// Extension methods for lists of nullable [ChatRoom] objects.
extension ChatRoomsListExtension on List<ChatRoom?> {
  /// Returns a new list containing only non-null [ChatRoom] objects.
  List<ChatRoom> get toNonEmpty {
    final chatsLength = length;
    return [
      for (var i = 0; i < chatsLength; i++)
        if (this[i] case final chat?) chat,
    ];
  }
}
