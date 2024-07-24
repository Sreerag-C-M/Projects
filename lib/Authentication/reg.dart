import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../Home/screens/home.dart';
import 'googleauthentication.dart';

class Regscrn extends StatefulWidget {
  const Regscrn({super.key});

  @override
  State<Regscrn> createState() => _RegscrnState();
}

class _RegscrnState extends State<Regscrn> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmationDialog(context) ?? false;
      },
      child: Sizer(builder: (context, orientation, deviceType) {
        return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/newwall.jpeg"),
                    fit: BoxFit.fill)),
            child: Scaffold(
                backgroundColor: Colors.black.withOpacity(.8),
                body: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                      child: Container(
                        width: 55.sp,
                        child: Image(
                          image: AssetImage("assets/images/newslogo.png"),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.transparent,
                      elevation: 100,
                      child: Image(
                        image: AssetImage("assets/images/newslogostroke.png"),
                        color: Colors.white,
                        width: 45.w,
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(left: 4.w),
                      child: Center(
                        child: Text(
                          "Quick Clips,Deep Impact",
                          style: TextStyle(
                              color: Colors.white, fontFamily: "Astonpoliz",fontSize: 8.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 53.h,
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(60)),
                        width: 85.w,
                        height: (6).h,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("assets/images/google-icon.png"),
                              width: 8.w,
                              height: 8.h,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Continue using Google",
                              style: TextStyle(
                                  fontFamily: "Astonpoliz",
                                  color: Colors.black,
                                  fontSize: 11.sp),
                            ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        try {
                          final user = await UserController.loginWithGoogle();
                          if (user != null && mounted) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const Hom()));
                          }
                        } on FirebaseAuthException catch (error) {
                          print(error.message);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            error.message ?? "Something went wrong",
                          )));
                        } catch (error) {
                          print(error);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            error.toString(),
                          )));
                        }
                      },
                    ),
                  ],
                )));
      }),
    );
  }
}


Future<bool?> _showExitConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          'Exit App',
          style: TextStyle(color: Colors.white),
        ),
        content: Text('Are you sure you want to exit the app?',
            style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel',style: TextStyle(color: Colors.blue),),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text('Exit',style: TextStyle(color: Colors.red)),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      );
    },
  );
}