import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ship_apps/core/constants/colors.dart';
import 'package:ship_apps/features/home/presentation/cubit/packet_cubit.dart';

import '../../../../core/helper/helper_functions.dart';
import '../../../../core/theme/text_style.dart';

class PacketCapacityScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _PacketCapacityScreenState();
}

class _PacketCapacityScreenState extends State<PacketCapacityScreen>{
  @override
  void initState(){
    context.read<PacketCubit>().fetchRealtimePacket();
    super.initState();
  }
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
            image: AssetImage('assets/images/background/kapasitas_kotak_paket.jpg'), // Replace with your image path
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
                padding:EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical:16.0 ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('STATUS KOTAK PAKET',
                    style: STextStyle.titleStyle,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SHelperFunctions.screenHeight(context) * 0.02),
                  BlocBuilder<PacketCubit, PacketState>(
                    builder: (context, state) {
                      if (state is PacketStreamSuccess){
                        final String data = state.packet;
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: SColors.primaryBackground,
                          ),
                          // height: SHelperFunctions.screenHeight(context) * 0.02,
                          child: Text(data,
                            style: STextStyle.titleStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 23
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else if (state is PacketLoading){
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: SColors.primaryBackground,
                          ),
                          // height: SHelperFunctions.screenHeight(context) * 0.02,
                          child: Center(child: CircularProgressIndicator()
                          ),
                        );
                      } else if (state is PacketFailed){
                        return Center(child: Text("Error"));
                      } return Container();

        },
      ),
                  SizedBox(height: SHelperFunctions.screenHeight(context) * 0.02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("KETERANGAN",
                    style: STextStyle.titleStyle.copyWith(
                          fontSize: 27
                    ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("1.  Kosong = Aman",
                      style: STextStyle.bodyStyle.copyWith(
                          fontSize: 23,
                          fontWeight: FontWeight.w400
                      ),
                      ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("2. Hampir Penuh \n    Segera Ambil",
                        style: STextStyle.bodyStyle.copyWith(
                            fontSize: 23,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("3. PENUH \n    AMBIL SEKARANG!!!",
                        style: STextStyle.bodyStyle.copyWith(
                            fontSize: 23,
                            fontWeight: FontWeight.w400
                        ),
                      ),

                  ),
                ],
              ),
                ),
            )
      )
      ]
      ),
      ),
    );
  }
}