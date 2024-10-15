import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_ecommerce/Widgets/title_text.dart';

class AppNameTextWidget extends StatelessWidget {
  const AppNameTextWidget({super.key, this.fontSize = 30});
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 5),
      baseColor: Colors.purple,
      highlightColor: Colors.red,
      child: const TitlesTextWidget(
        label: "Depi E-commerce",
        fontSize: 30,
      ),
    );
  }
}
