// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hogme_user_prod/views/authentication_screens/register_screen.dart';
import 'package:provider/provider.dart';

import '../../services/authentication_services/authentication_services.dart';
import '../../utils/app_theme.dart';
import '../../utils/custom_buttons.dart';
import '../../utils/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //add sign in method
  void signIn() async {
    //get the state of the authentication_service
    final authService =
        Provider.of<AuthenticationService>(context, listen: false);
    //error handling
    try {
      await authService.signIn(emailController.text, passwordController.text);
      // After successful authentication, get the user data
    } catch (e) {
      SnackBar(
        content: Text(
          e.toString(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo sa hogme

                //slogan

                Container(
                  height: 480,
                  width: 325,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text('Nurturing livestocks with innovation'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('Please Login to your Account'),
                      CustomTextfield(
                        controller: emailController,
                        hintText: 'Email Address',
                        obscureText: false,
                        icon: const Icon(Icons.email),
                      ),
                      CustomTextfield(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        icon: const Icon(Icons.password),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [Text('Forgot password?')],
                        ),
                      ),
                      CustomButtons(
                          onPressed: () {
                            signIn();
                          },
                          text: "Sign in",
                          textColor: Colors.white,
                          buttonColor: AppTheme.primaryButtons),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Dont have an account?'),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
