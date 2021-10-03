import 'dart:developer';

import 'package:doctorappointmentbookingapp/colorScheme.dart';
import 'package:doctorappointmentbookingapp/models/doctor.dart';
import 'package:doctorappointmentbookingapp/services/doctor_service.dart';
import 'package:doctorappointmentbookingapp/services/firebase_realtime_database_service.dart';
import 'package:flutter/material.dart';
import 'package:doctorappointmentbookingapp/models/validator.dart';
import 'package:doctorappointmentbookingapp/screens/sign_in_screen.dart';
import 'package:doctorappointmentbookingapp/services/email_auth_service.dart';
import 'package:doctorappointmentbookingapp/services/network_connection_service.dart';
import 'package:doctorappointmentbookingapp/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';



class SignUpScreen extends StatefulWidget {
  static const String title = 'signUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specializationController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isConnected = false;
  bool _passwordVisible = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseRef = FirebaseDatabase.instance.reference();
  
  @override
  void initState() {
    refresh();
    super.initState();
  }


  Future refresh() async {
    log('Refreshing sign up screen...');
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
    // printFirebase();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Doctor Registration',
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
                    child: signUpForm(
                        context: context,
                        countScreensToPop: countScreensToPop),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  // void printFirebase() {
  //   databaseRef.once().then((DataSnapshot snapshot) {
  //     print('Data : ${snapshot.value}');
  //   });
  // }

  Widget signUpForm(
      {required BuildContext context, required int countScreensToPop}) {
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
                controller: _nameController,
                hintText: 'Enter name',
                validator: Validator.validateName,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 12,
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
                controller: _specializationController,
                hintText: 'Field of specialisation',
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
                height: 12,
              ),
              inputField(
                controller: _confirmPasswordController,
                hintText: 'Confirm password',
                validator: (value) {
                  return Validator.validateConfirmPassword(
                      value, _passwordController.text);
                },
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
                      log('Email = ${_emailController.text}, Password: = ${_passwordController.text}');
                      final res = await EmailAuth.signUpUser(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                      );
                      if (res != null) {
                        final user = _auth.currentUser!;
                        user.updateDisplayName(_nameController.text); // adding name
                        
                        Doctor doctorInfo = Doctor(
                          uid : user.uid,
                          name: _nameController.text, 
                          email: _emailController.text,
                          specialization: _specializationController.text,
                        );
                        
                        await FirebaseRealtimeDataService.write(
                          path: 'doctors/${user.uid}', 
                          jsonData: doctorInfo.toJson()
                        );
                        log('Sign up successful');
                        await DoctorService.setCurrentDoctor(uid: _auth.currentUser!.uid);
                        popCount(context: context, count: countScreensToPop);
                      }
                    }
                  } else {
                    showSnackBar(
                        text: 'No internet connection', context: context);
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'Sign Up', 
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
              const Text("Already have an account!", style: TextStyle(
                fontSize: 18,
              )),
              const SizedBox(
                height: 6,
              ),
              InkWell(
                onTap: () {
                  unfocus(context);
                  countScreensToPop == 1
                      ? Navigator.pushNamed(context, SignInScreen.title,
                          arguments: 2)
                      : Navigator.pop(context);
                },
                child: const Text("Sign In",
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
                ),
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
