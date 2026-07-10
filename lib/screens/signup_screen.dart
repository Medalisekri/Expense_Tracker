import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
        title: Text('Sign up'),
      ),
      body: Column(
        children: [
          Card(
            child: Column(
              children: [
                Text('Create an account'),
                const SizedBox(height: 35,),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    label: Text('Email'),
                  ),
                ),
                const SizedBox(height: 15,),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    label: Text('Password'),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 35,),
                TextButton(onPressed: () async{
                  final emailInput = _emailController.text.trim();
                  final passInput = _passwordController.text.trim();
                  try{
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailInput, password: passInput);
                    Navigator.pushReplacementNamed(context, '/home');
                  }on FirebaseAuthException catch (e){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message ?? 'SignUp Failed')));
                  }
                },
                    child: Text('Sign Up'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
