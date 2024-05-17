import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/services/firebase_auth_methods.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/theme/custom_theme.dart';
import 'package:lango_application/utils/showSnackbar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _UsernamePasswordSigninState createState() => _UsernamePasswordSigninState();
}

class _UsernamePasswordSigninState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signInUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );

        if (mounted) {
          context.go(
              "/"); // Route to Language Selection Page after successful login
        }
      } catch (e) {
        if (mounted) {
          String errorMessage;
          if (e is FirebaseAuthException) {
            switch (e.code) {
              case 'user-not-found':
                errorMessage = 'No user found for that email.';
                break;
              case 'wrong-password':
                errorMessage = 'Wrong password provided.';
                break;
              default:
                errorMessage = 'Login failed. Please try again.';
            }
          } else {
            errorMessage = 'An unknown error occurred.';
          }
          showSnackBar(context, errorMessage);
        }
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
      title: 'Sign in',
      theme: CustomTheme.customTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.cream,
        body: LayoutBuilder(
          builder: (context, constraints) {
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
                            SizedBox(height: 50.0),
                            Image(
                              image:
                                  AssetImage('assets/icons/lango_icon-v2.png'),
                              width: 197,
                              height: 219,
                            ),
                            SizedBox(height: 60.0),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: AppColors.white,
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: AppColors.grey,
                                ),
                              ),
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
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!regex.hasMatch(value)) {
                                  return 'Enter a valid email address';
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
                                  borderSide: BorderSide.none,
                                ),
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
                                  return 'Invalid Password. Please Try Again.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.only(top: 3, left: 3),
                          child: ElevatedButton(
                            onPressed: signInUser,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: AppColors.yellow,
                            ),
                            child: const Text(
                              "SIGN IN",
                              style:
                                  TextStyle(fontSize: 20, fontFamily: 'Inter'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 10),
                        Container(
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: AppColors.grey),
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
                                context.go("/signup");
                              },
                              child: const Text(
                                "Don't have an account? Sign up",
                                style: TextStyle(
                                    color: AppColors.darkBlue,
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    decoration: TextDecoration.underline),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
