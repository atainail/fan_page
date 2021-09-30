
//import 'dart:html';
import 'package:fan_page/SignUp.dart';
import 'package:fan_page/customForm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fan Page',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'Atai Nail Fan Page Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Text(widget.title),
        ),*/
        key: _formKey,
        body: ListView(
          children :[
            TextFormField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Username'),
            ),
            TextFormField(
                obscureText: _isObscure,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        })),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                }),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Validating...')),
                  );
                }
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomForm()),
                );
              },
              child: Text('Sign Up'),
            ),
          ]), // This trailing comma makes auto-formatting nicer for build methods.
          );
  }
}
