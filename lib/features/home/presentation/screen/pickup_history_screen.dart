import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ship_apps/features/home/domain/history_data_model.dart';
import 'package:ship_apps/features/home/presentation/cubit/history_cubit.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/helper/helper_functions.dart';
import '../../../../core/theme/text_style.dart';
import '../cubit/resi_cubit.dart';

class PickupHistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PickupHistoryScreenState();
}

class _PickupHistoryScreenState extends State<PickupHistoryScreen>{
  @override
  void initState() {
    context.read<HistoryCubit>().fetchAllHistory();
    super.initState();
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

                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("HISTORI \nPENGAMBILAN",
                    style: STextStyle.titleStyle,
                  textAlign: TextAlign.center,),
                  SizedBox(height: SHelperFunctions.screenHeight(context) * 0.01),
                  Text("Anda dapat mengetahui semua\nriwayat pengambilan paket",
                    style: STextStyle.bodyStyle.copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: SHelperFunctions.screenHeight(context) * 0.03),

                  Expanded(
                    child: BlocBuilder<HistoryCubit, HistoryState>(
                      builder: (context, state) {
                        if (state is AllHistorySuccess){
                          List<HistoryDataModel> historys = state.history;
                          return ListView.builder(
                            shrinkWrap: true,
                            controller: ScrollController(),
                            itemCount: historys.length,
                            itemBuilder: (context, index) {
                              HistoryDataModel history = historys[index];
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                margin: EdgeInsets.all(10),
                                // height: SHelperFunctions.screenHeight(context) * 0.1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: SColors.primaryBackground
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Nama    : ${history.nama}",style: STextStyle.labelStyle,),
                                    Text("Waktu   : ${DateFormat('kk.mm\n'
                                        '                 dd/MM/yyyy').format(DateTime.parse(history.waktu))}"),
                                    // Text("Waktu   : ${DateFormat('kk.mm\n'
                                    //     '                 dd/MM/yyyy').format(history.waktu)}",style: STextStyle.labelStyle,),
                                    Text("Status   : ${history.status}",style: STextStyle.labelStyle,),
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