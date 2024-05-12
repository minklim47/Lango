import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/providers/app_provider.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/utils/showSnackbar.dart';
import 'package:lango_application/widgets/navigator.dart';
import "package:lango_application/widgets/wrapper.dart";
import 'package:lango_application/theme/custom_theme.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController editUsernameController = TextEditingController();

  late User? _currentUser;
  String _email = '';
  String _username = '';
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void dispose() {
    editUsernameController.dispose();
    super.dispose();
  }

  void updateUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'username': editUsernameController.text.trim()});
        Provider.of<AppProvider>(context, listen: false)
            .updateUsername(editUsernameController.text.trim());
        showSnackBar(context, "Username Updated");
        context.go('/profile');
      } catch (e) {
        showSnackBar(context, 'Error updating username : $e');
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
        _email = userData['email'];
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
            child: Column(children: [
          Row(children: [
            IconButton(
              onPressed: () => {context.go("/profile")},
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: Stack(
              alignment: const Alignment(2, 1.2),
              children: [
                const CircleAvatar(
                  radius: 40,
                  // backgroundImage: AssetImage('assets/avatar.png'),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  iconSize: 30,
                ),
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email, color: AppColors.darkGrey),
                SizedBox(width: 10),
                Text(
                  _email,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 15),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      TextFormField(
                        controller: editUsernameController,
                        decoration: InputDecoration(
                          hintText: "Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: AppColors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.person, color: AppColors.grey),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () => context.go("/changepass"),
                  style: CustomTheme.customTheme.outlinedButtonTheme.style,
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
        ])));
  }
}
