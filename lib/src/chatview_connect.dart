import 'package:chatview_utils/chatview_utils.dart';
import 'package:flutter/widgets.dart';

import 'chatview_connect_constants.dart';
import 'enum.dart';
import 'extensions.dart';
import 'manager/chat/chat_manager.dart';
import 'manager/chat_list/chat_list_manager.dart';
import 'models/config/chat_controller_config.dart';
import 'models/config/chat_user_config.dart';
import 'models/config/cloud_service_config.dart';

/// A singleton class providing different type of database clouds services for
/// chat views.
final class ChatViewConnect {
  /// Initializes the ChatViewConnect package.
  factory ChatViewConnect.initialize(
    ChatViewCloudService cloudServiceType, {
    ChatUserConfig? chatUserConfig,
    CloudServiceConfig? cloudServiceConfig,
  }) {
    if (_instance == null) {
      _chatUserConfig = chatUserConfig;
      _instance = ChatViewConnect._(cloudServiceType, cloudServiceConfig);
      final service = CloudServices.fromType(cloudServiceType);
      _service = service;
    }
    return _instance!;
  }

  const ChatViewConnect._(this._cloudServiceType, this._cloudConfig);

  final ChatViewCloudService _cloudServiceType;

  final CloudServiceConfig? _cloudConfig;

  static ChatViewConnect? _instance;

  static CloudServices? _service;

  static String? _currentUserId;

  static ChatUserConfig? _chatUserConfig;

  /// Retrieves the current chat user model configuration.
  ChatUserConfig? get getChatUserConfig => _chatUserConfig;

  /// The type of database that is being used.
  ChatViewCloudService get cloudServiceType => _cloudServiceType;

  /// Returns current user's ID
  String? get currentUserId => _currentUserId;

  /// Retrieves a new instance of [ChatListManager] using the current
  /// database service.
  ChatListManager getChatListManager({
    required ScrollController scrollController,
    bool sortEnable = true,
    ChatSorter? chatSorter,
    bool includeEmptyChats = true,
    bool includeUnreadMessagesCount = true,
  }) {
    assert(
      _service != null,
      'ChatViewConnect must be initialized.',
    );
    return ChatListManager.fromService(
      service: _service!,
      scrollController: scrollController,
      chatSorter: chatSorter,
      sortEnable: sortEnable,
      includeEmptyChats: includeEmptyChats,
      includeUnreadMessagesCount: includeUnreadMessagesCount,
    );
  }

  /// Retrieves or initializes a [ChatManager] based on the provided
  /// parameters.
  Future<ChatManager> getChatRoomManager({
    required ScrollController scrollController,
    bool lazyCreateChat = false,
    ChatControllerConfig? config,
    String? chatRoomId,
    ChatUser? currentUser,
    List<ChatUser>? otherUsers,
    ChatRoomType? chatRoomType,
    String? groupName,
    String? groupProfile,
  }) async {
    final tempCurrentUser = currentUser;
    final tempOtherUsers = otherUsers ?? [];
    final tempChatRoomType = chatRoomType;
    final tempChatRoomId = chatRoomId;
    if (tempCurrentUser != null &&
        tempOtherUsers.isNotEmpty &&
        tempChatRoomType != null) {
      return _getChatManagerByUsers(
        config: config,
        groupName: groupName,
        otherUsers: tempOtherUsers,
        groupProfile: groupProfile,
        currentUser: tempCurrentUser,
        chatRoomType: tempChatRoomType,
        scrollController: scrollController,
        lazyCreateChat: lazyCreateChat,
      );
    } else if (tempChatRoomId != null) {
      return _getChatManagerByChatRoomId(
        chatRoomId: tempChatRoomId,
        scrollController: scrollController,
        config: config,
      );
    } else {
      throw Exception(
        'Invalid parameters: '
        'Provide either (currentUser, otherUsers, chatRoomType) or chatRoomId.',
      );
    }
  }

  Future<ChatManager> _getChatManagerByChatRoomId({
    required String chatRoomId,
    required ScrollController scrollController,
    ChatControllerConfig? config,
  }) async {
    final userId = _currentUserId ?? '';
    if (userId.isEmpty) throw Exception("Current User ID can't be empty!");
    if (chatRoomId.isEmpty) throw Exception("Chat Room ID can't be empty!");
    final chatRoomParticipants = await _service?.database.getChatRoomMetadata(
      userId: userId,
      chatId: chatRoomId,
      retry: ChatViewConnectConstants.defaultRetry,
    );
    if (chatRoomParticipants == null) throw Exception('No Users Found!');
    config?.chatRoomMetadata?.call(chatRoomParticipants);
    return ChatManager.fromChatRoomId(
      config: config,
      id: chatRoomId,
      scrollController: scrollController,
      participants: chatRoomParticipants,
      service: CloudServices.fromType(cloudServiceType),
    );
  }

  Future<ChatManager> _getChatManagerByUsers({
    required ChatRoomType chatRoomType,
    required ChatUser currentUser,
    required List<ChatUser> otherUsers,
    required ScrollController scrollController,
    bool lazyCreateChat = false,
    ChatControllerConfig? config,
    String? groupName,
    String? groupProfile,
  }) async {
    final userId = _currentUserId ?? '';
    if (userId.isEmpty) throw Exception("Current User ID can't be empty!");
    if (otherUsers.isEmpty) throw Exception("Other Users can't be empty!");
    if (chatRoomType.isOneToOne) {
      final chatRoomID = await _service?.database.findOneToOneChatRoom(
        userId: userId,
        otherUserId: otherUsers.first.id,
        retry: ChatViewConnectConstants.defaultRetry,
      );
      if (chatRoomID case final chatRoomId?) {
        return _getChatManagerByChatRoomId(
          config: config,
          chatRoomId: chatRoomId,
          scrollController: scrollController,
        );
      }
    }

    String? chatRoomId;

    if (!lazyCreateChat) {
      switch (chatRoomType) {
        case ChatRoomType.oneToOne:
          chatRoomId = await _service?.database.createOneToOneChat(
            userId: userId,
            otherUserId: otherUsers.first.id,
          );
        case ChatRoomType.group:
          final groupInfo = otherUsers.createGroupInfo();
          chatRoomId = await _service?.database.createGroupChat(
            userId: userId,
            groupProfilePic: groupProfile,
            groupName: groupInfo.groupName,
            participants: groupInfo.participants,
          );
      }
    }

    return ChatManager.fromParticipants(
      config: config,
      groupName: groupName,
      otherUsers: otherUsers,
      chatRoomId: chatRoomId,
      currentUser: currentUser,
      groupProfile: groupProfile,
      chatRoomType: chatRoomType,
      scrollController: scrollController,
      service: CloudServices.fromType(cloudServiceType),
    );
  }

  /// Gets the singleton instance of [ChatViewConnect].
  static ChatViewConnect get instance {
    assert(
      _instance != null,
      'ChatViewConnect must be initialized.',
    );
    return _instance!;
  }

  /// To set current user's ID
  void setCurrentUserId(String userId) {
    assert(userId.isNotEmpty, "User ID can't be empty!");
    _currentUserId = userId;
  }

  /// Resets the current user ID by setting it to `null`.
  void resetCurrentUserId() => _currentUserId = null;
}
