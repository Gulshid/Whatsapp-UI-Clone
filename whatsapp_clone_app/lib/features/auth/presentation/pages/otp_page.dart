import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:whatsapp_clone_app/core/theme/app_theme.dart';
import 'package:whatsapp_clone_app/features/auth/presentation/providers/auth_provider.dart';


class OtpPage extends ConsumerStatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OtpPage({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void verifyOTP() {
    String otp = otpController.text.trim();
    if (otp.length == 6) {
      ref.read(authProvider.notifier).verifyOTP(
            context,
            widget.verificationId,
            otp,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifying your number'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.tealGreen,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Text(
              'We have sent an SMS with a code to \${widget.phoneNumber}',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            PinCodeTextField(
              appContext: context,
              length: 6,
              controller: otpController,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5.r),
                fieldHeight: 50.h,
                fieldWidth: 40.w,
                activeFillColor: AppColors.white,
                inactiveFillColor: AppColors.greyLight,
                selectedFillColor: AppColors.greyLight,
                activeColor: AppColors.tealGreen,
                inactiveColor: AppColors.greyMedium,
                selectedColor: AppColors.tealGreen,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              onCompleted: (value) {
                verifyOTP();
              },
              onChanged: (value) {},
            ),
            SizedBox(height: 20.h),
            if (isLoading)
              const CircularProgressIndicator(
                color: AppColors.tealGreen,
              ),
          ],
        ),
      ),
    );
  }
}