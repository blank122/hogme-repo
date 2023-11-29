import 'package:flutter/material.dart';
import 'package:hogme_user_prod/services/authentication_services/authentication_services.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void signOut(BuildContext context) async {
    // Get the state of the authentication_service
    final authService =
        Provider.of<AuthenticationService>(context, listen: false);

    // Show a dialog with Yes and No options
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                // If the user clicks 'Yes', perform the sign-out
                authService.signOut();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                // If the user clicks 'No', close the dialog without signing out
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(width: 8),
            Text(
              'Hogme',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle shopping cart action
            },
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              // Handle notification action
            },
            icon: const Icon(Icons.notifications),
          ),
          IconButton(
            onPressed: () {
              // Handle user avatar action
            },
            icon: const Icon(Icons.account_circle),
          ),
          IconButton(
            onPressed: () {
              // Handle logout action
              signOut(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Text('Home Page'),
    );
  }
}
