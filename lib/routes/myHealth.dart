import 'package:flutter/material.dart';
import 'package:flutter_medical/database.dart';
import 'package:flutter_medical/widgets.dart';
import 'package:flutter_medical/routes/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DocumentSnapshot snapshot;

class MyHealthPage extends StatefulWidget {
  final String name;
  MyHealthPage(this.name);

  @override
  _MyHealthPageState createState() => _MyHealthPageState(name);
}

class _MyHealthPageState extends State<MyHealthPage> {
  String name;
  _MyHealthPageState(this.name);
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot doctorProfileSnapshot;

  getProfile(name) async {
    print(name);
    databaseMethods.getDoctorProfile(name).then((val) {
      print(val.toString());
      setState(() {
        doctorProfileSnapshot = val;
        print(doctorProfileSnapshot);
      });
    });
  }

  @override
  void initState() {
    getProfile(name);
  }

  Widget doctorProfile() {
    return doctorProfileSnapshot != null
        ? Container(
            child: ListView.builder(
                itemCount: doctorProfileSnapshot.docs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return doctorCard(
                    name: doctorProfileSnapshot.docs[index].data()["name"],
                    specialty:
                        doctorProfileSnapshot.docs[index].data()["specialty"],
                    imagePath:
                        doctorProfileSnapshot.docs[index].data()["imagePath"],
                    rank: doctorProfileSnapshot.docs[index].data()["rank"],
                    medicalEducation: doctorProfileSnapshot.docs[index]
                        .data()["medicalEducation"],
                    residency:
                        doctorProfileSnapshot.docs[index].data()["residency"],
                    internship:
                        doctorProfileSnapshot.docs[index].data()["internship"],
                    fellowship:
                        doctorProfileSnapshot.docs[index].data()["fellowship"],
                    biography:
                        doctorProfileSnapshot.docs[index].data()["biography"],
                  );
                }),
          )
        : Container(
            child: Text("error"),
          );
  }

  Widget doctorCard({
    String name,
    String specialty,
    String imagePath,
    String rank,
    String medicalEducation,
    String residency,
    String internship,
    String fellowship,
    String biography,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            const Color(0xFF6aa6f8),
            const Color(0xFF1a60be),
          ], // whitish to gray
        ),
      ),
      alignment: Alignment.center, // where to position the child
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 15.0,
            ),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Color(0xFFFFFFFF),
              boxShadow: [
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20.0,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  //transform: Matrix4.translationValues(0.0, -16.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          MaterialButton(
                            splashColor: Colors.white,
                            onPressed: () {},
                            color: Color(0xFF4894e9),
                            textColor: Colors.white,
                            child: Icon(
                              Icons.phone,
                              size: 30,
                            ),
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Text(
                              'Office',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF6f6f6f),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            transform:
                                Matrix4.translationValues(0.0, -15.0, 0.0),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: NetworkImage(imagePath),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            color: Color(0xFF4894e9),
                            highlightColor: Color(0xFFFFFFFF),
                            textColor: Colors.white,
                            child: Icon(
                              Icons.mail_outline,
                              size: 30,
                            ),
                            padding: EdgeInsets.all(16),
                            shape: CircleBorder(),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10.0,
                            ),
                            child: Text(
                              'Message',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF6f6f6f),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 15.0,
                    bottom: 5.0,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          name ?? "name not found",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color(0xFF6f6f6f),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: FlatButton(
                          color: Colors.transparent,
                          splashColor: Colors.black26,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryPage(specialty)),
                            );
                          },
                          child: Text(
                            specialty ?? "specialty not found",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFF4894e9),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    "$rank  ⭐ ⭐ ⭐ ⭐ ⭐" ?? "rank not found",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF6f6f6f),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20.0,
                    left: 20.0,
                    right: 20.0,
                    bottom: 15.0,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Physician History',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF6f6f6f),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 15.0,
                  ),
                  child: Divider(
                    color: Colors.black12,
                    height: 1,
                    thickness: 1,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 20.0,
                  ),
                  child: new OutlineButton(
                    color: Colors.transparent,
                    splashColor: Color(0xFF4894e9),
                    padding: EdgeInsets.all(10),
                    onPressed: () {},
                    textColor: Color(0xFF4894e9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'EDIT PROFILE',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(),
      drawer: GlobalDrawer(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 1.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0, 0.0),
              end: Alignment(1.0, 0.0),
              colors: [
                const Color(0xFF6aa6f8),
                const Color(0xFF1a60be),
              ], // whitish to gray
            ),
          ),
          alignment: Alignment.center, // where to position the child
          child: Column(
            children: [
              doctorProfile(),
            ],
          ),
        ),
      ),
    );
  }
}

Material appointmentDays(
    String appointmentDay, String appointmentDate, context) {
  return Material(
    color: Colors.white,
    child: Container(
      margin: const EdgeInsets.only(
        right: 1.0,
        left: 20.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: OutlineButton(
        color: Colors.transparent,
        splashColor: Color(0xFF4894e9),
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          top: 6,
        ),
        onPressed: () {},
        textColor: Color(0xFF4894e9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                appointmentDay,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                appointmentDate,
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Material appointmentTimes(String appointmentDay, context) {
  return Material(
    color: Colors.white,
    child: Container(
      margin: const EdgeInsets.only(
        right: 1.0,
        left: 20.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: OutlineButton(
        color: Colors.transparent,
        splashColor: Color(0xFF4894e9),
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        onPressed: () {
          print('View All Doctors Clicked');
        },
        textColor: Color(0xFF4894e9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            appointmentDay,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}
