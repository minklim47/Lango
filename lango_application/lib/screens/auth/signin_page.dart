import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lango_application/services/firebase_auth_methods.dart';
import 'package:lango_application/theme/color_theme.dart';
import 'package:lango_application/theme/custom_theme.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({super.key});

  @override
  _UsernamePasswordSigninState createState() => _UsernamePasswordSigninState();
}

class _UsernamePasswordSigninState extends State<SingInPage> {
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
      await FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );

      // Navigate to the "/welcome" route regardless of the login success
      context.go("/");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign in',
      theme: CustomTheme.customTheme,
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.cream,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                height: MediaQuery.of(context).size.height - 50,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Column(
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/icons/lango_icon-v2.png'),
                          width: 265,
                          height: 265,
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
                                  borderSide: BorderSide.none),
                              fillColor: AppColors.white,
                              filled: true,
                              prefixIcon: const Icon(
                                Icons.person,
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
                              return 'Invalid Password. Please Try Again.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    const SizedBox(height: 30),
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
                            style: TextStyle(fontSize: 20, fontFamily: 'Inter'),
                          ),
                        )),
                    const SizedBox(height: 5),
                    const Center(
                        child: Text("OR",
                            style:
                                TextStyle(fontSize: 16, fontFamily: 'Inter'))),
                    const SizedBox(height: 5),
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
                        onPressed: () {
                          FirebaseAuthMethods(FirebaseAuth.instance)
                              .signInWithGoogle(context);
                        },
                        iconSize: 40,
                        icon: Image.asset('assets/icons/google.png'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(fontFamily: 'Inter', decoration: TextDecoration.underline),
                        ),
                        TextButton(
                            onPressed: () {
                              context.go("/signup");
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontFamily: 'Inter'),
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
  }
}
