import 'package:flutter/material.dart';

class TextCustom extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;

  final String? fontFamily;

  const TextCustom(
    this.text, {
    super.key,
    this.style,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyMedium;

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: (style ?? defaultStyle)?.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        fontFamily: fontFamily,
      ),
    );
  }
}
