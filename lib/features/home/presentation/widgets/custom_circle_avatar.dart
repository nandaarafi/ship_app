import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helper/helper_functions.dart';
import '../../../authentication/domain/auth_data_model.dart';

class CustomCircleAvatar extends StatefulWidget {
  const CustomCircleAvatar({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<StatefulWidget> createState() => _CustomCircleAvatarState();
}

class _CustomCircleAvatarState extends State<CustomCircleAvatar>{
  @override
  Widget build(BuildContext context) {
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
            radius: SHelperFunctions.screenWidth(context) * 0.11 - 4, // Subtracting border width
            child: CircleAvatar(
              radius: SHelperFunctions.screenWidth(context) * 0.10 - 4, // Subtracting the border width
              backgroundColor: Colors.transparent, // Transparent background for inner CircleAvatar
              backgroundImage: NetworkImage(widget.user.avatarUrl!),
              // backgroundImage: CachedNetworkImageProvider(widget.user.avatarUrl!),
              // child: CachedNetworkImage(
              //   imageUrl: widget.user.avatarUrl!,
              //   progressIndicatorBuilder: (context, url, downloadProgreess) => Shimmer.fromColors(
              //     baseColor: Colors.grey[300]!,
              //     highlightColor: Colors.grey[100]!,
              //     child: CircleAvatar(
              //       radius: SHelperFunctions.screenWidth(context) * 0.10 - 4,
              //       backgroundColor: Colors.grey[300]!,
              //     ),
              //   ),
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              // ),
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
  }
  Widget _buildShimmerAvatar() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: CircleAvatar(
        radius: SHelperFunctions.screenWidth(context) * 0.10 - 4, // Adjust as necessary
        backgroundColor: Colors.white,
      ),
    );
  }


}