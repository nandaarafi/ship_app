import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ship_apps/core/helper/helper_functions.dart';
import 'package:ship_apps/core/routes/routes.dart';
import 'package:ship_apps/core/theme/text_style.dart';
import 'package:ship_apps/features/authentication/domain/auth_data_model.dart';
import 'package:ship_apps/features/authentication/presentation/cubit/auth_cubit.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/routes/constants.dart';
import '../../../../core/widgets/cliper_wave.dart';
import '../../../authentication/presentation/widgets/custom_button.dart';
import '../widgets/custom_circle_avatar.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key,

  });

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop){
        //DO NOTHING
        print("Something");
      },
      child: Scaffold(
        body: Stack(
          children: [
          WaveClipperStack(
            height: SHelperFunctions.screenHeight(context) * 0.52,
            primaryColor: SColors.primaryBackground,
            secondaryColor: SColors.secondaryBackground,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthSuccess) {
                        UserModel user = state.user;
                        // final TextEditingController testController = TextEditingController(text: user.email);
                        return Center(
                          child: Text("Selamat Datang ${user.username}",
                            style: STextStyle.titleStyle,
                            textAlign: TextAlign.center,
                          ),
                        );
                        // return Center(
                        //   child: TextField(controller: testController,
                        //     style: STextStyle.titleStyle,
                        //   ),
                        // );
                      } else if (state is AuthLoading) {
                        Center(child: CircularProgressIndicator());
                      } else if (state is AuthFailed) {
                        return Text("error : ${state.error}");
                      }
                      return Container();
                    },
                  ),

                  SizedBox(height: SHelperFunctions.screenHeight(context) * 0.02),

                  Text("Pastikan Paketmu Aman \n"
                      "Dengan Smart Guard Box",
                    style: STextStyle.bodyStyle,
                  ),

                  SizedBox(height: SHelperFunctions.screenHeight(context) * 0.03),

                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthSuccess){
                        UserModel user = state.user;
                        return Container(
                          // height: SHelperFunctions.screenHeight(context) * 0.28,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              color: SColors.white),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CustomCircleAvatar(user: user),
                                    SizedBox(width: SHelperFunctions.screenWidth(context) * 0.05),
                                    Expanded(
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Username",
                                            style: STextStyle.labelStyle,
                                            ),
                                            Text(user.username,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            Text("Email",
                                              style: STextStyle.labelStyle,
                                            ),
                                            Text(user.email!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            ),
                                            Text("Password",
                                              style: STextStyle.labelStyle,
                                            ),
                                            Text("********",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ],
                                        ),
                                    ),
          
                                  ],
          
                                ),
                                CustomButton(
                                  title: 'KODE SAYA',
                                  margin: EdgeInsets.only(top: 20),
                                  onPressed: () {
                                    AppRouter.router.push(Routes.qrCodeNamedPage, extra: user);
                                    //TODO: QR Code Generator
                                  },
                                ),
          
                              ],
                            ),
                          ),
                        );
                      } else if (state is AuthFailed){
                        return Container(
                          height: SHelperFunctions.screenHeight(context) * 0.3,
                          child: Center(
                            child: Text("Error Return Container"),
                          ),
                        );
                      } else if (state is AuthLoading){
                        return Container(
                          height: SHelperFunctions.screenHeight(context) * 0.3,
                          child: Center(child: CircularProgressIndicator(),),
                        );
                      }
                      return Container();
          
                    },
                  ),
          
                ],
              ),
            ),
          ),

            Positioned(
              right: 15,
              bottom: 15,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      if (state is AuthSuccess){
                        UserModel user = state.user;
                        return FloatingActionButton(
                          backgroundColor: SColors.secondaryBackground,

                          onPressed: () {
                            AppRouter.router.go(Routes.editProfileNamedPage, extra: user);
                            // AppRouter.router.go(
                            //     "${Routes.profileNamedPage}/${Routes.editProfileNamedPage}"
                            // );
                          },
                          child: Icon(Icons.edit),
                          shape: CircleBorder(),
                        );
                      } else if (state is AuthFailed){
                        return FloatingActionButton(onPressed: (){}, child: Text("Error"));
                      } else if (state is AuthLoading){
                        return Center(child: CircularProgressIndicator());
                      } return Container();
  },
),
                  const SizedBox(height: 8.0),
                  Text("Edit Profile",
                  style: STextStyle.labelStyle,
                  ),
                ],
              ),
            ),
      ],
        ),
      ),
    );
  }
}


