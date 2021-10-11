import 'dart:js';
import 'package:signin/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signin/models/user.dart';
import 'package:signin/screens/home/home.dart';
import 'package:signin/screens/sign_in.dart';
import 'package:signin/screens/createprofile.dart';
import 'package:signin/screens/home/mainprofile.dart';


class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
  }

  class _RegisterPageState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  late TextEditingController _emailController,
  _reemailController,
  _passwordController,
  _repasswordController,
  _firstnameController,
  _lastnameController,
  _phonenumberController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
  _emailController = TextEditingController();
  _reemailController = TextEditingController();
  _passwordController = TextEditingController();
  _repasswordController = TextEditingController();
  _firstnameController = TextEditingController();
  _lastnameController = TextEditingController();
  _phonenumberController = TextEditingController();

  super.initState();
  }

  @override
  void dispose() {
  _emailController.dispose();
  _reemailController.dispose();
  _passwordController.dispose();
  _repasswordController.dispose();
  _firstnameController.dispose();
  _lastnameController.dispose();
  _phonenumberController.dispose();

  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(
  title: Text("Register"),
  ),
  body: Form(
  key: _formKey,
  child: Column(children: [
  const SizedBox(height: 20.0),
  TextFormField(
  autocorrect: false,
  controller: _emailController,
  validator: (value) {
  if (value == null || value.isEmpty) {
  return 'Please enter some text';
  }
  return null;
  },
  decoration: const InputDecoration(
  labelText: "EMAIL ADDRESS",
  border: OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0))),
  hintText: 'Enter Email'),
  ),
  const SizedBox(height: 20.0),
  TextFormField(
  autocorrect: false,
  controller: _reemailController,
  validator: (value) {
  if (value == null || value != _reemailController.text) {
  return 'Email addresses do not match';
  }
  return null;
  },
  decoration: const InputDecoration(
  labelText: "RE ENTER EMAIL ADDRESS",
  border: OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0))),
  hintText: 'Re-Enter Email'),
  ),
  const SizedBox(height: 20.0),
  TextFormField(
  autocorrect: false,
  controller: _passwordController,
  validator: (value) {
  if (value == null || value.isEmpty) {
  return 'Password cannot be empty';
  }
  return null;
  },
  decoration: const InputDecoration(
  labelText: "ENTER PASSWOR",
  border: OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0))),
  hintText: 'Enter Password'),
  ),
  const SizedBox(height: 20.0),
  TextFormField(
  autocorrect: false,
  controller: _repasswordController,
  validator: (value) {
  if (value == null || value != _passwordController.text) {
  return 'Passwords do not match';
  }
  return null;
  },
  decoration: const InputDecoration(
  labelText: "VERIFY PASSWORD",
  border: OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0))),
  hintText: 'Verify Password'),
  ),
  const SizedBox(height: 20.0),
  TextFormField(
  autocorrect: false,
  controller: _firstnameController,
  validator: (value) {
  if (value == null || value.isEmpty) {
  return 'Passwords do not match';
  }
  return null;
  },
  decoration: const InputDecoration(
  labelText: "Enter Firstname",
  border: OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0))),
  hintText: 'Enter Firstname'),
  ),
  const SizedBox(height: 20.0),
  TextFormField(
  autocorrect: false,
  controller: _lastnameController,
  validator: (value) {
  if (value == null || value.isEmpty) {
  return 'Lastname cannot be empty';
  }
  return null;
  },
  decoration: const InputDecoration(
  labelText: "Enter Lastname",
  border: OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0))),
  hintText: 'Enter Lastname'),
  ),
  const SizedBox(height: 20.0),
  TextFormField(
  autocorrect: false,
  controller: _phonenumberController,
  validator: (value) {
  if (value == null || value.isEmpty) {
  return 'Phonenumber cannot be empty';
  }
  return null;
  },
  decoration: const InputDecoration(
  labelText: "Enter Phonenumber",
  border: OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.0))),
  hintText: 'Enter phone number'),
  ),
  const SizedBox(height: 30.0),
  OutlinedButton(
  onPressed: () {
  if (_formKey.currentState!.validate()) {
  ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('Processing Data')));

  setState(() {
  register();
  });
  }
  },
  child: const Text('Submit'),
  )
  ])));
  }

  Future<void> register() async {
  try {
  UserCredential userCredential =
  await _auth.createUserWithEmailAndPassword(
  email: _emailController.text, password: _passwordController.text);

  _db
      .collection("users")
      .doc(userCredential.user!.uid)
      .set({
  "first_name": _firstnameController.text,
  "last_name": _lastnameController.text,
  "phone": _phonenumberController.text,
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
