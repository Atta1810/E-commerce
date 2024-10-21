import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:shimmer/shimmer.dart'; // Add this import for shimmer effect
import 'package:simple_ecommerce/root_screen.dart';

import '../../Services/my_app_method.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final GlobalKey<FormState> _formKey;
  bool obscureText = true;
  final auth = FirebaseAuth.instance;
  bool _isLoading = false; // Loading state variable

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
  Future<void> _loginFct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      try {
        setState(() {
          _isLoading = true;
        });
        await auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        if (!mounted) return;

        Navigator.pushReplacementNamed(context, RootScreen.routName);
      } on FirebaseAuthException catch (error) {
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: "An error has been occured ${error.message}",
          fct: () {},
        );
      } catch (error) {
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: "An error has been occured $error",
          fct: () {},
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white60),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      prefixIcon: Icon(icon, color: Colors.white),
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white60),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Column(
          children: [
            // Shimmer effect for the app bar title
            Container(
              height: 120.0, // Set the height of the app bar
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF282A36),
                    Color(0xFF44475A)
                  ], // Dark theme gradient
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.blueAccent,
                  highlightColor: Colors.pinkAccent,
                  child: const Text(
                    "Depi E-commerce",
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF282A36),
                      Color(0xFF44475A)
                    ], // Dark theme gradient
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40.0),
                        const Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                focusNode: _emailFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                decoration: _buildInputDecoration(
                                  hintText: "Email address",
                                  icon: IconlyLight.message,
                                ),
                                style: const TextStyle(color: Colors.white),
                                validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Please enter your email'
                                    : null,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocusNode);
                                },
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                textInputAction: TextInputAction.done,
                                obscureText: obscureText,
                                decoration: _buildInputDecoration(
                                  hintText: "Password",
                                  icon: IconlyLight.lock,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                                validator: (value) =>
                                (value == null || value.isEmpty)
                                    ? 'Please enter your password'
                                    : null,
                                onFieldSubmitted: (_) => _loginFct(),
                              ),
                              const SizedBox(height: 20.0),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/ForgotPasswordScreen');
                                  },
                                  child: const Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      decoration: TextDecoration.underline,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              SizedBox(
                                width: double.infinity,
                                child: _isLoading // Show loading indicator
                                    ? Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                )
                                    : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 24), // Increased padding
                                    backgroundColor: const Color(0xFF4A56E2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    shadowColor: Colors.black.withOpacity(0.2),
                                    elevation: 8,
                                  ),
                                  onPressed: () => _loginFct(),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(fontSize: 18,color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              Center(
                                child: Column(
                                  children: [
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                            horizontal: 24), // Increased padding
                                        backgroundColor:
                                        Colors.white.withOpacity(0.9),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        shadowColor:
                                        Colors.black.withOpacity(0.2),
                                      ),
                                      onPressed: () {
                                        // Add Google sign-in logic here
                                      },
                                      icon: Image.asset(
                                        'assets/images/google.png', // Make sure to add a Google icon asset
                                        width: 24,
                                        height: 24,
                                      ),
                                      label: const Text(
                                        "Sign in with Google",
                                        style: TextStyle(
                                          color: Color(0xFF4A56E2),
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                            horizontal: 24), // Increased padding
                                        backgroundColor:
                                        Colors.white.withOpacity(0.9),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        shadowColor:
                                        Colors.black.withOpacity(0.2),
                                      ),
                                      onPressed: () {
                                        // Navigate to home screen
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                                  return RootScreen();
                                                }));
                                      },
                                      child: const Text(
                                        "Continue as Guest",
                                        style: TextStyle(
                                          color: Color(0xFF4A56E2),
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
