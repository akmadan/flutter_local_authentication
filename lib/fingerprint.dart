import 'package:flutter/material.dart';
import 'package:flutter_local_authentication/home.dart';
import 'package:flutter_local_authentication/services/local_auth.dart';
import 'package:local_auth/local_auth.dart';

class FingerPrintScreen extends StatefulWidget {
  const FingerPrintScreen({Key? key}) : super(key: key);

  @override
  _FingerPrintScreenState createState() => _FingerPrintScreenState();
}

class _FingerPrintScreenState extends State<FingerPrintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FingerPrint'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  final isAuthenticated = await LocalAuth.authenticate();
                  if (isAuthenticated) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  }
                },
                child: Text('Authenticate')),
            ElevatedButton(
                onPressed: () async {
                  final isAvailable = await LocalAuth.hasBiometrics();
                  final biometrics = await LocalAuth.getBiometrics();

                  final hasFingerprint =
                      biometrics.contains(BiometricType.fingerprint);

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Availability'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildText('Biometrics', isAvailable),
                          buildText('Fingerprint', hasFingerprint),
                        ],
                      ),
                    ),
                  );
                },
                child: Text('Check Fingerprints')),
          ],
        ),
      ),
    );
  }

  Widget buildText(String text, bool checked) => Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            checked
                ? Icon(Icons.check, color: Colors.green, size: 24)
                : Icon(Icons.close, color: Colors.red, size: 24),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 24)),
          ],
        ),
      );
}
