import 'package:flutter/cupertino.dart';

class TitlesTextWidget extends StatelessWidget {
  const TitlesTextWidget({
    super.key,
    required this.label,
    this.fontSize = 20,
    this.color,
    this.maxLines,
  });

  final String label;
  final double fontSize;
  final Color? color;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: maxLines,
      // textAlign: TextAlign.justify,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis),
    );
  }
}