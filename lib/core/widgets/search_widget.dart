import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/core/widgets/round_icon_button.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoundIconButton(
      icon: FontAwesomeIcons.magnifyingGlass,
    );
  }
}
