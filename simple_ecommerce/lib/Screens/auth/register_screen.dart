import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_ecommerce/Services/my_app_method.dart';
import 'package:simple_ecommerce/Widgets/app_name_text.dart';
import 'package:simple_ecommerce/Widgets/pick_image.dart';
import 'package:simple_ecommerce/Widgets/subtilte_text.dart';
import 'package:simple_ecommerce/Widgets/title_text.dart';
import 'package:simple_ecommerce/constants/my_validators.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/RegisterScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _nameController,
      _emailController,
      _passwordController,
      _confirmPasswordController;
  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _confirmPasswordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  XFile? _pickedImage;
  final auth = FirebaseAuth.instance;
  bool _isLoading = false;
  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _registerFct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      // if (_pickedImage == null) {
      //   MyAppMethods.showErrorORWarningDialog(
      //       context: context,
      //       subtitle: "Make sure to pick up an image",
      //       fct: () {});
      // }
      try {
        setState(() {
          _isLoading = true;
        });
        await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        Fluttertoast.showToast(
          msg: "An account has been created",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
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


  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppMethods.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40.0),
                const AppNameTextWidget(fontSize: 30),
                const SizedBox(height: 16.0),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitlesTextWidget(label: "Welcome"),
                      SubtitleTextWidget(label: "Your welcome message"),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: size.height * 0.15,
                    width: size.width * 0.3,
                    child: PickImageWidget(
                      pickedImage: _pickedImage,
                      function: () async {
                        await localImagePicker(); // Call the local image picker
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24.0), // Added spacing after image picker
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _nameController,
                        focusNode: _nameFocusNode,
                        hintText: "Full name",
                        icon: IconlyLight.user,
                        validator: MyValidators.displayNamevalidator,
                        nextFocusNode: _emailFocusNode,
                      ),
                      const SizedBox(height: 16.0),
                      _buildTextField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        hintText: "Email address",
                        icon: IconlyLight.message,
                        validator: MyValidators.emailValidator,
                        nextFocusNode: _passwordFocusNode,
                      ),
                      const SizedBox(height: 16.0),
                      _buildTextField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        hintText: "Password",
                        icon: IconlyLight.lock,
                        isObscured: obscureText,
                        toggleObscure: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        validator: MyValidators.passwordValidator,
                        nextFocusNode: _confirmPasswordFocusNode,
                      ),
                      const SizedBox(height: 16.0),
                      _buildTextField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocusNode,
                        hintText: "Confirm Password",
                        icon: IconlyLight.lock,
                        isObscured: obscureText,
                        toggleObscure: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        validator: (value) => MyValidators.repeatPasswordValidator(
                          value: value,
                          password: _passwordController.text,
                        ),
                        onFieldSubmitted: (value) {
                          _registerFct();
                        },
                      ),
                      const SizedBox(height: 24.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12),
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(IconlyLight.add_user),
                          label: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            _registerFct();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    // Navigate to Login Screen
                    Navigator.pushNamed(context, '/LoginScreen');
                  },
                  child: const Text(
                    "Already have an account? Log in",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required IconData icon,
    bool isObscured = false,
    Function()? toggleObscure,
    String? Function(String?)? validator,
    FocusNode? nextFocusNode,
    Function(String)? onFieldSubmitted,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textInputAction: nextFocusNode != null
          ? TextInputAction.next
          : TextInputAction.done,
      keyboardType:
      isObscured ? TextInputType.visiblePassword : TextInputType.name,
      obscureText: isObscured,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        suffixIcon: toggleObscure != null
            ? IconButton(
          onPressed: toggleObscure,
          icon: Icon(
            isObscured ? Icons.visibility : Icons.visibility_off,
          ),
        )
            : null,
      ),
      validator: validator,
      onFieldSubmitted: (value) {
        if (nextFocusNode != null) {
          FocusScope.of(context).requestFocus(nextFocusNode);
        } else {
          onFieldSubmitted?.call(value);
        }
      },
    );
  }
}
