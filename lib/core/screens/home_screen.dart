import 'package:flutter/material.dart';

import '/core/constants/app_colors.dart';
import '/core/constants/constants.dart';
import '../../features/post/presentation/widgets/messenger_widget.dart';
import '../../features/post/presentation/widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColors.greyColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: buildFacebookText(),
          actions: const [
            SearchWidget(),
            MessengerWidget(),
          ],
          bottom: buildMainAppBar(
            controller: _tabController,
            onTap: (_) {
              setState(() {});
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: Constants.homeScreenTabBarChildren,
        ),
      ),
    );
  }
}

Widget buildFacebookText() => const Text(
      'facebook',
      style: TextStyle(
        fontSize: 30,
        color: AppColors.blueColor,
        fontWeight: FontWeight.bold,
      ),
    );

TabBar buildMainAppBar({
  required TabController controller,
  required Function(int? index)? onTap,
}) =>
    TabBar(
      controller: controller,
      onTap: onTap,
      tabs: Constants.getHomeScreenTabs(controller.index),
    );
