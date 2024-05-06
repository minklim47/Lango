import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/utils/showSnackbar.dart';
import 'package:lango_application/widgets/input.dart';
import 'package:lango_application/widgets/navigator.dart';
import "package:lango_application/widgets/wrapper.dart";

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController editUsernameController = TextEditingController();
  final TextEditingController editEmailController = TextEditingController();
  final TextEditingController currentPasswordController = TextEditingController();

  late User? _currentUser;
  String _currentPassword = '';
  String _newEmail = '';
  String _username = '';
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void dispose() {
    editUsernameController.dispose();
    editEmailController.dispose();
    currentPasswordController.dispose();
    super.dispose();
  }

  void updateUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
            email: FirebaseAuth.instance.currentUser!.email!,
            password: _currentPassword);

        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithCredential(credential);

        await FirebaseAuth.instance.currentUser!.verifyBeforeUpdateEmail(_newEmail);

        await users.doc(_currentUser?.uid).update({
          'username': editUsernameController.text.trim(),
          'email': editEmailController.text.trim()
        }).then((value) {
          showSnackBar(context, "User Updated");
          context.go('/');
        }).catchError((error) {
          showSnackBar(context, "Failed to update user: $error");
        });
      } catch (e) {
        showSnackBar(context, 'error updating email : $e');
    
      }

    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        _currentUser = user;
        _username = userData['username'];
      });
    } else {
      setState(() {
        _currentUser = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      bottomNavigationBar: const BottomNav(path: "/edit"),
      body: Wrapper(
        child: Column(
          children: [
            Row(children: [
              IconButton(
                onPressed: () => {context.go("/profile")},
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 45),
              child: Stack(
                alignment: const Alignment(2, 1.2),
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    iconSize: 30,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: editUsernameController,
                          decoration: InputDecoration(
                            hintText: "Username",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: AppColors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.face, color: AppColors.grey),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: currentPasswordController,
                          decoration: InputDecoration(
                            hintText: "Current Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: AppColors.white,
                            filled: true,
                            prefixIcon:
                                Icon(Icons.password, color: AppColors.grey),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your current password';
                            }
                            return null;
                          },
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              _currentPassword = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: editEmailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              fillColor: AppColors.white,
                              filled: true,
                              prefixIcon: const Icon(
                                Icons.email,
                                color: AppColors.grey,
                              )),
                          validator: (value) {
                            const pattern =
                                r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                                r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                                r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                                r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                                r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                                r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                                r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

                            RegExp regex = RegExp(pattern);

                            if (!regex.hasMatch(value!)) {
                              return 'Enter a valid email address';
                            }
                            if (value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _newEmail = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // Add some extra space at the end
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => context.go("/changepass"),
              child: const Text("Change Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => updateUser(),
              child: const Text("SAVE CHANGES"),
            ),
          ],
        ),
      ),
    );
  }
}
