import 'package:finance_app/view_models/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
      ],
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                String password = _passwordController.text;

                Provider.of<AuthViewModel>(context, listen: false)
                    .login(username, password, context);
              },
              child: const Text('Login'),
            ),
            Consumer<AuthViewModel>(
              builder: (context, authViewModel, child) {
                if (authViewModel.authenticatedUser != null) {
                  return Text(
                    'Logged in as: ${authViewModel.authenticatedUser!.username}');
                } else if (authViewModel.errorMessage.isNotEmpty) {
                  return Text(
                    authViewModel.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


