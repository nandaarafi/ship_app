import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ship_apps/core/widgets/cliper_oval.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/helper/helper_functions.dart';
import '../../../../core/routes/constants.dart';
import '../../../../core/routes/routes.dart';
import '../../data/auth_remote_data_source.dart';
import '../cubit/auth_cubit.dart';
import '../provider/password_visibility.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<User?>? _authSubscription;

  User? _user;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
    _authSubscription = _auth.authStateChanges().listen((User? event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        child: Text('Login untuk memulai \nAplikasi ini',
            style: Theme.of(context).textTheme.headlineMedium),
      );
    }

    Widget inputSection() {
      Widget emailInput() {
        final emailFocusNode = FocusNode(); // Create a FocusNode
        return CustomTextFormField(
          title: 'Email ',
          controller: emailController,
        );
      }
      Widget checkBoxTampilkanPassword() {
        return Row(
          children: [
            Consumer<PasswordVisibilityProvider>(
              builder: (context, passwordVisibilityProvider, _) {
              return Checkbox(
              checkColor: SColors.white,
              value: !passwordVisibilityProvider.obscureText,
              onChanged: (value) {
                passwordVisibilityProvider.toggleObscureText();
              },
              // fillColor: SColors.white,
            );
              },
            ),
            Text("Tampilkan Password", style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: SColors.black
            ),)
          ],
        );
      }
      Widget passwordInput() {
        final passFocusNode = FocusNode(); // Create a FocusNode
        return Consumer<PasswordVisibilityProvider>(
            builder: (context, passwordVisibilityProvider, _) {
          return CustomTextFormField(
              title: 'Password',
              obsecureText: passwordVisibilityProvider.obscureText,
              controller: passwordController,
          );
        });
      }
      Widget forgotPassword() {
        return Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              AppRouter.router.push(Routes.signUpNamedPage);
            },
            child: const Text(
              "BUAT AKUN",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: SColors.primary
              ),
            ),
          ),
        );
      }


      Widget haventAccount() {
        return Align(
          alignment: Alignment.center,
            child: const Text(
              "Belum mempunyai akun?",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: SColors.black
              ),
            ),
        );
      }

      Widget submitButton() {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              AppRouter.router.go(Routes.profileNamedPage);
            } else if (state is AuthFailed) {
              SHelperFunctions.dismissKeyboard(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Error"),
                  content: Text(state.error),
                  actions: [
                    TextButton(
                      onPressed: () {
                        AppRouter.router.pop();
                      },
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomButton(
              title: 'LOGIN',
              margin: EdgeInsets.only(top: 20),
              onPressed: () {
                context.read<AuthCubit>().signInRole(
                      email: emailController.text,
                      password: passwordController.text,
                    );
              },
            );
          },
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Container(
          height: SHelperFunctions.screenHeight(context) * 0.56,
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 29,
          ),
          decoration: BoxDecoration(
            color: SColors.white,
            borderRadius: BorderRadius.circular(17),
          ),
          child: Column(
            children: [
              emailInput(),
              SizedBox(height: 20),
              passwordInput(),
              checkBoxTampilkanPassword(),
              submitButton(),
              SizedBox(height: SHelperFunctions.screenHeight(context) * 0.04),
              haventAccount(),
              forgotPassword(),
            ],
          ),
        ),
      );
    }
    // Background
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) {},
      child: Scaffold(
        body: OvalClipperStack(
          topStart: SHelperFunctions.screenHeight(context) * 0.05,
          borderRadius: 300,
          secondaryColor: SColors.secondaryBackground,
          primaryColor: SColors.primaryBackground,
          child: SingleChildScrollView(
            child: Column(children: [
              Text("SELAMAT DATANG",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: SColors.black
                      ),
                    ),
                    Text("Ketuk untuk melanjutkan",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: SColors.black,
                          fontSize: 16
                      ),
                    ),

                    Image.asset("assets/images/vector_asset/icon1.png",
                      height: SHelperFunctions.screenHeight(context) * 0.25,
                    ),
              inputSection()
            ],),
          ),



        )

        ),
    );
  }
}
