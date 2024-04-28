import 'package:flutter/material.dart';

class LabelTag extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double borderRadius;

  LabelTag({
    Key? key,
    required this.label,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.fontSize = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
    this.margin = const EdgeInsets.symmetric(horizontal: 6),
    this.borderRadius = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      margin: margin,
      padding: padding,
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
