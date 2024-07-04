import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ship_apps/core/widgets/cliper_oval.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/helper/helper_functions.dart';
import '../../../../core/routes/constants.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/cliper_rect.dart';
import '../cubit/auth_cubit.dart';
import '../provider/password_visibility.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  // ValueNotifier userCredential = ValueNotifier('');

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();

  getImageFromGallery() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imgXFile;
    });
  }

  @override
  Widget build(BuildContext context) {


    Widget inputSection() {
      Widget usernameInput() {
        // final emailFocusNode = FocusNode(); // Create a FocusNode
        return CustomTextFormField(
          title: 'Username ',
          // hintText: 'admin123 ',
          controller: usernameController,
          // icon: Icon(Icons.mail),
          // focusNode: emailFocusNode,
        );
      }
      Widget emailInput() {
        final emailFocusNode = FocusNode(); // Create a FocusNode
        return CustomTextFormField(
          title: 'Email ',
          // hintText: 'contoh@gmail.com ',
          controller: emailController,
          // icon: Icon(Icons.mail),
          // focusNode: emailFocusNode,
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
                // hintText: 'password',
                // onTap: () => FocusScope.of(context).unfocus(),
                obsecureText: passwordVisibilityProvider.obscureText,
                controller: passwordController,

                // icon: IconButton(
                //     onPressed: () {
                //       passwordVisibilityProvider.toggleObscureText();
                //     },
                //     icon: Icon(passwordVisibilityProvider.obscureText
                //         ? Icons.visibility
                //         : Icons.visibility_off)
                // )
              );
            });
      }
      Widget forgotPassword() {
        return Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              AppRouter.router.push(Routes.signInNamedPage);
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


      Widget submitButton() {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state is AuthSuccess) {
              // SHelperFunctions.dismissKeyboard(context);
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Sukses"),
                  content: Text("Pendaftaran Sukses"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        AppRouter.router.go(Routes.profileNamedPage);
                      },
                      child: Text("OK"),
                    ),
                  ],
                ),
              );
              AppRouter.router.go(Routes.profileNamedPage);
            } else if (state is AuthFailed) {
              // SHelperFunctions.dismissKeyboard(context);
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
              title: 'DAFTAR',
              margin: EdgeInsets.only(top: 20),
              onPressed: () {
                // SHelperFunctions.dismissKeyboard(context);
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty ||
                    usernameController.text.isEmpty ||
                    imgXFile == null) {
                  // Show an error message or handle it as needed
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Error"),
                      content: Text("Please fill in all required fields."),
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
                } else {
                  // Call signUp method only if all required fields are filled
                  context.read<AuthCubit>().signUp(
                    email: emailController.text,
                    password: passwordController.text,
                    username: usernameController.text,
                    avatarImage: imgXFile!

                  );
                  // SHelperFunctions.dismissKeyboard(context);
                }
              },
            );
          },
        );
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Container(
          width: SHelperFunctions.screenWidth(context) * 0.8,
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
              usernameInput(),
              SizedBox(height: 20),
              emailInput(),
              SizedBox(height: 20),
              passwordInput(),
              checkBoxTampilkanPassword(),
              submitButton(),
              // SizedBox(height: SHelperFunctions.screenHeight(context) * 0.04),
              // haventAccount(),
              // forgotPassword(),
            ],
          ),
        ),
      );
    }
    // Background
    return WillPopScope(
    onWillPop:()  async {
      AppRouter.router.pop();
      // AppRouter.router.go(Routes.signInNamedPage);
      return true;
    },
      child: Scaffold(
          body: OvalClipperStack(
            topStart: SHelperFunctions.screenHeight(context) * 0.05,
            secondaryColor: SColors.secondaryBackground,
            primaryColor: SColors.primaryBackground,
            borderRadius: 2000,
            child: SingleChildScrollView(
              child: Column(children: [
                Text("MENU REGISTER",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: SColors.black
                  ),
                ),
                SizedBox(height: 18),
                GestureDetector(
                  onTap: () {
                    getImageFromGallery();
                  },
                  child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: imgXFile == null
                        ? null
                        : FileImage(
                          File(imgXFile!.path)
                    ),
                    radius: SHelperFunctions.screenWidth(context) * 0.20,
                    child: imgXFile == null
                        ? Icon(
                            Icons.add_a_photo,
                            color: Colors.grey,
                            size: SHelperFunctions.screenWidth(context) * 0.20,
                        ) : null,
                  ),
                ),

                inputSection(),

                SizedBox(height: SHelperFunctions.screenHeight(context) * 0.03,),
              
              ],
              
              ),
            ),
              // child: SingleChildScrollView(child: )
          )
      ),
    );
    // );
    // );
  }
}
