// ignore_for_file: unused_field, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hogme_user_prod/models/users.dart';
import 'package:hogme_user_prod/utils/app_theme.dart';
import 'package:hogme_user_prod/utils/custom_buttons.dart';
import 'package:hogme_user_prod/utils/custom_textfield.dart';
import 'package:hogme_user_prod/views/authentication_screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final String _role = "Farmer";
  final String _status = "Pending";

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  PlatformFile? pickedFacilityPictureFile; //the file you want to upload
  PlatformFile? pickedValidIDFile; //the file you want to upload
  UploadTask? uploadTaskFacility;
  UploadTask? uploadTaskValidID;

  Future selectFacilityPicture() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFacilityPictureFile = result.files.first;
    });
  }

  Future selectValidIDPicture() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedValidIDFile = result.files.first;
    });
  }

  Future uploadFile() async {
    if (pickedFacilityPictureFile == null || pickedValidIDFile == null) {
      showErrorMessageSnackBar("Please provide Facility Picture and Valid ID");
      return;
    } else {
      final pathFacilityPath =
          'RegistrationImageUploads/${pickedFacilityPictureFile!.name}';
      final fileFacilityPicture = File(pickedFacilityPictureFile!.path!);

      final refFacility =
          FirebaseStorage.instance.ref().child(pathFacilityPath);

      final pathValidIDPath =
          'RegistrationImageUploads/${pickedValidIDFile!.name}';
      final fileValidIDPicture = File(pickedValidIDFile!.path!);

      final refValidID = FirebaseStorage.instance.ref().child(pathValidIDPath);

      setState(() {
        uploadTaskFacility = refFacility.putFile(fileFacilityPicture);
        uploadTaskValidID = refValidID.putFile(fileValidIDPicture);
      });

      final snapshotFacility = await uploadTaskFacility!.whenComplete(() {});
      final urlDownloadFacility = await snapshotFacility.ref.getDownloadURL();
      print('Facility Picture Download Link: $urlDownloadFacility');

      final snapshotValidID = await uploadTaskValidID!.whenComplete(() {});
      final urlDownloadValidID = await snapshotValidID.ref.getDownloadURL();
      print('Facility Picture Download Link: $urlDownloadValidID');

      createUser(urlDownloadFacility, urlDownloadValidID);
    }
  }

  Future registerUser() async {
    showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      var emailExists = await isEmailAlreadyExists(emailController.text.trim());
      if (emailExists) {
        Navigator.pop(context);
        showErrorMessageSnackBar('Email address is already in use');
        return;
      }

      // Check if the contact number is already in use
      var contactNumberExists = await isContactNumberAlreadyExists(
          contactNumberController.text.trim());
      if (contactNumberExists) {
        Navigator.pop(context);
        showErrorMessageSnackBar('Contact number is already in use');
        return;
      }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await uploadFile(); // Wait for the file to upload
      Navigator.pop(context); // Dismiss the loading dialog
      // Show a Snackbar indicating successful registration
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully!'),
          duration: Duration(seconds: 3),
        ),
      );

      // Navigate to the login screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Navigator.pop(context);
      showErrorMessageSnackBar(
          e.message!); // Display error message in a SnackBar
// Dismiss the loading dialog in case of an error
    }
  }

  void showErrorMessageSnackBar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        duration: const Duration(seconds: 3), // Adjust as needed
      ),
    );
  }

  Future<bool> isEmailAlreadyExists(String email) async {
    var result = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: email)
        .get();

    return result.docs.isNotEmpty;
  }

  Future<bool> isContactNumberAlreadyExists(String contactNumber) async {
    var result = await FirebaseFirestore.instance
        .collection('Users')
        .where('contactnumber', isEqualTo: contactNumber)
        .get();

    return result.docs.isNotEmpty;
  }

  Future<void> createUser(urlDownloadFacility, urlDownloadValidID) async {
    final user = FirebaseAuth.instance.currentUser!;
    final userid = user.uid;

    final docUser = FirebaseFirestore.instance.collection('Users').doc(userid);

    final newUser = Users(
        id: userid,
        firstname: firstnameController.text,
        lastname: lastnameController.text,
        contactnumber: contactNumberController.text,
        email: emailController.text,
        password: passwordController.text,
        profilepicture: '-',
        facilitypicture: urlDownloadFacility,
        valididpicture: urlDownloadValidID,
        status: _status,
        role: _role);
    final json = newUser.toJson();
    await docUser.set(json);
    print('User is created successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo sa hogme

                //slogan

                Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text('Join Hogme'),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: firstnameController,
                      hintText: 'First Name',
                      obscureText: false,
                      icon: const Icon(Icons.person),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    CustomTextfield(
                      controller: lastnameController,
                      hintText: 'Last Name',
                      obscureText: false,
                      icon: const Icon(Icons.person),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    CustomTextfield(
                      controller: contactNumberController,
                      hintText: 'Contact Number',
                      obscureText: false,
                      icon: const Icon(Icons.contact_emergency_sharp),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contact number';
                        }
                        if (value.length != 11) {
                          return 'Contact number must be 11 digits long';
                        }
                        if (!value.startsWith('0')) {
                          return 'Contact number must start with 0';
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(142, 158, 158, 158),
                        ),
                      ),
                      child: Center(
                        child: (pickedFacilityPictureFile == null)
                            ? imgNotExist()
                            : imgExistFacility(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        selectFacilityPicture();
                      },
                      child: const Text("Upload Facility Picture"),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(142, 158, 158, 158),
                        ),
                      ),
                      child: Center(
                        child: (pickedValidIDFile == null)
                            ? imgNotExist()
                            : imgExistValidId(),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        selectValidIDPicture();
                      },
                      child: const Text("Upload Valid ID Picture"),
                    ),
                    CustomTextfield(
                      controller: emailController,
                      hintText: 'Email Address',
                      obscureText: false,
                      icon: const Icon(Icons.email),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    CustomTextfield(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      icon: const Icon(Icons.password),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    CustomTextfield(
                      controller: confirmpasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true,
                      icon: const Icon(Icons.password),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    CustomButtons(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // If all validations pass, call the registerUser function
                            registerUser();
                          }
                        },
                        text: "Sign Up",
                        textColor: Colors.white,
                        buttonColor: AppTheme.primaryButtons),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imgExistFacility() => Image.file(
        File(pickedFacilityPictureFile!.path!),
        width: 150,
        height: 150,
        fit: BoxFit.fitWidth,
      );

  Widget imgExistValidId() => Image.file(
        File(pickedValidIDFile!.path!),
        width: 150,
        height: 150,
        fit: BoxFit.fitWidth,
      );

  Widget imgNotExist() => Image.asset(
        'assets/icons/image.png',
        height: 150,
        fit: BoxFit.cover,
      );
}
