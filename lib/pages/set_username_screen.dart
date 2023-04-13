import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SetUsernameScreen extends StatefulWidget {
  @override
  _SetUsernameScreenState createState() => _SetUsernameScreenState();
}

class _SetUsernameScreenState extends State<SetUsernameScreen> {
  TextEditingController _usernameController = TextEditingController();

  final _storage = FlutterSecureStorage();

  void _saveUsername() async {
    await _storage.write(key: 'username', value: _usernameController.text);
    await Navigator.pushReplacementNamed(context, '/square');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set Username')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveUsername,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
