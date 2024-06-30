import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vox_box/Services/authProvider.dart'; // Adjust path as needed
import 'package:vox_box/Utils/colors.dart'; // Adjust path as needed
import 'package:vox_box/Views/room_screen.dart'; // Adjust path as needed

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return Container(
          color: customColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 140.0),
              Image.asset(
                'assets/images/logo.png',
                width: 179.64,
                height: 43.87,
              ),
              Expanded(
                child: Container(
                  width: 400.0, // Fixed width
                  margin: EdgeInsets.only(top: 300.0),
                  padding: EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 48.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Login to Continue',

                        textAlign: TextAlign.center, // Align text to center
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontFamily: 'Roboto',
                          fontSize: 22.0,
                          fontWeight: FontWeight
                              .w500, // FontWeight 500 is equivalent to FontWeight.w500
                          height:
                              1.25, // Calculate line height: 25.78px / 22px = 1.25
                        ),
                      ),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                        onPressed: () =>
                            _signInWithGoogle(context, authProvider),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(328.0, 54.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation:
                              4, // Adjust the elevation value for shadow intensity
                          shadowColor: Colors.black
                              .withOpacity(0.2), // Shadow color and opacity
                          primary: Color(0xFFFFFFFF),
                          onPrimary: Color(0xFF000000).withOpacity(0.54),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/google_logo.png',
                              height: 24.0,
                              width: 24.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Continue with Google',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF000000).withOpacity(0.54),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _signInWithGoogle(
      BuildContext context, AuthProvider authProvider) async {
    await authProvider.signInWithGoogle();
    if (authProvider.user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => RoomScreen()),
      );
    }
  }
}
