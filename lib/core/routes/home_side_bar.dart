import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:provider/provider.dart';
import 'package:ship_apps/core/helper/helper_functions.dart';
import 'package:ship_apps/core/routes/routes.dart';
import 'package:ship_apps/core/routes/side_bar_provider.dart';
import 'package:ship_apps/core/widgets/show_dialog.dart';
import 'package:ship_apps/features/authentication/data/auth_remote_data_source.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../features/authentication/presentation/cubit/auth_cubit.dart';
import '../constants/colors.dart';
import 'constants.dart';


class HomeNavigationDrawer extends StatelessWidget {
  HomeNavigationDrawer({
    required this.child,
    // required this.title,
    super.key,
  });
  final Widget child;
  // final String title;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final currentRoute =  ModalRoute.of(context)?.settings.name;


    final divider = Divider(color: SColors.secondaryBackground, height: 1);
    return PopScope(
      canPop: true,
      onPopInvoked: (didpop){
      },
      child: Scaffold(
        // key: _scaffoldKey,
        appBar: AppBar(
      backgroundColor: SColors.primaryBackground,
      title: const Text('Smart Guard Box'),
      centerTitle: true,
      // leading: GestureDetector(child: Icon(Icons.menu), onTap: (){
      //   _scaffoldKey.currentState?.openDrawer();
        // Provider.of<SideBarProvider>(context, listen: false).setToggled(true);
      // },),
        ),
        body: child,
        drawer: Consumer<SideBarProvider>(
  builder: (context, provider, child) {
  return SidebarX(
          controller: SidebarXController(
              selectedIndex: _calculateSelectedIndex(context),
            // extended: provider.isToggled
            extended: true,
          ),
    theme: SidebarXTheme(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: SColors.secondaryBackground,
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: const TextStyle(color: Colors.black),
            selectedTextStyle: const TextStyle(color: Colors.black),
            itemTextPadding: const EdgeInsets.only(left: 30),
            selectedItemTextPadding: const EdgeInsets.only(left: 30),
            itemDecoration: BoxDecoration(
              border: Border.all(color: SColors.secondaryBackground),
            ),
            selectedItemDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: SColors.accentBackground.withOpacity(0.37),
              ),
              gradient: const LinearGradient(
                colors: [SColors.accentBackground, SColors.secondaryBackground],
              ),
                boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.28),
                  blurRadius: 30,
                )
              ],
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
              size: SHelperFunctions.screenHeight(context) * 0.03,
            ),
            selectedIconTheme: const IconThemeData(
              color: Colors.black,
              size: 30,
            ),
          ),
          // toggleButtonBuilder: (context, extended) {
          //   return Align(
          //     alignment: extended ? Alignment.centerRight : Alignment.center,
          //     child: IconButton(onPressed: () {
          //         provider.toggle();
          //     },
          //         icon: extended ? Icon(Icons.arrow_back_ios_new) : Icon(Icons.arrow_forward_ios)
          //     ),
          //   );
          // },
          extendedTheme: SidebarXTheme(
            width: SHelperFunctions.screenWidth(context) * 0.7,
            decoration: BoxDecoration(
              color: SColors.secondaryBackground,
            ),
            margin: EdgeInsets.only(right: 10),
          ),
          footerDivider: divider,
          // collapseIcon: Icon,
          headerBuilder: (context, extended) {
            return Container(
              width: double.infinity,
               color: SColors.primaryBackground,
              child: SafeArea(
                child: Column(
                  children: [
                  SizedBox(
                    height: SHelperFunctions.screenHeight(context) * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.asset('assets/images/vector_asset/logos_ship_app.png'),
                    ),
                  ),
                  extended ? Text("Smart Guard Box",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                  ),
                  ) : Text(""),
                  extended ? SizedBox(height: SHelperFunctions.screenHeight(context) * 0.03) : SizedBox(),
                ],
                ),
              ),
            );
          },

          items: [
            SidebarXItem(
                icon: Icons.person,
                label: 'Profil',
                onTap: () => _onItemTapped(0, context)
            ),
            SidebarXItem(
                icon: Icons.add,
                label: 'Daftar Resi',
                onTap: () => _onItemTapped(1, context)
            ),
            SidebarXItem(
              icon: Icons.article,
              label: 'Cek Resi',
              onTap: () => _onItemTapped(2, context)
            ),
            SidebarXItem(
              icon: Icons.signal_cellular_alt,
              label: 'Kapasitas Paket',
              onTap: () => _onItemTapped(3, context)
            ),
            SidebarXItem(
                icon: Icons.history,
                label: 'Histori',
                onTap: () => _onItemTapped(4, context)
            ),
            SidebarXItem(
                icon: Icons.logout,
                label: 'Keluar',
                onTap: () => CustomShowDialog.showOnPressedDialog(
                    context,
                    title: "Info",
                    message:  "Apakah anda yakin ingin Logout",
                    isCancel:  true,
                    onPressed: () async {
                              try{
                                context.read<AuthCubit>().signOut();
                                AppRouter.router.pop();
                                AppRouter.router.pushReplacement(Routes.signInNamedPage);
                              } catch (e){
                                CustomShowDialog.showCustomDialog(context,
                                    title: "Error",
                                    message: "Error when logout",
                                    isCancel: false
                                );
                              }

                        },

                ),
            ),
          ],
        );
  },
),
      ),
  
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(Routes.profileNamedPage)) {
      return 0;
    }
    if (location.startsWith(Routes.daftarResiNamedPage)) {
      return 1;
    }
    if (location.startsWith(Routes.checkResiNamedPage)) {
      return 2;
    }
    if (location.startsWith(Routes.packetCapacityNamedPage)) {
      return 3;
    }
    if (location.startsWith(Routes.historyNamedPage)) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(Routes.profileNamedPage);
      case 1:
        GoRouter.of(context).go(Routes.daftarResiNamedPage);
      case 2:
        GoRouter.of(context).go(Routes.checkResiNamedPage);
      case 3:
        GoRouter.of(context).go(Routes.packetCapacityNamedPage);
      case 4:
        GoRouter.of(context).go(Routes.historyNamedPage);
    }
  }
}