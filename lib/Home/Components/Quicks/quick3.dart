import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miniflutter/Home/Components/Quicks/quickvideo3.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

class Quick3 extends StatefulWidget {
  const Quick3({super.key});

  @override
  State<Quick3> createState() => _Quick2State();
}

class _Quick2State extends State<Quick3> {
  TextEditingController cname = TextEditingController();
  TextEditingController uname = TextEditingController();
  late CollectionReference _userCollection;

  @override
  void initState() {
    _userCollection = FirebaseFirestore.instance.collection("comments");
    super.initState();
  }

  void editUserData(String userId) {
    showModalBottomSheet(
        barrierColor: Colors.black,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              children: [
                TextField(
                  controller: uname,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: "Name",hintStyle: TextStyle(color: Colors.blueGrey)),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      updateUser(userId, uname.text);
                      uname.clear();
                    },
                    child: Text("Edit"))
              ],
            ),
          );
        });
  }

  void addUsertoDB(String name) async {
    return _userCollection.add({
      'comment': name,
    }).then((value) {
      cname.clear();
      Navigator.of(context).pop();
    }).catchError((error) {
      print("Failed to add Comment $error");
    });
  }

  Stream<QuerySnapshot> readUser() {
    return _userCollection.snapshots();
  }

  Future<void> updateUser(String userId, String uname) async {
    var updatedvalues = {"comment": uname};
    return _userCollection.doc(userId).update(updatedvalues).then((value) {
      Navigator.of(context).pop();
      print("Comment updated Successfully");
    }).catchError((error) {
      print("Comment updation failed");
    });
  }

  Future<void> deleteUser(var id) async {
    return _userCollection.doc(id).delete().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Comment deleted Successfully")));
    }).catchError((error) {
      print("User deletion failed $error");
    });
  }

  void showOverlay(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2 - 50,
        left: MediaQuery.of(context).size.width / 2 - 50,
        child: Icon(
          Icons.thumb_up,
          color: Colors.black,
          size: 70,
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    Future.delayed(Duration(seconds: 1), () {
      overlayEntry.remove();
    });
  }

  void showOverlay2(BuildContext context) {
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2 - 50,
        left: MediaQuery.of(context).size.width / 2 - 50,
        child: Icon(
          Icons.thumb_down,
          color: Colors.black,
          size: 20.w,
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    Future.delayed(Duration(seconds: 1), () {
      overlayEntry.remove();
    });
  }

  bool isLiked = false;
  bool disLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,

      body: Stack(
        children: [
          Container(
            height: 750,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Quickvideo3(),
          ),
          Positioned(
            right: (4.5).w,
            top: 56.h,
            child: Column(
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                        if (isLiked) {
                          showOverlay(context);
                        }
                      },
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            child: Icon(
                              isLiked
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_outlined,
                              color: isLiked ? Colors.black : Colors.white,
                              size: 35,
                            ),
                          ),
                          Text(
                            isLiked ? "Liked" : "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          disLiked = !disLiked;
                        });
                        if (disLiked) {
                          showOverlay2(context);
                        }
                      },
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            child: Icon(
                              disLiked
                                  ? Icons.thumb_down
                                  : Icons.thumb_down_alt_outlined,
                              color: disLiked ? Colors.black : Colors.white,
                              size: 35,
                            ),
                          ),
                          Text(
                            disLiked ? "Disliked" : "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),

                ////comment section
                GestureDetector(
                  onTap: () async {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: Colors.black,
                          child: Column(
                            children: [
                              Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: readUser(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Center(
                                          child: Text("Error ${snapshot.error}"));
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    final users = snapshot.data!.docs;
                                    return ListView.builder(
                                      itemCount: users.length,
                                      itemBuilder: (context, index) {
                                        final user = users[index];
                                        final userId = user.id;
                                        final userName = user["comment"];

                                        return ListTile(
                                          leading: Icon(Icons.comment,
                                              color: Colors.white),
                                          title: Text(
                                            "$userName",
                                            style: TextStyle(
                                              fontFamily: "Astonpoliz",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                          subtitle: Row(
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  uname.text = userName;
                                                  editUserData(userId);
                                                },
                                                child: Text("Edit",
                                                    style: TextStyle(
                                                      color: Colors.blue, fontFamily: "Astonpoliz",)),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  deleteUser(userId);
                                                },
                                                child: Text("Delete",
                                                    style: TextStyle(
                                                      color: Colors.red, fontFamily: "Astonpoliz",)),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              Divider(color: Colors.white),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: cname,
                                        decoration: InputDecoration(
                                          hintText: "Add a comment...",
                                          hintStyle:
                                          TextStyle(color: Colors.white54, fontFamily: "Astonpoliz",),
                                          border: InputBorder.none,
                                        ),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.send, color: Colors.blue),
                                      onPressed: () {
                                        if (cname.text.isNotEmpty) {
                                          addUsertoDB(cname.text);
                                          cname.clear();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.comment,
                        color: Colors.white,
                        size: 35,
                      ),
                      Text(
                        "904",
                        style: TextStyle(
                          fontFamily: "Astonpoliz",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 8.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                GestureDetector(
                  onTap: () {
                    Share.share('Check out this awesome content!',
                        subject: 'Look what I found!');
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 35,
                      ),
                      Text(
                        "Share",
                        style: TextStyle(
                          fontFamily: "Astonpoliz",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 9.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 30,
                // ),
              ],
            ),
          ),
          Positioned(
            top: 70.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: 5.w,top: 5.h),
                  child: Container(
                      height: 150,
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Nipa virus againn spreads over Calicut",
                              style: TextStyle(
                                  fontFamily: "Astonpoliz",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp)),
                          SizedBox(
                            height: 20,
                          ),
                          Text("#Calicut",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp)),
                        ],
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

