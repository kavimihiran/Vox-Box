import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import 'package:vox_box/Utils/colors.dart';
import 'package:vox_box/Utils/screen_size.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: customColor, // Set the background color
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_errorMessage != null) ...[
                      Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 16.0),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ],
                ),
              ),
              Positioned(
                top: 484.0,
                left: 0.0,
                right: 0.0,
                child: Opacity(
                  opacity: 1.0,
                  child: Container(
                    height: 316.0,
                    padding:
                        EdgeInsets.symmetric(vertical: 48.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Login to Continue',
                          textAlign: TextAlign.center, // Align text to center
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 22.0,
                            fontWeight: FontWeight
                                .w500, // FontWeight 500 is equivalent to FontWeight.w500
                            height:
                                1.25, // Calculate line height: 25.78px / 22px = 1.25
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await authController.signInWithGoogle();
                              // Navigate to RoomScreen if sign-in is successful
                              if (authController.user != null) {
                                Navigator.pushReplacementNamed(
                                    context, '/room');
                              }
                            } catch (e) {
                              setState(() {
                                _errorMessage =
                                    'Login failed. Please try again.';
                              });
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 255, 255,
                                    255)), // Button background color
                            minimumSize: MaterialStateProperty.all<Size>(
                                Size(328.0, 54.0)), // Button size
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.all(16.0)), // Button padding
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    14.0), // Button border radius
                                side: BorderSide(
                                    color: const Color.fromARGB(255, 255, 255,
                                        255)), // Optional: Button border color
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(
                                5.0), // Button elevation
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.black.withOpacity(0.9)), // Shadow color
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.black.withOpacity(
                                      0.5); // Overlay color when hovered
                                }
                                return Colors
                                    .transparent; // Default overlay color
                              },
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/google_logo.png', // Replace with your Google logo asset path
                                height:
                                    24.0, // Adjust the height of the Google logo as needed
                                width:
                                    24.0, // Adjust the width of the Google logo as needed
                              ),
                              SizedBox(
                                  width:
                                      8.0), // Adjust spacing between logo and text
                              Text(
                                'Continue with Google',
                                style: TextStyle(
                                  fontFamily: 'Roboto', // Font family
                                  fontSize: 20.0, // Font size
                                  fontWeight: FontWeight.w500, // Font weight
                                  color: Color(0xFF000000).withOpacity(
                                      0.54), // Text color (semi-transparent black)
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
