import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:linktabbar/secondlinkscreen.dart';
import 'package:linktabbar/thirdlinkscrren.dart';

import 'firstlinkscreen.dart';

class MyTabBarScreen extends StatefulWidget {
  const MyTabBarScreen({super.key});

  @override
  State<MyTabBarScreen> createState() => _MyTabBarScreenState();
}

class _MyTabBarScreenState extends State<MyTabBarScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void switchToTab(int index) {
    if (mounted) {
      _tabController.animateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.blue,
            tabs: const [
              Tab(icon: Icon(Icons.text_fields), text: 'Text'),
              Tab(icon: Icon(Icons.image), text: 'Image'),
              Tab(icon: Icon(Icons.video_collection), text: 'Video'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TextTabScreen(onShare: () => switchToTab(0)),
          ImageTabScreen(onShare: () => switchToTab(1)),
          VideoTabScreen(onShare: () => switchToTab(2)),
        ],
      ),
    );
  }
}
