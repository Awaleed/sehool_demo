import 'package:division/division.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/logo.png'),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: new InputDecoration(
                    suffixIcon: Icon(Icons.person),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[400]),
                    hintText: 'username',
                    fillColor: Colors.white70),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                decoration: new InputDecoration(
                    suffixIcon: Icon(Icons.lock),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20.0),
                      ),
                    ),
                    filled: true,
                    hintStyle: new TextStyle(color: Colors.grey[400]),
                    hintText: 'password',
                    fillColor: Colors.white70),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
