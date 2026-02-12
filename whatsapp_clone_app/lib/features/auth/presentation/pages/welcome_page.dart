import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/router/app_router.dart';
import 'package:whatsapp_clone_app/core/theme/app_theme.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to WhatsApp',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    Image.asset(
                      'assets/images/whatsapp_logo.png',
                      height: 300.h,
                      width: 300.w,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.chat,
                          size: 200.sp,
                          color: AppColors.tealGreen,
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(AppRoutes.login);
                  },
                  child: const Text('AGREE AND CONTINUE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}