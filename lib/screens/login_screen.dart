

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          Text('Login'),
          const SizedBox(height: 35,),
          Card(
            child: Column(
              children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  label: Text('Email')
                ),
              ),
                TextField(

                  controller: _passwordController,
                  decoration: InputDecoration(
                      label: Text('Password')
                  ),
                  obscureText: true,

                ),
                const SizedBox(height: 20,),
                TextButton(onPressed: () async {
                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email and password are required" ,
                      style: TextStyle(color: Colors.red) ,)));
                    return;
                  }
                  if(_passwordController.text.length<6){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password should be more than 6 characters" ,
                      style: TextStyle(color: Colors.red),),));
                 return;
                  }
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim());
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                  on FirebaseAuthException catch (e) {
                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.message?? 'Login Failed')));

                  }
                },
                    child: Text('Login')),
                const SizedBox(height: 40,),
                TextButton(onPressed:(){
                  Navigator.pushNamed(context, '/signup');
                }, child: Text('Signup'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
