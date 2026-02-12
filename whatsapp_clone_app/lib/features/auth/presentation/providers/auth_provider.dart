import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone_app/core/router/app_router.dart';
import 'package:whatsapp_clone_app/features/auth/data/repositories/auth_repository.dart';


class AuthState {
  final bool isLoading;
  final String? error;
  final User? user;

  AuthState({
    this.isLoading = false,
    this.error,
    this.user,
  });

  AuthState copyWith({
    bool? isLoading,
    String? error,
    User? user,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(AuthState());

  Future<void> signInWithPhone(
    BuildContext context,
    String phoneNumber,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      await _authRepository.signInWithPhone(
        context: context,
        phoneNumber: phoneNumber,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> verifyOTP(
    BuildContext context,
    String verificationId,
    String userOTP,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      await _authRepository.verifyOTP(
        context: context,
        verificationId: verificationId,
        userOTP: userOTP,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> saveUserDataToFirebase(
    BuildContext context,
    String name,
    File? profilePic,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      await _authRepository.saveUserDataToFirebase(
        name: name,
        profilePic: profilePic,
      );
      if (context.mounted) {
        context.pushNamed(AppRoutes.home);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Stream<User?> get authStateChanges =>
      _authRepository.authStateChanges;

  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}

final authRepositoryProvider = Provider((ref) => AuthRepository());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});
