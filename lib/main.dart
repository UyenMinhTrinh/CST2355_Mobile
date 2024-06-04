import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String imageSource = "images/question-mark.png";

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    String? username = await secureStorage.read(key: 'username');
    String? password = await secureStorage.read(key: 'password');
  }

  if (username != null && password != null) {
    loginController.text = username;
    passwordController.text = password;
  WidgetsBinding.instance.addPostFrameCallback((_)) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Credentials loaded'),
        action: SnackBarAction(
          label: 'Clear saved data',
          onPressed: () {
          _clearCredentials();
          },
        ),
      );
    }
  }

  Future<void> _saveCredentials(String username, String password) async {
  await secureStorage.write(key: 'username', value: username);
  await secureStorage.write(key: 'password', value: password);
  }

  Future<void> _clearCredentials() async {
  await secureStorage.delete(key: 'username');
  await secureStorage.delete(key: 'password');
  setState(() {
  loginController.clear();
  passwordController.clear();
  });
  }

  void _showSaveDialog() {
    showDialog(context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Save Credentials"),
        content: Text("Would you like to save your login details for next time?"),
        actions: [
          TextButton(onPressed: () {
                        _clearCredentials();
                        Navigator.of(context).pop();
                        }, child: Text("No"),),
          TextButton(onPressed: () {
                        _saveCredentials(loginController.text, passwordController.text);
                        Navigator.of(context).pop();
                        }, child: Text('Yes'),)
                ],
              );
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: loginController,
              decoration: InputDecoration(labelText: 'Login'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (passwordController.text == 'QWERTY123') {
                    imageSource = "images/light-bulb.png";
                  } else {
                    imageSource = "images/stop-sign.png";
                  }
                });
              },
              child: Text('Login'),
            ),
            SizedBox(height: 15),
            Image.asset(
              imageSource,
              width: 300,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}

