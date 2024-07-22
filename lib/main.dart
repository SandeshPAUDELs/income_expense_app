
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser(String username, String password) async {
    final url = Uri.parse('http://192.168.1.69:8000/login/');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['token'];
      print('Token: $token');

      // Save token to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);

      // Navigate to the company registration page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CompanyPage()),
      );
    } else {
      print('Login failed: ${response.body}');
    }
  }

  // @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final username = _usernameController.text;
                final password = _passwordController.text;
                loginUser(username, password);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class CompanyPage extends StatefulWidget {
  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Company'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
              
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _sourceController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            // Rest of the form fields
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final title = _nameController.text;
                final amount = _amountController.text;
                final date = _dateController.text;
                final description = _descriptionController.text;
                final source = _sourceController.text;
                postCompany(title, amount, date, description, source);
              },
              child: Text('Create Company'),
            ),

            Expanded(child: ListView.builder(itemCount: _companies.length, itemBuilder: ((context, index) => 
            ListTile(
              title: Text(_companies[index]['title']),
              subtitle: Text(_companies[index]['description']),
            ))),)
          ],
        ),
      ),
    );
  }


  Future<void> postCompany(
      String title, String amount, String date, String description, String source) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    final url = Uri.parse('http://192.168.1.69:8000/incomes/');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: json.encode(
        {
          "title": title,
          "amount": double.parse(amount),
          "date": date,
          "description": description,
          "source": source,
        },
      ),
    );

    if (response.statusCode == 201) {
      print('Company created successfully: ${response.body}');
    } else {
      print('Failed to create company: ${response.body}');
    }
  }

  List<dynamic> _companies = [];

  Future<void> fetchCompanies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    final url = Uri.parse('http://192.168.1.69:8000/incomes/');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _companies = json.decode(response.body);
      });
    } else {
      print('Failed to fetch companies: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCompanies();
  }

}
