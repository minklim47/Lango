import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/utils/showSnackbar.dart';
import 'package:lango_application/widgets/navigator.dart';
import "package:lango_application/widgets/wrapper.dart";

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _auth = FirebaseAuth.instance;
  String _currentPassword = '';
  String _newPassword = '';

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        //       AuthCredential credential = EmailAuthProvider.credential(
        //           email: _auth.currentUser!.email!, password: _currentPassword);
        //       await _auth.currentUser!.reauthenticateWithCredential(credential);

        //       await _auth.currentUser!.updatePassword(_newPassword);

        //       showSnackBar(context, 'Password updated successfully');
        //       context.go("/");
        //     } catch (e) {
        //       showSnackBar(context, 'Failed to update password: $e');
        //     }
        //   }
        // }
        final user = _auth.currentUser;
        if (user != null) {
          await _auth.signInWithEmailAndPassword(
            email: user.email!,
            password: oldPasswordController.text,
          );
          await user.updatePassword(_newPassword);
          showSnackBar(context, 'Password updated successfully');
          context.go("/");
        } else {
          showSnackBar(context, 'User not found');
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'Failed to update password: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      bottomNavigationBar: const BottomNav(path: "/changepass"),
      body: Wrapper(
        child: Column(
          children: [
            Row(children: [
              IconButton(
                onPressed: () => {context.go("/edit")},
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ]),
            const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 45),
                child: Row(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Text("Change Password",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ])),
            Expanded(
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: oldPasswordController,
                          decoration: InputDecoration(
                            hintText: "Current Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: AppColors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.key, color: AppColors.grey),
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
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: newPasswordController,
                          decoration: InputDecoration(
                            hintText: "New Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: AppColors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.key, color: AppColors.grey),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your new password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              _newPassword = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            hintText: "Confirm New Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: AppColors.white,
                            filled: true,
                            prefixIcon: Icon(Icons.key, color: AppColors.grey),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your new password';
                            }
                            if (value != newPasswordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _updatePassword(),
                child: const Text("SAVE CHANGES"),
              ),
            )
          ],
        ),
      ),
    );
  }
}