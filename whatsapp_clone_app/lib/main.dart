import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/home_screen.dart';
import 'utils/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: getDesign_Size(context),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'WhatsApp',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.backgroundColor,
            primaryColor: AppColors.tealGreen,
            colorScheme: ColorScheme.dark(
              primary: AppColors.tealGreen,
              secondary: AppColors.tealGreenDark,
              surface: AppColors.appBarColor,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.appBarColor,
              elevation: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.light,
              ),
              iconTheme: IconThemeData(color: AppColors.greyColor),
              titleTextStyle: TextStyle(
                color: AppColors.textColor,
                fontSize: 19.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            tabBarTheme: TabBarThemeData(
              indicatorColor: AppColors.tealGreen,
              labelColor: AppColors.tealGreen,
              unselectedLabelColor: AppColors.greyColor,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: AppColors.tealGreen,
              foregroundColor: Colors.white,
            ),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}

Size getDesign_Size(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  if (width < 600) {
    return Size(360, 690);
  } else if (width < 1200) {
    return Size(834, 1194);
  } else {
    return Size(1440, 1024);
  }
}
