import 'dart:typed_data';
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
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController editUsernameController = TextEditingController();

  String _email = '';
  String _username = '';
  String _profileImageUrl = '';
  File? _image;
  Uint8List? _webImage;
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

        if (mounted) {
          showSnackBar(context, "Username Updated");
          Provider.of<AppProvider>(context, listen: false)
              .updateUsername(editUsernameController.text.trim());
          context.go('/profile');
        }
      } catch (e) {
        if (mounted) {
          showSnackBar(context, 'Error updating username : $e');
        }
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        _webImage = await pickedFile.readAsBytes();
      } else {
        _image = File(pickedFile.path);
      }
    }
    await _uploadImage();
  }

  Future<void> _uploadImage() async {
    if (kIsWeb && _webImage == null) return;
    if (!kIsWeb && _image == null) return;
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${FirebaseAuth.instance.currentUser!.uid}.png');

      if (kIsWeb) {
      } else {}
      // await uploadTask;

      final downloadUrl = await storageRef.getDownloadURL();
      setState(() {
        _profileImageUrl = downloadUrl;
      });

      if (mounted) {
        Provider.of<AppProvider>(context, listen: false)
            .updateProfilePath(_profileImageUrl);

        await users.doc(FirebaseAuth.instance.currentUser!.uid).update({
          'profileImageUrl': _profileImageUrl,
        });
      }     
      if (mounted) {
        showSnackBar(context, "Profile Picture Updated");
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, 'Error uploading profile picture: $e');
        if (kDebugMode) {
          print('Error uploading profile picture: $e');
        }
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
        _username = userData['username'];
        _email = userData['email'];
      });
      editUsernameController.text = _username;
    } else {
      setState(() {});
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
                // CircleAvatar(
                //   radius: 40,
                //   backgroundImage: _profileImageUrl.isNotEmpty
                //       ? NetworkImage(_profileImageUrl)
                //       : null,
                //   child: _profileImageUrl.isEmpty
                //       ? const Icon(Icons.person, size: 40)
                //       : null,
                // ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      Provider.of<AppProvider>(context).imageProfile),
                  child:
                      Provider.of<AppProvider>(context).imageProfile.isNotEmpty
                          ? const Icon(Icons.person, size: 40)
                          : null,
                ),

                IconButton(
                  onPressed: _pickImage,
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
                const Icon(Icons.email, color: AppColors.darkGrey),
                const SizedBox(width: 10),
                Text(
                  _email,
                  style: const TextStyle(
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
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: editUsernameController,
                        decoration: InputDecoration(
                          hintText: "New Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: AppColors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.person, color: AppColors.grey),
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
                const SizedBox(height: 20),
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
