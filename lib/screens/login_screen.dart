
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  String? _emailError;
  String? _passError;
  String? _generalError;
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
   body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white54, Colors.indigoAccent, Colors.white12],
          )
      ),
        child:
            SafeArea(child:
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome Back' , style: TextStyle(fontSize: 30),),
          const SizedBox(height: 35,),
          Container(
            padding: EdgeInsets.all(30),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(

          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withValues(alpha: 0.3)),
          ) ,
            child: Column(
              children: [
              TextField(
                onChanged: (val)=>setState(()=>_emailError=null) ,
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  errorText: _emailError,
                  label: Text('Email'),
                  labelStyle: TextStyle(color: Colors.white54),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
              ),
                const SizedBox(height: 25,),
                TextField(
                  onChanged: (val)=>setState(()=>_passError=null) ,
                  controller: _passwordController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    errorText: _passError,
                      label: Text('Password'),
                      labelStyle: TextStyle(color: Colors.white54),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      )
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 40,),
                SizedBox(width: double.infinity,
             child:   ElevatedButton(onPressed: () async {
                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty){
                        setState(()=>_emailError='Email is required' );
                        setState(()=>_passError='Password is required' );
                    return;
                  }
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim());
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                  on FirebaseAuthException catch (e) {
                 setState(()=>_generalError = e.message?? 'Login Failed');

                  }
                },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.black54,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                   padding: EdgeInsets.symmetric(vertical: 16)
                 ),
                    child: Text('Login' , style: TextStyle(color: Colors.white),)),),
                const SizedBox(height: 30,),
                if(_generalError!=null)
                  Padding(padding: EdgeInsets.only(top: 8) ,child: 
                    Text(_generalError! , style: TextStyle(color: Colors.red),),),
                TextButton(onPressed:(){
                  Navigator.pushNamed(context, '/signup');
                }, child: Text(" Don''t have an account? Signup" , ))
              ],
            ),
          )
              ],
      ),
      )
      )
    );
  }
}
