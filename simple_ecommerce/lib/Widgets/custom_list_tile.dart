
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:simple_ecommerce/Widgets/subtilte_text.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });
  final String imagePath, text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: Image.asset(
        imagePath,
        height: 30,
      ),
      title: SubtitleTextWidget(label: text),
      trailing: const Icon(IconlyLight.arrow_right_2),
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
    );
  }
}