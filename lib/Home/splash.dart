import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:miniflutter/Authentication/reg.dart';
import 'package:miniflutter/Home/screens/home.dart';
import 'package:sizer/sizer.dart';

class Splashscrn extends StatefulWidget {
  const Splashscrn({super.key});

  @override
  State<Splashscrn> createState() => _SplashscrnState();
}

class _SplashscrnState extends State<Splashscrn> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate a delay for the splash screen
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Hom()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Regscrn()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/newwall.jpeg"),
                fit: BoxFit.fill)),
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(.8),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 45.h),
                child: Center(
                  child: Image(
                    image: AssetImage("assets/images/newslogostroke.png"),
                    color: Colors.white,
                    width: 45.w,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Center(
                  child: Text(
                    "Quick Clips, Deep Impact",
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Astonpoliz",fontSize: 8.sp),
                  ),
                ),
              ),
              // Uncomment if you want to show a loading indicator
              // Padding(
              //   padding: const EdgeInsets.only(top: 15),
              //   child: Center(child: CircularProgressIndicator()),
              // )
            ],
          ),
        ),
      );
    });
  }
}