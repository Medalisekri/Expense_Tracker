import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key});

  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
          Text('Login'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('Welcome Back'),
          Text('Login to your account'),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              label: Text('Email'),
              icon: Icon(Icons.email),
            ),
          ),
          const SizedBox(height: 30,),
          TextField(
            controller: _passController,
            decoration: InputDecoration(
              label: Text('Password'),
              icon: Icon(Icons.lock),

            ),
            obscureText: true,
          ),
          const SizedBox(height: 40,),
          TextButton(onPressed: (){
            if(_emailController.text.trim().isEmpty || _passController.text.trim().isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email and pass are required'),));
            return;
            }
            if(_passController.text.length<6){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password should be more than 6 characteres'),));
              return;
            }
            try{
              FirebaseAuth.instance.signInWithEmailAndPassword
                (email: _emailController.text.trim(), password: _passController.text.trim());
              Navigator.pushReplacementNamed(context, '/home');
            }on FirebaseAuthException catch (e){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message?? 'Login Failed'),));
            }
          },
              child:Text('Login') ),
          TextButton(onPressed:
         (){
            Navigator.pushNamed(context, '/signup');
         },
              child: Text('Signup'))
        ],
      ),
    );
  }
}
