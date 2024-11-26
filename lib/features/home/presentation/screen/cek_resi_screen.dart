import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ship_apps/core/constants/colors.dart';
import 'package:ship_apps/core/helper/helper_functions.dart';
import 'package:ship_apps/core/routes/routes.dart';
import 'package:ship_apps/core/theme/text_style.dart';
import 'package:ship_apps/core/widgets/show_dialog.dart';
import 'package:ship_apps/features/home/domain/resi_data_model.dart';
import 'package:ship_apps/features/home/presentation/cubit/resi_cubit.dart';


class CheckResiScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CheckResiScreenState();
}

class _CheckResiScreenState extends State<CheckResiScreen> {

  @override
  void initState(){
    super.initState();
    context.read<ResiCubit>().fetchAllResi();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: SColors.secondaryBackground,
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text("LIST NOMOR RESI",
                style: STextStyle.titleStyle,),
              SizedBox(height: SHelperFunctions.screenHeight(context) * 0.01),
              Text("Pastikan bahwa nomor resi \n anda sudah terdaftar!!",
                style: STextStyle.bodyStyle.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: SHelperFunctions.screenHeight(context) * 0.03),

              Expanded(
                child: BlocBuilder<ResiCubit, ResiState>(
                  builder: (context, state) {
                    if (state is AllResiSuccess){
                      List<ResiDataModel> resis = state.resi;
                      // print(resis);
                      return ListView.builder(
                        shrinkWrap: true,
                        controller: ScrollController(),
                        itemCount: resis.length,
                        itemBuilder: (context, index) {
                          ResiDataModel resi = resis[index];
                          // print(resi.noResi);
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            margin: EdgeInsets.all(10),
                            // height: SHelperFunctions.screenHeight(context) * 0.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: SColors.primaryBackground
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nama    : ${resi.nama}",style: STextStyle.labelStyle,),
                                    // Text("No Resi  : ${resi.noResi}",style: STextStyle.labelStyle,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("No Resi  : ", style: STextStyle.labelStyle,),
                                        Container(
                                            width: SHelperFunctions.screenWidth(context) * 0.4,
                                            child: Text("${resi.noResi}",style: STextStyle.labelStyle)),
                                      ],
                                    ),
                                    Text("Status   : ${resi.status}",style: STextStyle.labelStyle,),
                                ],
                                ),
                                      IconButton(
                                  onPressed: () {
                                    CustomShowDialog.showOnPressedDialog(
                                        context,
                                        title: "Info",
                                        message: "Apakah kamu yakin ingin menghapus Resi ini",
                                        isCancel: true,
                                        onPressed: (){
                                          context.read<ResiCubit>().deleteResi(resiId: resi.id!);
                                          AppRouter.router.pop();
                                        });
                                        },
                                  icon: Icon(Icons.delete),
                                ),

                              ],
                            ),
                          );
                        },
                      );
                    } else if (state is ResiLoading){
                      return Center(child: CircularProgressIndicator(),);
                    } else if (state is ResiFailed) {
                      return Center(child: Text("Error"),);
                    } return Container();
                  },
                ),
              ),
                ],
              ),
            ),)
      ),
    );
  }


}