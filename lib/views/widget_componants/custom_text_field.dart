import 'package:flutter/material.dart';
import '../../app_constanse/app_color.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.maxLine = 1,
      required this.hintText,
      this.onSaved,
      this.onChange,
      this.onTap, this.textEditingController});
  final int? maxLine;
  final String hintText;
  final void Function(String?)? onSaved;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final TextEditingController? textEditingController ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Field is required';
        } else {
          return null;
        }
      },
      controller: textEditingController,
      onTap: onTap,
      onChanged: onChange,
      onSaved: onSaved,
      maxLines: maxLine,
      cursorColor: AppColor.kPrimaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColor.kPrimaryColor),
        border: customBorder(),
        focusedBorder: customBorder(color: AppColor.kPrimaryColor),
      ),
    );
  }

  OutlineInputBorder customBorder({color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? Colors.white),
    );
  }
}
