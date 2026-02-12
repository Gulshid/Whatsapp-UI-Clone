import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone_app/core/theme/app_theme.dart';
import 'package:whatsapp_clone_app/features/auth/presentation/providers/auth_provider.dart';


class UserInfoPage extends ConsumerStatefulWidget {
  const UserInfoPage({super.key});

  @override
  ConsumerState<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  void saveUserData() {
    String name = nameController.text.trim();
    if (name.isNotEmpty) {
      ref.read(authProvider.notifier).saveUserDataToFirebase(
            context,
            name,
            image,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: image != null ? FileImage(image!) : null,
                      radius: 64.r,
                      backgroundColor: AppColors.greyLight,
                      child: image == null
                          ? Icon(
                              Icons.person,
                              size: 64.sp,
                              color: AppColors.greyDark,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: AppColors.tealGreen,
                        radius: 20.r,
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 20.sp,
                            color: AppColors.white,
                          ),
                          onPressed: selectImage,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: isLoading ? null : saveUserData,
                  child: isLoading
                      ? SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('CONTINUE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}