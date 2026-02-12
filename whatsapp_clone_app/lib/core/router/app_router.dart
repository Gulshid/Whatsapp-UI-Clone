import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_app/features/auth/presentation/pages/login_page.dart';
import 'package:whatsapp_clone_app/features/auth/presentation/pages/otp_page.dart';
import 'package:whatsapp_clone_app/features/auth/presentation/pages/user_info_page.dart';
import 'package:whatsapp_clone_app/features/auth/presentation/pages/welcome_page.dart';
import 'package:whatsapp_clone_app/features/calls/presentation/pages/call_screen_page.dart';
import 'package:whatsapp_clone_app/features/chat/presentation/pages/chat_page.dart';
import 'package:whatsapp_clone_app/features/chat/presentation/pages/group_chat_page.dart';
import 'package:whatsapp_clone_app/features/chat/presentation/pages/select_contact_page.dart';
import 'package:whatsapp_clone_app/features/home/presentation/pages/home_page.dart';
import 'package:whatsapp_clone_app/features/settings/presentation/pages/profile_page.dart';
import 'package:whatsapp_clone_app/features/settings/presentation/pages/settings_page.dart';
import 'package:whatsapp_clone_app/features/status/presentation/pages/status_confirm_page.dart';
import 'package:whatsapp_clone_app/features/status/presentation/pages/status_view_page.dart';

// Route names
class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String userInfo = '/user-info';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String groupChat = '/group-chat';
  static const String selectContact = '/select-contact';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String statusView = '/status-view';
  static const String statusConfirm = '/status-confirm';
  static const String callScreen = '/call-screen';
}

final routerProvider = Provider<AppRouter>((ref) {
  return AppRouter();
});

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      
      case AppRoutes.otp:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OtpPage(
            verificationId: args['verificationId'] as String,
            phoneNumber: args['phoneNumber'] as String,
          ),
        );
      
      case AppRoutes.userInfo:
        return MaterialPageRoute(builder: (_) => const UserInfoPage());
      
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      
      case AppRoutes.chat:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ChatPage(
            userId: args['userId'] as String,
            userName: args['userName'] as String,
            userImage: args['userImage'] as String?,
          ),
        );
      
      case AppRoutes.groupChat:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => GroupChatPage(
            groupId: args['groupId'] as String,
            groupName: args['groupName'] as String,
            groupImage: args['groupImage'] as String?,
          ),
        );
      
      case AppRoutes.selectContact:
        return MaterialPageRoute(builder: (_) => const SelectContactPage());
      
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      
      case AppRoutes.statusView:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => StatusViewPage(
            statusList: args['statusList'] as List,
            initialIndex: args['initialIndex'] as int,
          ),
        );
      
      case AppRoutes.statusConfirm:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => StatusConfirmPage(
            file: args['file'],
            type: args['type'] as String,
          ),
        );
      
      case AppRoutes.callScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CallScreenPage(
            callId: args['callId'] as String,
            isGroupCall: args['isGroupCall'] as bool? ?? false,
            isVideoCall: args['isVideoCall'] as bool? ?? false,
          ),
        );
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

// Navigation helper extensions
extension NavigationExtensions on BuildContext {
  void pushNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }
  
  void pushReplacementNamed(String routeName, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }
  
  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
  
  void pop([Object? result]) {
    Navigator.of(this).pop(result);
  }
}
