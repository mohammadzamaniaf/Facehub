import 'package:facehub/features/chat/presentation/screens/chats_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/core/widgets/round_icon_button.dart';

class MessengerWidget extends StatelessWidget {
  const MessengerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ChatsScreen.routeName);
      },
      child: const RoundIconButton(
        icon: FontAwesomeIcons.facebookMessenger,
      ),
    );
  }
}
