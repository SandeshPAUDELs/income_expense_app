import 'package:finance_app/view_models/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                    labelText: 'Username',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ))),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                  labelText: 'Password',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)))),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                // color: Theme.of(context).colorScheme.onPrimary,
                shadowColor: Theme.of(context).colorScheme.background,
                minimumSize: const Size(200, 50),
              ),
              child: Text(
                'Login',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.background),
              ),
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
            // TextButton(onPressed: Navigator.of(context).pushReplacement(RegisterScreen), child: Text('Register')),
          ],
        ),
      ),
    );
  }
}
