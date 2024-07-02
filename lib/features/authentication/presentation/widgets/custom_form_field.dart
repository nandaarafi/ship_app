// import 'package:airplane/shared/theme.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors.dart';

class CustomTextFormField extends StatefulWidget {
  final String title;
  final String? hintText;
  final Widget? icon;
  final bool obsecureText;
  final VoidCallback? onTap;
  final TextEditingController controller;
  final bool isEditable;


  const CustomTextFormField({
    Key? key,
    required this.title,
    this.hintText,
    this.onTap,
    this.icon,
    this.obsecureText = false,
    required this.controller,
    this.isEditable = true,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {


  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            height: 6,
          ),
          TextFormField(
            enabled: widget.isEditable,
            textAlign: TextAlign.start,
            autofocus: false,
            onTap: widget.onTap,
            controller: widget.controller,
            cursorColor: Colors.black,
            obscureText: widget.obsecureText,
            style: Theme.of(context).textTheme.bodyMedium,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 17,
              ),
              hintText: widget.hintText,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: BorderSide(color: SColors.black),
              ),
              // enabled: widget.isEditable,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: BorderSide(color: SColors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: BorderSide(color: SColors.black),
              ),
              suffixIcon: widget.icon,
            ),
          ),
        ],
      ),
    );
  }
}
