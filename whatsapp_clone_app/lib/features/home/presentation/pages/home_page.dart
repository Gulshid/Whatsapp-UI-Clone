import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/router/app_router.dart';
import 'package:whatsapp_clone_app/core/theme/app_theme.dart';
import 'package:whatsapp_clone_app/features/calls/presentation/pages/calls_list_page.dart';
import 'package:whatsapp_clone_app/features/chat/presentation/pages/chat_list_page.dart';
import 'package:whatsapp_clone_app/features/status/presentation/pages/status_list_page.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatsApp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              context.pushNamed(AppRoutes.settings);
            },
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: AppColors.white,
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.white.withOpacity(0.7),
          tabs: const [
            Tab(text: 'CHATS'),
            Tab(text: 'STATUS'),
            Tab(text: 'CALLS'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          ChatListPage(),
          StatusListPage(),
          CallsListPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (tabController.index == 0) {
            context.pushNamed(AppRoutes.selectContact);
          } else if (tabController.index == 1) {
            // Open camera for status
          } else {
            // Start new call
          }
        },
        child: Icon(
          tabController.index == 0
              ? Icons.message
              : tabController.index == 1
                  ? Icons.camera_alt
                  : Icons.add_call,
        ),
      ),
    );
  }
}
