// ignore_for_file: prefer_const_constructors, unused_field

import 'dart:async';
import 'dart:io';

import '../../models/app_user.dart';
import 'auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseService implements AuthService {
  static AppUser? _currentUser;

  static final _userStream = Stream<AppUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();

    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toAppUser(user);
      controller.add(_currentUser);
    }
  });

  // ignore: annotate_overrides
  AppUser? get currentUser {
    return _currentUser;
  }

  // ignore: annotate_overrides
  Stream<AppUser?> get userChanges {
    return _userStream;
  }

  // ignore: annotate_overrides
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user != null) return;

    credential.user?.updateDisplayName(name);
    // credential.user?.updatePhotoURL(photoURL);
  }

  // ignore: annotate_overrides
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // ignore: annotate_overrides
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  static AppUser _toAppUser(User user) {
    return AppUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageURL: user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
