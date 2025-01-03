import 'package:flutter/material.dart';
import 'package:my_equran/app.dart';
import 'package:my_equran/utils/fingerprint_auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => {
                FingerprintAuth.authenticate().then((isAuthenticated) {
                  if (isAuthenticated) {
                    print("Authentication succeeded");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavigation())
                      ,(Route<dynamic> route) => false,
                    );
                  } else {
                    print("Authentication failed");
                    _showNotification(context, "Authenticated Failed", "Your Biometric not registered!");
                  }
                })
              },
              child: const Text("Biometric"),
            ),
            if (error != null) Text(error!)
          ],
        ),
      ),
    );
  }

  void _showNotification(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
