import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/theme/app_theme.dart';
import 'package:whatsapp_clone_app/features/auth/presentation/providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phoneController = TextEditingController();
  Country? country;

  @override
  void initState() {
    super.initState();
    country = Country.parse('PK');
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      context: context,
      onSelect: (Country selectedCountry) {
        setState(() {
          country = selectedCountry;
        });
      },
    );
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (phoneNumber.isNotEmpty && country != null) {
      ref.read(authProvider.notifier).signInWithPhone(
            context,
            '+${country!.phoneCode}$phoneNumber',
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.tealGreen,
      ),
      body: Padding(
        padding: EdgeInsets.all(18.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'WhatsApp will need to verify your phone number.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            TextButton(
              onPressed: pickCountry,
              child: Text(
                country != null ? country!.name : 'Pick Country',
                style: TextStyle(color: AppColors.tealGreen, fontSize: 16.sp),
              ),
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                if (country != null)
                  Text(
                    '+${country!.phoneCode}',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      hintText: 'phone number',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: 90.w,
              child: ElevatedButton(
                onPressed: isLoading ? null : sendPhoneNumber,
                child: isLoading
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('NEXT'),
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
