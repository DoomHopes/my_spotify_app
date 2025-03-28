// ignore_for_file: unused_element

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_spotify_app/services/auth/auth_service.dart';
import 'package:my_spotify_app/services/helpers/app_config.dart';
import 'package:my_spotify_app/services/helpers/snackbar_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final apiService = ChangeNotifierProvider<ApiService>((ref) {
  return ApiService(ref: ref);
});

class ApiService extends ChangeNotifier {
  final Ref ref;
  String? _token;

  ApiService({required this.ref});

  String? retrieveToken() {
    SharedPreferences localStorage = AppConfig.getLocalStorageInstance();
    if (localStorage.containsKey('token')) {
      final retrievedToken = localStorage.getString('token');
      _token = retrievedToken;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getRequest(String endpoint, Map<String, dynamic> queryParameters,
      {Map<String, String>? headers, bool tokenRequired = true}) async {
    if (tokenRequired) {
      final auth = ref.read(authService);
      if (!auth.isAuth) {
        return null;
      }

      if (null == _token) {
        retrieveToken();
      }
    }

    if (tokenRequired) {
      headers ??= {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token',
        if (kIsWeb) 'Cache-Control': 'no-cache, no-store'
      };
    }

    Uri uri = Uri(
      scheme: AppConfig.get('api_scheme'),
      host: AppConfig.get('api_host'),
      path: AppConfig.get('api_prefix') + endpoint,
      queryParameters: queryParameters,
    );
    if (kDebugMode) {
      print(['request to uri', uri, endpoint]);
      debugPrint(_token);
    }

    try {
      http.Response response = await http.get(uri, headers: headers);
      if (kDebugMode) {
        print(['response', response.body]);
      }
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data.containsKey('exception')) {
        ref.read(snackbarService).showError("API error.", error: "An error occurred while requesting data");
      } else if (data.containsKey('message') && data['message'] == "Unauthenticated.") {
        if (tokenRequired) {
          ref.read(snackbarService).showError("Unauthenticated.", error: "You'll be redirected to login page.");
          Future.delayed(const Duration(seconds: 2)).then((value) {
            ref.read(authService).logOut();
          });
        }
      }

      return data;
    } catch (error) {
      ref.read(snackbarService).showError("API error", error: error.toString());
    }

    return null;
  }

  Future<Map<String, dynamic>?> putRequest(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers, bool tokenRequired = true}) async {
    if (tokenRequired) {
      final auth = ref.read(authService);
      if (!auth.isAuth) {
        return null;
      }

      if (null == _token) {
        retrieveToken();
      }
    }

    headers ??= {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $_token',
    };

    Uri uri = Uri(
      scheme: AppConfig.get('api_scheme'),
      host: AppConfig.get('api_host'),
      path: AppConfig.get('api_prefix') + endpoint,
    );

    if (kDebugMode) {
      print(['request to uri', uri, endpoint]);
      print(['request params', body]);
    }

    try {
      http.Response response = await http.put(uri, headers: headers, body: jsonEncode(body));
      if (kDebugMode) {
        print(['response', response.body]);
      }
      final data = json.decode(response.body) as Map<String, dynamic>;
      return data;
    } catch (error) {
      ref.read(snackbarService).showError("API error", error: error.toString());
    }
    return null;
  }

  Future<Map<String, dynamic>?> postRequest(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers, bool tokenRequired = true, bool shishhh = false}) async {
    if (tokenRequired) {
      final auth = ref.read(authService);
      if (!auth.isAuth) {
        return null;
      }

      if (null == _token) {
        retrieveToken();
      }
    }

    if (tokenRequired) {
      headers ??= {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $_token',
      };
    }

    Uri uri = Uri(
      scheme: AppConfig.get('api_scheme'),
      host: AppConfig.get('api_host'),
      path: AppConfig.get('api_prefix') + endpoint,
    );

    if (kDebugMode) {
      print(['request to uri', uri, endpoint]);
      print(['request params', body]);
    }

    try {
      http.Response response = await http.post(uri, headers: headers, body: jsonEncode(body));
      if (kDebugMode) {
        print(['response', response.body]);
      }

      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data.containsKey('exception')) {
        if (!shishhh) {
          ref.read(snackbarService).showError("API error.", error: "An error occurred while requesting data");
        }
      } else if (data.containsKey('message') && data['message'] == "Unauthenticated.") {
        if (tokenRequired) {
          if (!shishhh) {
            ref.read(snackbarService).showError("Unauthenticated.", error: "You'll be redirected to login page.");
          }
          Future.delayed(const Duration(seconds: 2)).then((value) {
            ref.read(authService).logOut();
          });
        }
      }

      return data;
    } catch (error) {
      if (!shishhh) {
        ref.read(snackbarService).showError("API error", error: error.toString());
      }
    }

    return null;
  }

  Future<Map<String, dynamic>?> deleteRequest(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers, bool tokenRequired = true}) async {
    if (tokenRequired) {
      final auth = ref.read(authService);
      if (!auth.isAuth) {
        return null;
      }

      if (null == _token) {
        retrieveToken();
      }
    }

    headers ??= {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $_token',
    };

    Uri uri = Uri(
      scheme: AppConfig.get('api_scheme'),
      host: AppConfig.get('api_host'),
      path: AppConfig.get('api_prefix') + endpoint,
    );

    if (kDebugMode) {
      print(['request to uri', uri, endpoint]);
    }

    try {
      http.Response response = await http.delete(uri, headers: headers, body: jsonEncode(body));
      if (kDebugMode) {
        print(['response', response.body]);
      }
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data.containsKey('exception')) {
        ref.read(snackbarService).showError("API error.", error: "An error occurred while requesting data");
      } else if (data.containsKey('message') && data['message'] == "Unauthenticated.") {
        ref.read(snackbarService).showError("Unauthenticated.", error: "You'll be redirected to login page.");
        Future.delayed(const Duration(seconds: 2)).then((value) {
          ref.read(authService).logOut();
        });
      }

      return data;
    } catch (error) {
      ref.read(snackbarService).showError("API error", error: error.toString());
    }

    return null;
  }

  void clear() {
    _token = null;
  }
}
