import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ship_apps/core/constants/colors.dart';
import 'package:ship_apps/core/helper/helper_functions.dart';
import 'package:ship_apps/core/routes/constants.dart';
import 'package:ship_apps/core/theme/text_style.dart';
import 'package:ship_apps/core/widgets/cliper_oval.dart';
import 'package:ship_apps/core/widgets/cliper_wave.dart';
import 'package:ship_apps/core/widgets/show_dialog.dart';
import 'package:ship_apps/features/authentication/data/auth_remote_data_service.dart';
import 'package:ship_apps/features/authentication/domain/auth_data_model.dart';
import 'package:ship_apps/features/authentication/presentation/cubit/auth_change_cubit.dart';
import 'package:ship_apps/features/authentication/presentation/cubit/auth_cubit.dart';

import '../../../../core/routes/routes.dart';
import '../../../authentication/data/auth_remote_data_source.dart';
import '../../../authentication/presentation/provider/password_visibility.dart';
import '../../../authentication/presentation/widgets/custom_button.dart';
import '../../../authentication/presentation/widgets/custom_form_field.dart';
import '../widgets/custom_edit_data_profile.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel userCache;
  const EditProfileScreen({
    super.key,
    required this.userCache,
  });

  @override
  State<StatefulWidget> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  //Get Image From Gallery
  bool isImageChanged = false;
  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();

  getImageFromGallery() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      // isImageChanged = true;
      imgXFile;
    });
  }

  late TextEditingController usernameController;
  late TextEditingController emailController;
   TextEditingController newEmailController = TextEditingController(text: '');
   TextEditingController newPasswordController = TextEditingController(text: '');

  late String oldAvatarUrl;
  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: widget.userCache.username);
    emailController = TextEditingController(text: widget.userCache.email);
    oldAvatarUrl = widget.userCache.avatarUrl!;
  }

  @override
  void dispose(){
    super.dispose();
    usernameController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AppRouter.router.go(Routes.profileNamedPage);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: SColors.primaryBackground,
          title: Text("Profile"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              AppRouter.router.go(Routes.profileNamedPage);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: OvalClipperStack(
          borderRadius: 2000,
          topStart: SHelperFunctions.screenHeight(context) * 0.002,
          // height: ,
          // borderRadius: 25,
          // topStart: SHelperFunctions.screenHeight(context) * 0.01,
          // height: SHelperFunctions.screenHeight(context) * 1,
          primaryColor: SColors.primaryBackground,
          secondaryColor: SColors.secondaryBackground,
          child: Padding(
            padding: EdgeInsets.all(21),
              child: SingleChildScrollView(
                child: Column(children: [
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthSuccess) {
                        UserModel user = state.user;
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            Material(
                              shape: CircleBorder(
                                side: BorderSide(
                                  color: Colors.white, // Border color
                                  width: 4.0, // Border width
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: Colors.yellow,
                                radius:
                                    SHelperFunctions.screenWidth(context) * 0.11 -
                                        4, // Subtracting border width
                                child: CircleAvatar(
                                  radius:
                                      SHelperFunctions.screenWidth(context) * 0.10 -
                                          4,
                                  // Subtracting the border width
                                  backgroundColor: Colors.transparent,
                                  // Transparent background for inner CircleAvatar
                                  backgroundImage: imgXFile != null
                                      ? FileImage(File(imgXFile!.path))
                                      : NetworkImage(user.avatarUrl!), // Im
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: SHelperFunctions.screenWidth(context) * 0.11,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.yellow, // Border color
                                    width: 2.0, // Border width
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (state is AuthFailed) {
                        return Center(child: Text("Error: ${state.error}"));
                      } else if (state is AuthLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return Container();
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      getImageFromGallery();
                    },
                    child: Text("Ubah Foto Profile"),
                    style: TextButton.styleFrom(
                      foregroundColor:
                          SColors.black, // Change this to your desired color
                    ),
                  ),
                  SizedBox(height: SHelperFunctions.screenHeight(context) * 0.02),
                  Divider(
                    color: SColors.black,
                    height: SHelperFunctions.screenHeight(context) * 0.02,
                    // thickness: 0.7,
                  ),
                  SizedBox(height: SHelperFunctions.screenHeight(context) * 0.03),
                  Container(
                    width: SHelperFunctions.screenWidth(context) * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: SColors.white),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                                    title: 'Username ',
                                    controller: usernameController,
                                  ),
                             SizedBox(height: SHelperFunctions.screenHeight(context) * 0.02),
                            Text("Email",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 6),
                            GestureDetector(
                               child: Container(
                                 width: double.infinity,
                                 padding: EdgeInsets.all(15),
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(17),
                                   color: SColors.white,
                                   border: Border.all(
                                     color: SColors.black
                                   )
                                 ),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text(emailController.text),
                                     Icon(Icons.arrow_forward_ios)
                                   ],
                                 ),
                               ),
                               onTap: (){
                                 print("Test");
                                 showDialog(
                                   context: context,
                                   builder: (BuildContext context) {
                                     return AlertDialog(
                                       title: Text('Change Email'),
                                       content: TextField(
                                         controller: newEmailController,
                                         decoration: InputDecoration(
                                           hintText: 'Enter new email',
                                         ),
                                       ),
                                       actions: <Widget>[
                                         TextButton(
                                           child: Text('Batal'),
                                           onPressed: () {
                                             AppRouter.router.pop();
                                           },
                                         ),
                                         BlocConsumer<AuthChangeCubit, AuthChangeState>(
                                           listener: (context, state) {
                                             if (state is AuthChangeEmailRequestSuccess) {
                                               CustomShowDialog
                                                   .showOnPressedDialog(context,
                                                   title: "Sukses",
                                                   message: "Email telah dirubah anda harus login ulang",
                                                   isCancel: false,
                                                   onPressed: () {
                                                     context.read<AuthCubit>()
                                                         .signOut();
                                                     AppRouter.router
                                                         .pushReplacement(Routes
                                                         .signInNamedPage);
                                                   }
                                               );
                                             } else if (state is AuthChangeEmailFailed) {
                                               print('Error from UI ${state.error}');
                                               CustomShowDialog
                                                   .showCustomDialog(context,
                                                   title: "Error",
                                                   message: state.error,
                                                   isCancel: false
                                               );
                                             }
                                           },
                                           builder: (context, state) {

                                             if (state is AuthChangeLoading) {
                                               return Center(
                                                   child: CircularProgressIndicator());
                                             }
                                             return TextButton(
                                               child: Text('Simpan'),
                                               onPressed: () {
                                                 context.read<AuthChangeCubit>()
                                                     .updateEmail(
                                                     newEmail: newEmailController
                                                         .text);
                                                 AppRouter.router.pop();
                                               },
                                             );
                                           },
                                         ),
                                       ],
                                     );
                                   },
                                 );

                                 },
                             ),
//
                          SizedBox(height: SHelperFunctions.screenHeight(context) * 0.02),
                            Text("Password",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 6),
                            GestureDetector(
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17),
                                    color: SColors.white,
                                    border: Border.all(
                                        color: SColors.black
                                    )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("**************"),
                                    Icon(Icons.arrow_forward_ios)
                                  ],
                                ),
                              ),
                              onTap: (){
                                print("Test");
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Change Password'),
                                      content: Container(
                                        height: SHelperFunctions.screenHeight(context) * 0.12,
                                        child: Column(
                                          children: [
                                            Consumer<PasswordVisibilityProvider>(
                                              builder: (context, passwordVisibilityProvider, _) {
                                              return TextField(
                                              obscureText: passwordVisibilityProvider.obscureText,
                                              controller: newPasswordController,
                                              decoration: InputDecoration(
                                                hintText: 'Enter new password',
                                              ),
                                            );
                                          },
                                        ),
                                        Row(
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
                                        ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Batal'),
                                          onPressed: () {
                                            AppRouter.router.pop();
                                          },
                                        ),
                                        BlocConsumer<AuthChangeCubit, AuthChangeState>(
                                          listener: (context, state) {
                                            if (state is AuthChangePasswordSuccess) {
                                              print(state.newPassword);
                                              CustomShowDialog
                                                  .showOnPressedDialog(context,
                                                  title: "Sukses",
                                                  message: "Password telah dirubah anda harus login ulang",
                                                  isCancel: false,
                                                  onPressed: () {
                                                    context.read<AuthCubit>().signOut();
                                                    AppRouter.router.pushReplacement(Routes.signInNamedPage);
                                                  }
                                              );
                                            } else if (state is AuthChangePasswordFailed) {
                                              CustomShowDialog.showCustomDialog(context,
                                                  title: "Error",
                                                  message: state.error,
                                                  isCancel: false
                                              );
                                            }
                                          },
                                          builder: (context, state) {
                                            if (state is AuthChangeLoading) {
                                              return Center(
                                                  child: CircularProgressIndicator());
                                            }
                                            return TextButton(
                                              child: Text('Simpan'),
                                              onPressed: () {
                                                context.read<AuthChangeCubit>()
                                                    .updatePassword(
                                                    newPassword:newPasswordController.text);
                                                AppRouter.router.pop();
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );

                              },
                            ),
                
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) async {
                                if (state is AuthSuccess) {
                                  UserModel user = state.user;
                                  usernameController.text = user.username;
                                  emailController.text = user.email!;
                                  CustomShowDialog.showCustomDialog(context,
                                      title: "Sukses",
                                      message: "Profile Berhasil Diupdate",
                                      isCancel:  false
                                  );
                                } else if (state is AuthFailed) {
                                  CustomShowDialog.showCustomDialog(context,
                                      title: "Error",
                                      message: state.error,
                                      isCancel:  false
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
                                  title: 'Save Profile',
                                  margin: EdgeInsets.only(top: 20),
                                  onPressed: () async {
                                    if (emailController.text.isEmpty ||
                                        usernameController.text.isEmpty) {
                                      // Show an error message or handle it as needed
                                      CustomShowDialog.showCustomDialog(
                                          context,
                                          title: "Error",
                                          message: "Please Fill all the required field",
                                          isCancel: false
                                      );
                                    } else {
                                        context.read<AuthCubit>().updateProfile(
                                              isImageChanged: imgXFile != null,
                                              oldAvatarUrl: oldAvatarUrl,
                                              username: usernameController.text,
                                              avatarImage: imgXFile ?? XFile(''), // Pass imgXFile if not null, else pass an empty XFile
                                            );
                
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(height: SHelperFunctions.screenHeight(context) * 0.02),



                          ]
                      ),
                    ),
                  ),
                ]
                ),
              ),
            
          ),
        ),
      ),
    );
  }
}
