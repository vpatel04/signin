import 'package:flutter/material.dart';
import 'package:signin/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signin/models/user.dart';

class home extends StatelessWidget {
    home({Key? key}) : super(key: key);

    final FirebaseAuth _auth = FirebaseAuth.instance;

    @override
    Widget build(BuildContext context) {
    return Scaffold(
    body: Container(),
    floatingActionButton: FloatingActionButton(
    onPressed: () {
    _signOut(context);
    },
    tooltip: 'Log Out',
    child: const Icon(Icons.logout),
    ),
    );
    }

    void _signOut(BuildContext context) async {
    ScaffoldMessenger.of(context).clearSnackBars();
    await _auth.signOut();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('User logged out.')));
    Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (con) => AppDriver()));
    }
    }