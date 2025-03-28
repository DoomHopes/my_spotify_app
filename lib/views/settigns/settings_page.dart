import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_spotify_app/services/auth/auth_service.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool isAuth = false;

  @override
  void initState() {
    isAuth = ref.read(authService).isAuth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settigns'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isAuth ? Text('Log out from Spotify') : Text('Log in to Spotify'),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isAuth ? Colors.red : Colors.transparent,
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        textStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: isAuth
                          ? () async {
                              await ref.read(authService).logOut();
                              setState(() {
                                isAuth = false;
                              });
                            }
                          : () async {
                              isAuth = await ref.read(authService).authorize();
                              setState(() {});
                            },
                      child: isAuth ? Text('log out') : Text('Sign in'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
