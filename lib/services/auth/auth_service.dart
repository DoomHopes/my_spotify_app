// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_spotify_app/services/helpers/app_config.dart';
import 'package:my_spotify_app/services/helpers/snackbar_service.dart';
import 'package:oauth2_client/access_token_response.dart';
import 'package:oauth2_client/spotify_oauth2_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authService = ChangeNotifierProvider<AuthService>((ref) => AuthService(ref: ref));

class AuthService with ChangeNotifier {
  AuthService({required this.ref});

  final Ref ref;

  String? _token;

  bool get isAuth {
    if (null == token) {
      SharedPreferences localStorage = AppConfig.getLocalStorageInstance();
      if (!localStorage.containsKey('token')) {
        return false;
      }

      final retrievedToken = localStorage.getString('token');
      _token = retrievedToken;

      return true;
    }

    return null != token;
  }

  String? get token {
    return _token;
  }

  Future<bool> authorize() async {
    SharedPreferences prefs = AppConfig.getLocalStorageInstance();

    AccessTokenResponse? accessToken;

    SpotifyOAuth2Client client = SpotifyOAuth2Client(
      customUriScheme: 'my.spotify.app',
      redirectUri: 'my.spotify.app://callback',
    );

    var authResp = await client.requestAuthorization(
        clientId: AppConfig.get('client_id'),
        customParams: {'show_dialog': 'true'},
        scopes: ['user-read-private', 'user-read-playback-state', 'user-modify-playback-state', 'user-read-currently-playing', 'user-read-email']);

    if (authResp.error != null) {
      ref.read(snackbarService).showError(authResp.error.toString());
      return false;
    }

    var authCode = authResp.code;

    debugPrint(authCode);

    accessToken = await client.requestAccessToken(
        code: authCode.toString(), clientId: AppConfig.get('client_id'), clientSecret: AppConfig.get('client_secret'));

    debugPrint(accessToken.toString());

    if (accessToken.accessToken != null) {
      prefs.setString('token', accessToken.accessToken!);
      return true;
    }

    return false;
  }

  Future<void> logOut() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('token');

    notifyListeners();

    return;
  }
}
