import 'dart:developer';

import 'package:doctorappointmentbookingapp/colorScheme.dart';
import 'package:doctorappointmentbookingapp/models/validator.dart';
import 'package:doctorappointmentbookingapp/screens/sign_up_screen.dart';
import 'package:doctorappointmentbookingapp/services/doctor_service.dart';
import 'package:doctorappointmentbookingapp/services/email_auth_service.dart';
import 'package:doctorappointmentbookingapp/services/network_connection_service.dart';
import 'package:doctorappointmentbookingapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  static const String title = 'signInScreen';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isConnected = false;
  bool _passwordVisible = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    refresh();
    super.initState();
  }


  Future refresh() async {
    log('Refreshing sign in screen...');
    _isConnected = await NetworkConnection.isConnected();
    setState(() {});
  }

  void unfocus(BuildContext context) {
    // log('unfocus');
    FocusScope.of(context).unfocus();
  }

  void popCount({required BuildContext context, required int count}) {
    Navigator.popUntil(context, (route) => count-- == 0);
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments ?? 1;
    int countScreensToPop = arguments as int;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Doctor Sign In',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
        ),
        body: WillPopScope(
          onWillPop: () async {
            popCount(context: context, count: countScreensToPop);
            return true;
          },
          child: GestureDetector(
            onTap: () => unfocus(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: signinForm(
                        context: context,
                        countScreensToPop: countScreensToPop),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget signinForm( {required BuildContext context, required int countScreensToPop}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              inputField(
                controller: _emailController,
                hintText: 'Enter e-mail',
                validator: Validator.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 12,
              ),
              inputField(
                controller: _passwordController,
                hintText: 'Enter password',
                validator: Validator.validatePassword,
                obscureText: !_passwordVisible,
                suffixIcon: passwordVisibilityIconButton,
              ),
              const SizedBox(
                height: 30,
              ),
              
              ElevatedButton(
                onPressed: () async {
                  await refresh();
                  showProgress(
                    context: context,
                    willPop: false,
                    text: 'Please wait...',
                  );
                  if (_isConnected) {
                    if (_formKey.currentState!.validate()) {
                      unfocus(context); // Dismiss keyboard
                      final res = await EmailAuth.signInUser(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                      );
                      if (res != null && _auth.currentUser != null) {
                        log('${_auth.currentUser!.emailVerified}');
                        // if(_auth.currentUser!.emailVerified){
                        //   await _auth.currentUser!.sendEmailVerification();

                        // }
                        await DoctorService.setCurrentDoctor(uid: _auth.currentUser!.uid);
                        log('Sign in successful');
                        popCount(context: context, count: countScreensToPop);
                      }
                    }
                  } else {
                    showSnackBar(
                        text: 'No internet connection', context: context);
                  }
                  Navigator.pop(context);
                },
                // onPressed: null,
                child: const Text(
                  'Sign In', 
                  style: TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.bold
                  )
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 65),
                    primary: getStartedColorEnd,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text("Don't have an account!", style: TextStyle(
                fontSize: 18,
              )),
              const SizedBox(
                height: 6,
              ),
              InkWell(
                onTap: () {
                  unfocus(context);
                  countScreensToPop == 1
                      ? Navigator.pushNamed(context, SignUpScreen.title,
                          arguments: 2)
                      : Navigator.pop(context);
                },
                child: const Text("Sign Up",
                    style: TextStyle(
                        color: Colors.lightBlueAccent,
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
              ),
              const SizedBox(
                height: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton get passwordVisibilityIconButton {
    return IconButton(
      icon: _passwordVisible
          ? Icon(
              Icons.visibility,
            )
          : Icon(
              Icons.visibility_off,
            ),
      onPressed: () {
        setState(() {
          _passwordVisible = !_passwordVisible;
        });
      },
      padding: EdgeInsets.only(right: 8),
      color: _passwordVisible ? Colors.lightBlueAccent : null,
    );
  }
}
