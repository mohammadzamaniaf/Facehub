import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '/core/constants/app_colors.dart';
import '/core/screens/loader.dart';
import '/core/utils/utils.dart';
import '/features/chat/presentation/widgets/chat_user_info.dart';
import '/features/chat/presentation/widgets/messages_list.dart';
import '/features/chat/providers/chat_provider.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  static const routeName = '/chat-screeen';

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late final TextEditingController messageController;
  late final String chatroomId;
  bool isChatroomIdInit = false;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.read(chatProvider).createChatroom(userId: widget.userId),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        // Let's make sure we get our chatroom id but only once
        // if (!isChatroomIdInit) {
        chatroomId = snapshot.data ?? 'Chatroom ID doesn\'t exist';
        //   isChatroomIdInit = true;
        // }

        return Scaffold(
          backgroundColor: AppColors.realWhiteColor,
          appBar: AppBar(
            titleSpacing: 0,
            title: ChatUserInfo(
              userId: widget.userId,
            ),
            leading: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.blueColor,
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: MessagesList(
                  chatroomId: chatroomId,
                ),
              ),
              const Divider(height: 1),
              _buildMessageInput(),
            ],
          ),
        );
      },
    );
  }

  // Chat Text Field
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.image,
              color: AppColors.messengerDarkGrey,
            ),
            onPressed: () async {
              final image = await pickImage(source: ImageSource.gallery);
              if (image == null) return;
              await ref.read(chatProvider).sendFileMessage(
                    file: image,
                    chatroomId: chatroomId,
                    receiverId: widget.userId,
                    messageType: 'image',
                  );
            },
          ),
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.video,
              color: AppColors.messengerDarkGrey,
              size: 20,
            ),
            onPressed: () async {
              final video = await pickVideo(source: ImageSource.gallery);
              if (video == null) return;
              await ref.read(chatProvider).sendFileMessage(
                    file: video,
                    chatroomId: chatroomId,
                    receiverId: widget.userId,
                    messageType: 'video',
                  );
            },
          ),
          // Text Field
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.messengerGrey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: 'Aa',
                  hintStyle: TextStyle(),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(
                    left: 20,
                    bottom: 10,
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: AppColors.messengerBlue,
            ),
            onPressed: () async {
              // Add functionality to handle send button press
              await ref.read(chatProvider).sendMessage(
                    message: messageController.text,
                    chatroomId: chatroomId,
                    receiverId: widget.userId,
                  );
              messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}
