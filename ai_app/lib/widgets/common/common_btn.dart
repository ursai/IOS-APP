import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonBtn extends StatelessWidget {
  const CommonBtn(
      {super.key,
      this.text,
      required this.onPressed,
      this.size,
      this.backgroundColor,
      this.foregroundColor,
      this.textStyle,
      this.child});

  final Size? size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;
  final String? text;
  final TextStyle? textStyle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(size ?? Size(342.w, 55.w)),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        foregroundColor: MaterialStateProperty.all(foregroundColor),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(39.w))),
      ),
      onPressed: onPressed,
      child: child ??
          Text(text ?? '', style: textStyle ?? TextStyle(fontSize: 14.w)),
    );
  }
}
