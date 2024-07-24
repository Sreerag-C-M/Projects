import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miniflutter/Authentication/googleauthentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../Authentication/reg.dart';
import '../Components/Quicks/Quicksmain.dart';
import 'about.dart';
import 'mainscreen.dart';

main() {
  runApp(MaterialApp(
    home: Hom(),
  ));
}

class Hom extends StatefulWidget {
  const Hom({Key? key}) : super(key: key);

  @override
  State<Hom> createState() => _HomState();
}

class _HomState extends State<Hom> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  Future<void> signOut() async {
    await UserController.signOut();
    await UserController.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmationDialog(context) ?? false;
      },
      child: GestureDetector(
        child: Sizer(builder: (context, orientation, deviceType) {
          return DefaultTabController(
            length: 5,
            child: Scaffold(
              key: _scaffoldkey,
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      if (_scaffoldkey.currentState?.isDrawerOpen == false) {
                        _scaffoldkey.currentState?.openDrawer();
                      } else {
                        _scaffoldkey.currentState?.openEndDrawer();
                      }
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    )),
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black,
                centerTitle: true,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 4.w),
                    child: GestureDetector(
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                      onTap: () => showDialog(
                          context: context,
                          builder: (BuildContext context) => AboutDialog()),
                    ),
                  )
                ],
                title: Container(
                    width: 38.w,
                    child: Image(
                      image: AssetImage("assets/images/newslogostroke.png"),
                      color: Colors.white,
                    )),
              ),
              drawer: Stack(children: [
                Drawer(
                  backgroundColor: Colors.black,
                  width: 350,
                  child: ListView(
                    children: [
                      UserAccountsDrawerHeader(
                        decoration: BoxDecoration(color: Colors.black),
                        currentAccountPicture: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 0, color: Colors.white),
                            ),
                            child: Image.network(
                                UserController.user?.photoURL ?? '')),
                        accountName: Text(
                          UserController.user?.displayName ?? '',
                          style: TextStyle(fontSize: 13.sp),
                        ),
                        accountEmail: Text(
                          UserController.user!.email.toString(),
                          style: TextStyle(fontSize: 10.sp),
                        ),
                      ),
                      GestureDetector(
                        child: ListTile(
                          leading: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Home",
                            style: TextStyle(
                                fontFamily: "Astonpoliz", color: Colors.white),
                          ),
                        ),
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Hom())),
                      ),
                      Divider(),
                      GestureDetector(
                          child: ListTile(
                            leading: Icon(Icons.video_camera_back_outlined,
                                color: Colors.white),
                            title: Text("Quicks",
                                style: TextStyle(
                                    fontFamily: "Astonpoliz",
                                    color: Colors.white)),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Quickpg()));
                          }),
                      Divider(),
                      GestureDetector(
                        child: ListTile(
                          leading: Icon(
                            Icons.business,
                            color: Colors.white,
                          ),
                          title: Text("About",
                              style: TextStyle(
                                  fontFamily: "Astonpoliz",
                                  color: Colors.white)),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AboutPage()),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 6.h,
                    child: Padding(
                      padding: EdgeInsets.only(left: 17.w),
                      child: Container(
                        width: 50.w,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateColor.transparent),
                            onPressed: () async {
                              UserController.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Regscrn()));
                            },
                            child: Text('Logout',
                                style: TextStyle(
                                    fontFamily: "Astonpoliz",
                                    fontSize: 12.sp,
                                    color: Colors.white))),
                      ),
                    ))
              ]),
              body: Topscrn(),
            ),
          );
        }),
      ),
    );
  }
}

class AboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: Padding(
        padding: EdgeInsets.only(left: 23.w),
        child: Text(
          'QuickRead',
          style: TextStyle(
              color: Colors.white, fontFamily: "Astonpoliz", fontSize: 16.sp),
        ),
      ),
      alignment: Alignment.center,
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'QuickRead provides the latest news from around the world.',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Astonpoliz",
                  fontSize: 12.sp),
            ),
            SizedBox(height: 10),
            Text(
              'Features:',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Astonpoliz",
                  fontSize: 12.sp),
            ),
            Text(
              '- Breaking news alerts',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Astonpoliz",
                  fontSize: 11.sp),
            ),
            Text(
              '- In-depth articles',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Astonpoliz",
                  fontSize: 11.sp),
            ),
            Text(
              '- Personalized news feed',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Astonpoliz",
                  fontSize: 11.sp),
            ),
            Text(
              '- Offline reading',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Astonpoliz",
                  fontSize: 11.sp),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'Close',
            style: TextStyle(
                color: Colors.red, fontFamily: "Astonpoliz", fontSize: 11.sp),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
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
