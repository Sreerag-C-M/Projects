import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'home.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text(
          'About',
          style: TextStyle(color: Colors.white, fontFamily: "Astonpoliz",fontSize: 18.sp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'QuickRead',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.sp,
                      fontFamily: "Astonpoliz",
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Our app provides the latest news from around the world. Stay informed with breaking news alerts, in-depth articles, and a personalized news feed.',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Astonpoliz",
                    fontSize: 13.sp),
              ),
              SizedBox(height: 2.h),
              Text(
                'Features:',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Astonpoliz",
                    fontSize: 15.sp),
              ),
              SizedBox(height: (1.5).h),
              Text('- Breaking news alerts',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Astonpoliz",
                      fontSize: 13.sp)),
              Text('- In-depth articles',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Astonpoliz",
                      fontSize: 13.sp)),
              Text('- Personalized news feed',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Astonpoliz",
                      fontSize: 13.sp)),
              Text('- Offline reading',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Astonpoliz",
                      fontSize: 13.sp)),
              SizedBox(height: 2.h),
              Text('Contact Us:',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Astonpoliz",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: (1.5).h),
              Text(
                'Email: \n missionisimpossible1234@gmail.com',
                style: TextStyle(fontSize: 13.sp, color: Colors.white),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                'Phone: \n+91 994 565 1245',
                style: TextStyle(fontSize: 13.sp, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
