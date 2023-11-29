import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hogme_user_prod/services/authentication_services/authentication_services.dart';
import 'package:hogme_user_prod/views/authentication_screens/login_screen.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../../views/dashboard_screens/home.dart';

class AuthChanges extends StatelessWidget {
  const AuthChanges({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Check the user's role here
            Users? user =
                Provider.of<AuthenticationService>(context).currentUser;

            if (user != null) {
              if (user.role.toLowerCase() == 'farmer') {
                // If the user is a Farmer, navigate to the home page
                return const Home();
              } else {
                // If the user is not a Farmer, show a snackbar and log them out
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Your role is not Farmer.'),
                      duration:
                          Duration(seconds: 3), // Set duration to 5 seconds
                    ),
                  );

                  // Log out the user
                  Provider.of<AuthenticationService>(context, listen: false)
                      .signOut();
                });

                return const LoginScreen();
              }
            } else {
              // If user is null, log out and show login screen
              Provider.of<AuthenticationService>(context, listen: false)
                  .signOut();
              return const LoginScreen();
            }
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
