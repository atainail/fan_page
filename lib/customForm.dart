import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CustomForm extends StatefulWidget {
  const CustomForm({Key? key}) : super(key: key);
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  _CustomForm createState() => _CustomForm();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}

class _CustomForm extends State<CustomForm> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var _name = TextEditingController();
  var _email = TextEditingController();
  var _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      TextField(
        controller: _name,
        decoration: InputDecoration(
          labelText: 'Name',
        ),
      ),
      TextField(
        controller: _email,
        decoration: InputDecoration(
          labelText: 'Email',
        ),
      ),
      TextField(
        controller: _password,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Processing Data')));
            setState(() {
              register();
            });
          }
        },
        child: const Text('Sign Up'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Go Back'),
      ),
    ]));
  }

  Future<void> register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: _email.text, password: _password.text);

      _db
          .collection("users")
          .doc(userCredential.user!.uid)
          .set({
            "name": _name.text,
          })
          .then((value) => null)
          .onError((error, stackTrace) => null);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something Else")));
    } catch (e) {
      print(e);
    }

    setState(() {});
  }
}
