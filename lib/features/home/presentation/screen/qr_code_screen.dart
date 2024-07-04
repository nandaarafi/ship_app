import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ship_apps/core/constants/colors.dart';
import 'package:ship_apps/core/helper/helper_functions.dart';
import 'package:ship_apps/core/theme/text_style.dart';

import '../../../../core/routes/routes.dart';
import '../../../authentication/domain/auth_data_model.dart';

class QrCodeScreen extends StatefulWidget {
  final UserModel userCache;
  const QrCodeScreen({
    super.key,
    required this.userCache,
  });
  @override
  State<StatefulWidget> createState() => _QrCodeScreenState();

}

class _QrCodeScreenState extends State<QrCodeScreen>{
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        AppRouter.router.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: SColors.secondaryBackground,
        body: Padding(
          padding: EdgeInsets.all(16),
        child: Center(
          child: Column(

            children: [
              Text("KODE SAYA",
              style: STextStyle.titleStyle,
              ),
              SizedBox(height: SHelperFunctions.screenHeight(context) * 0.1),
              QrImageView(
                data: widget.userCache.username,
                version: QrVersions.auto,
                size: 250,
              ),
              SizedBox(height: SHelperFunctions.screenHeight(context) * 0.02),

              Text(widget.userCache.username,
              style: STextStyle.bodyStyle,
              ),

          ],
          ),
        ),
        ),
      ),
    );
  }
}