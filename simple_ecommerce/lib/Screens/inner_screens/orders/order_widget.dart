import 'package:flutter/material.dart';

import '../../../Widgets/subtilte_text.dart';
import '../../../widgets/title_text.dart';

class OrdersWidgetFree extends StatefulWidget {
  const OrdersWidgetFree({super.key});

  @override
  State<OrdersWidgetFree> createState() => _OrdersWidgetFreeState();
}

class _OrdersWidgetFreeState extends State<OrdersWidgetFree> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isDarkTheme = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      child: Card(
        elevation: 10, // Increase elevation for a stronger shadow effect
        shadowColor: Colors.blue.withOpacity(0.7), // Stronger blue shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: isDarkTheme
                  ? [Colors.grey.shade900, Colors.grey.shade800]
                  : [Colors.white, Colors.grey.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/beras_order.png",
                  height: size.width * 0.25,
                  width: size.width * 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: TitlesTextWidget(
                            label: 'Product Title',
                            maxLines: 2,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 24,
                          ),
                          splashRadius: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        TitlesTextWidget(
                          label: 'Price: ',
                          fontSize: 15,
                        ),
                        SubtitleTextWidget(
                          label: "\$11.99",
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const SubtitleTextWidget(
                      label: "Qty: 10",
                      fontSize: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
