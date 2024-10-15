import 'package:flutter/material.dart';
import 'package:simple_ecommerce/Widgets/subtilte_text.dart';
import '../Screens/home_screen.dart';
import 'title_text.dart';
import 'package:shimmer/shimmer.dart';

class EmptyBagWidget extends StatefulWidget {
  const EmptyBagWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });

  final String imagePath, title, subtitle, buttonText;

  @override
  _EmptyBagWidgetState createState() => _EmptyBagWidgetState();
}

class _EmptyBagWidgetState extends State<EmptyBagWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat animation

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image with animation
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        widget.imagePath,
                        height: size.height * 0.35,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Shimmer effect for the title
                Shimmer.fromColors(
                  baseColor: Colors.red,
                  highlightColor: Colors.orange,
                  child: const TitlesTextWidget(
                    label: "Whoops",
                    fontSize: 40,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 15),
                // Subtitle displaying the main message
                SubtitleTextWidget(
                  label: widget.title,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
                const SizedBox(height: 10),
                // Additional information
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SubtitleTextWidget(
                    label: widget.subtitle,
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 30),
                // Call-to-action button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    elevation: 5,
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    // Navigate to HomeScreen when button is pressed
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                  child: Text(
                    widget.buttonText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
