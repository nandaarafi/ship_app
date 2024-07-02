import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ship_apps/core/constants/colors.dart';
import 'package:ship_apps/core/helper/helper_functions.dart';
import 'package:ship_apps/core/theme/text_style.dart';
import 'package:ship_apps/core/widgets/show_dialog.dart';
import 'package:ship_apps/features/home/presentation/cubit/resi_cubit.dart';

import '../../../authentication/presentation/widgets/custom_button.dart';
import '../../../authentication/presentation/widgets/custom_form_field.dart';


class DaftarResiScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DaftarResiScreenState();
}

class _DaftarResiScreenState extends State<DaftarResiScreen> {

  final TextEditingController namaController = TextEditingController(text: '');
  final TextEditingController nomorResiController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: SHelperFunctions.screenHeight(context) * 1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background/daftar_resi.jpg'), // Replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
                top: SHelperFunctions.screenHeight(context) * 0.01,
                left: 0,
                right: 0,
                bottom: 20,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('DAFTAR RESI',
                                style: STextStyle.titleStyle,
                                ),

                            Text("Pastikan nama dan nomor resi\n"
                                "yang anda masukan masukan benar !!",
                              style: STextStyle.bodyStyle,
                              textAlign: TextAlign.center,
                            ),

                          SizedBox(height: SHelperFunctions.screenHeight(context) * 0.02),

                          // Container(child: Text("Test"),)
                          Container(
                            height: SHelperFunctions.screenHeight(context) * 0.4,
                            width: SHelperFunctions.screenWidth(context) * 0.75,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                                color: SColors.white),
                            // color: SColors.white,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  CustomTextFormField(
                                    title: 'Nama',
                                    hintText: "Nama",
                                    controller: namaController,
                                  ),
                                  SizedBox(height: SHelperFunctions.screenHeight(context) * 0.02),
                                  CustomTextFormField(
                                    title: 'Nomor Resi',
                                    hintText: 'Nomor Resi',
                                    controller: nomorResiController,
                                  ),
                                  SizedBox(height: SHelperFunctions.screenHeight(context) * 0.02),

                                  BlocConsumer<ResiCubit, ResiState>(
                                    listener: (context, state) {
                                      if(state is AddResiSuccess){
                                        CustomShowDialog.showCustomDialog(context,
                                            title:  "Sukses",
                                            message:  "Berhasil menambahkan Data",
                                            isCancel:  false
                                        );
                                      } else if (state is ResiFailed){
                                        CustomShowDialog.showCustomDialog(context,
                                            title:  "Error",
                                            message: state.error,
                                            isCancel:  false
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is ResiLoading){
                                        return Center(child: CircularProgressIndicator());
                                      }

                                    return CustomButton(
                                    title: 'SIMPAN',
                                    margin: EdgeInsets.only(top: 20),
                                    onPressed: () {
                                      context.read<ResiCubit>().createNewResi(
                                        nama: namaController.text,
                                        noResi: int.parse(nomorResiController.text),
                                        status: "Diterima",
                                      );
                                    },
                                  );
        },
      ),
                              ],),
                            ),
                          ),
                            // Container(height: SHelperFunctions.screenHeight(context) * 1,)
                          ],
                        ),


                  ),
                )

            )
          ],
        ),
      ),
    );
  }


}