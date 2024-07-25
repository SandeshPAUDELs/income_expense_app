import 'package:finance_app/model/data.dart';
import 'package:finance_app/theme.dart';
import 'package:finance_app/view/login_screen.dart';
import 'package:finance_app/view_models/expense_vm.dart';
import 'package:finance_app/view_models/income_vm.dart';
import 'package:finance_app/view_models/navigation_vm.dart';
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
        ChangeNotifierProvider(create: (context) => NavigationViewModel()),
        ChangeNotifierProvider(create: (context) => IncomeViewModel()),
        ChangeNotifierProvider(create: (context) => ExpenseViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme
        ),
        home: LoginScreen(),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    // final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username',
              contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
      ))),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password',
              contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))
              )),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                String password = _passwordController.text;
                final AddUser user = AddUser(username: username, password: password); 
                Provider.of<AuthViewModel>(context, listen: false).addUser(user);
                // Provider.of<AuthViewModel>(context, listen: false).login(username, password, context);
                
              },
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.blue,
                minimumSize: Size(200, 50),
              ),
              child: const Text('Register'),
            ),

           
          ],
        ),
      ),
    );
  }
}


