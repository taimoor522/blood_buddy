import 'package:blood_buddy/models/date.dart';
import 'package:blood_buddy/models/request.dart';
import 'package:blood_buddy/services/fire_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late String uid;
  String _bg = 'A+';
  late String _hospital;
  late String _city;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _addRequest() async {
    await Database(
      uid: uid,
    ).addresquet(
        bloodGroup: _bg,
        city: _city,
        hospital: _hospital,
        date: Timestamp.fromDate(DateTime.now()));
  }

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(25.0))),
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    padding: EdgeInsets.fromLTRB(30, 30, 30,
                        MediaQuery.of(context).viewInsets.bottom + 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Add Request',
                            style: TextStyle(
                              color: myRed,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (String? city) {
                              if (city!.isEmpty) return "Enter City";
                            },
                            onSaved: (String? city) {
                              _city = city!;
                            },
                            style: TextStyle(
                              color: myRed,
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              labelText: 'City',
                              labelStyle: TextStyle(
                                color: myRed,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 5),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: myRed, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (String? hospital) {
                              if (hospital!.isEmpty) return "Enter Hospital";
                            },
                            onSaved: (String? hospital) {
                              _hospital = hospital!;
                            },
                            style: TextStyle(
                              color: myRed,
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Hospital',
                              labelStyle: TextStyle(
                                color: myRed,
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 5),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: myRed, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text(
                              'Blood Group',
                              style: TextStyle(
                                color: myRed,
                                fontSize: 20,
                              ),
                            ),
                            trailing: DropdownButton(
                              value: _bg,
                              items: [
                                DropdownMenuItem(
                                  value: 'A+',
                                  child: Text(
                                    'A+',
                                    style:
                                        TextStyle(color: myRed, fontSize: 20),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'B+',
                                  child: Text(
                                    'B+',
                                    style:
                                        TextStyle(color: myRed, fontSize: 20),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'AB+',
                                  child: Text(
                                    'AB+',
                                    style:
                                        TextStyle(color: myRed, fontSize: 20),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'O+',
                                  child: Text(
                                    'O+',
                                    style:
                                        TextStyle(color: myRed, fontSize: 20),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'A-',
                                  child: Text(
                                    'A-',
                                    style:
                                        TextStyle(color: myRed, fontSize: 20),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'B-',
                                  child: Text(
                                    'B-',
                                    style:
                                        TextStyle(color: myRed, fontSize: 20),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'AB-',
                                  child: Text(
                                    'AB-',
                                    style:
                                        TextStyle(color: myRed, fontSize: 20),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'O-',
                                  child: Text(
                                    'O-',
                                    style:
                                        TextStyle(color: myRed, fontSize: 20),
                                  ),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  _bg = newValue!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GFButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              _formKey.currentState!.save();

                              await _addRequest();

                              Navigator.pop(context);
                            },
                            text: "Request",
                            textStyle: TextStyle(
                              fontSize: 20,
                            ),
                            shape: GFButtonShape.standard,
                            blockButton: true,
                            size: GFSize.LARGE * 1.5,
                            color: myRed,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
        backgroundColor: myRed,
        splashColor: Colors.white,
      ),
      appBar: GFAppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => _key.currentState!.openDrawer(),
          icon: Icon(
            Icons.menu,
            size: 30,
            color: myRed,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('requests')
                .where('uid', isEqualTo: uid)
                .orderBy('date', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: myRed,
                  ),
                );
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  var request = Request.fromJson(
                      document.data()! as Map<String, dynamic>);
                  return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0, // soften the shadow
                            spreadRadius: 2.0, //extend the shadow
                            offset: Offset(
                              0, // Move to right 10  horizontally
                              5.0, // Move to bottom 10 Vertically
                            ),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '',
                              children: <TextSpan>[
                                TextSpan(
                                  text: request.bloodGroup,
                                  style: TextStyle(
                                    color: myRed,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                    text: ' blood needed at ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                                TextSpan(
                                  text: request.hospital
                                          .toLowerCase()
                                          .contains('hospital')
                                      ? '${request.hospital}-${request.city}'
                                      : '${request.hospital} Hospital-${request.city}',
                                  style: TextStyle(
                                    color: myRed,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            Date(request.date.toDate()).toString(),
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.right,
                          )
                        ],
                      ));
                }).toList(),
              );
            }),
      ),
    );
  }
}
