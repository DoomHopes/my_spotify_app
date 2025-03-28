import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_spotify_app/my_app_widget.dart';
import 'package:my_spotify_app/services/helpers/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await AppConfig.loadLocalStorage();
  await AppConfig.loadEnvVariables(env: 'prod');

  runApp(ProviderScope(child: const MyApp()));
}
