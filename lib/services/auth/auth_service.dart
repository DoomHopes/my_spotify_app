// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authService = ChangeNotifierProvider<AuthService>((ref) => AuthService(ref: ref));

class AuthService with ChangeNotifier {
  AuthService({required this.ref});

  final Ref ref;

  String? _token;

  bool get isAuth {
    return null != token;
  }

  String? get token {
    return _token;
  }

  Future<Map> authorize(String email, password, context) async {
    return {};
  }

  Future<void> logOut() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();

    notifyListeners();

    return;
  }
}
