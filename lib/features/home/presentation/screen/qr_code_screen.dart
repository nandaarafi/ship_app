import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ship_apps/core/constants/colors.dart';
import 'package:ship_apps/core/helper/helper_functions.dart';
import 'package:ship_apps/core/routes/constants.dart';
import 'package:ship_apps/core/theme/text_style.dart';
import 'package:ship_apps/core/widgets/show_dialog.dart';
import 'package:ship_apps/features/home/presentation/provider/qr_code_provider.dart';

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
  //
  // QrCodeProvider? _qrCodeProvider;
  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // Save the reference to the provider
  //   _qrCodeProvider = context.read<QrCodeProvider>();
  // }
  //
  // @override
  // void dispose() {
  //   // Reset the isQrCode property when the screen is disposed
  //   _qrCodeProvider?.setQrCode(false);
  //   super.dispose();
  // }
  bool canPop = false;
  // AppRouter.router.pop();
  // Provider.of<QrCodeProvider>(context, listen: false).setQrCode(false);
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: (didPop) {
        if(!canPop){
          canPop = true;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Tekan back lagi untuk kembali"),
            duration: Duration(seconds: 2),
          ));
        }
        else {
          Provider.of<QrCodeProvider>(context, listen: false).setQrCode(false);
        }
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
              SizedBox(height: SHelperFunctions.screenHeight(context) * 0.02),
              Text("QR Code hanya bisa sekali lihat",
              style: STextStyle.bodyStyle.copyWith(color: Colors.red),
              )


            ],
          ),
        ),
        ),
      ),
    );
  }
}