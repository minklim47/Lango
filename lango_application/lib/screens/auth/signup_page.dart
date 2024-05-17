import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:lango_application/screens/auth/signin_page.dart';
import 'package:lango_application/services/firebase_auth_methods.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/theme/custom_theme.dart';
import 'package:lango_application/utils/showSnackbar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signUpUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
        Timestamp timestamp = Timestamp.now();
        int year = timestamp.toDate().year;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': usernameController.text.trim(),
          'email': emailController.text.trim(),
          'progress': {
            'th': {
              'level': 1,
              'stage': 1,
            },
            'es': {
              'level': 1,
              'stage': 1,
            }
          },
          'created_at': year.toString(),
          'selectedReason': '',
          'languageLevel': '',
          'language': 'es',
          'exp': 0,
        });
        // ignore: use_build_context_synchronously
        context.go("/signin");
      } catch (e) {
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'Failed to sign up: $e');
      }
    }
  }

  Future<void> signInWithGoogle() async {
    UserCredential? userCredential =
        await FirebaseAuthMethods(FirebaseAuth.instance).signInWithGoogle();

    if (userCredential != null) {
      DocumentSnapshot docInfo = await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();

      print(docInfo.data());

      // Guard the use of BuildContext with a mounted check
      if (mounted) {
        if (docInfo.exists) {
          context.go("/");
        } else {
          Timestamp timestamp = Timestamp.now();
          int year = timestamp.toDate().year;

          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'username': userCredential.user?.displayName?.split(" ")[0].trim(),
            'email': userCredential.user?.email,
            'progress': {
              'th': {
                'level': 1,
                'stage': 1,
              },
              'es': {
                'level': 1,
                'stage': 1,
              }
            },
            'created_at': year.toString(),
            'selectedReason': '',
            'languageLevel': '',
            'language': 'es',
            'exp': 0,
          });

          if (mounted) {
            context.go("/choose");
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign up',
      theme: CustomTheme.customTheme,
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.cream,
          body: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const Column(
                          children: <Widget>[
                            SizedBox(height: 30.0),
                            Image(
                              image:
                                  AssetImage('assets/icons/lango_icon-v2.png'),
                              width: 112,
                              height: 130,
                            ),
                            SizedBox(height: 40.0),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            TextFormField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                  hintText: "Username",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none),
                                  fillColor: AppColors.white,
                                  filled: true,
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: AppColors.grey,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      borderSide: BorderSide.none),
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
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none),
                                fillColor: AppColors.white,
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.key,
                                  color: AppColors.grey,
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                const pattern =
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&_*~]).{8,}$';
                                RegExp regex = RegExp(pattern);

                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                } else if (!regex.hasMatch(value)) {
                                  return 'Password must contain at least one uppercase letter, one lowercase letter, one number, one special character, and the lenght should at least be 8';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none),
                                fillColor: AppColors.white,
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.key,
                                  color: AppColors.grey,
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Container(
                            padding: const EdgeInsets.only(top: 3, left: 3),
                            child: ElevatedButton(
                              onPressed: signUpUser,
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: AppColors.yellow,
                              ),
                              child: const Text(
                                "SIGN UP",
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'Inter'),
                              ),
                            )),
                        const SizedBox(height: 5),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: AppColors.lightGrey,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                    fontSize: 16, fontFamily: 'Inter'),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: AppColors.lightGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: AppColors.grey,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: signInWithGoogle,
                            iconSize: 40,
                            icon: Image.asset('assets/icons/google.png'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextButton(
                                onPressed: () {
                                  context.go("/signin");
                                },
                                child: const Text(
                                  "Already have an account? Sign in",
                                  style: TextStyle(
                                      color: AppColors.darkBlue,
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      decoration: TextDecoration.underline),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
