import 'package:demo_instagram/resources/auth_methods.dart';
import 'package:demo_instagram/utils/colors.dart';
import 'package:demo_instagram/utils/utils.dart';
import 'package:demo_instagram/utils/utils_Image.dart';
import 'package:demo_instagram/widget/text_field_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Flexible(
                      child: Container(),
                      flex: 2,
                    ),
                    //svg image
                    SvgPicture.asset(
                      'images/ic_instagram.svg',
                      color: primaryColor,
                      height: 64,
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    //Use Circular Avatar Widget to show an image
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!))
                            : CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'https://i.pinimg.com/originals/f1/0f/f7/f10ff70a7155e5ab666bcdd1b45b726d.jpg'),
                              ),
                        Positioned(
                            bottom: 5,
                            right: -20,
                            child: IconButton(
                                onPressed: selectImage,
                                icon: Icon(Icons.add_a_photo)))
                      ],
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    //Text field input for userName
                    TextFieldInput(
                        textEditingController: _usernameController,
                        hintText: 'Enter your user name',
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 24,
                    ),
                    //Text field input for email
                    TextFieldInput(
                        textEditingController: _emailController,
                        hintText: 'Enter your email',
                        textInputType: TextInputType.emailAddress),
                    const SizedBox(
                      height: 24,
                    ),

                    //Text field input for password
                    TextFieldInput(
                      textEditingController: _passwordController,
                      hintText: 'Enter your password',
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    //Text field input for bio
                    TextFieldInput(
                        textEditingController: _bioController,
                        hintText: 'Enter your bio',
                        textInputType: TextInputType.text),
                    const SizedBox(
                      height: 24,
                    ),
                    //Login button
                    InkWell(
                      onTap: signUpUser,
                      child: _isLoading ? const Center(child: CircularProgressIndicator(color: primaryColor,), ) : Container(
                        child: const Text('Sign Up'),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: ShapeDecoration(
                            color: blueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Flexible(
                      child: Container(),
                      flex: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: const Text(
                            "Already Sign up? Then go to ",
                            style: TextStyle(fontSize: 18),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 8),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        )
                      ],
                    )
                    //Transitioning to signing up
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    print(res);
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      // nothing
    }
  }
}
