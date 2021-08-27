import 'package:blood_buddy/models/date.dart';
import 'package:blood_buddy/models/request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';

import '../constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = !true;
  late String _city;
  late String _date;
  String _bg = '#';

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Date selectedDate = Date(DateTime.now());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:
            DateTime(selectedDate.year, selectedDate.month, selectedDate.day),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) selectedDate = Date(picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: Drawer(),
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
          actions: [
            IconButton(
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
                                    'Filter',
                                    style: TextStyle(
                                      color: myRed,
                                      fontSize: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    onSaved: (String? city) {
                                      if (city == null)
                                        _city = '#';
                                      else
                                        _city = city;
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
                                        borderSide: const BorderSide(
                                            color: myRed, width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      'Blood Group',
                                      style: TextStyle(
                                        color: myRed,
                                        fontSize: 20,
                                      ),
                                    ),
                                    trailing: DropdownButton(
                                      value: _bg,
                                      hint: Text(
                                        'Select',
                                        style: TextStyle(
                                          color: myRed,
                                        ),
                                      ),
                                      items: [
                                        DropdownMenuItem(
                                          value: '#',
                                          child: Text(
                                            'Any',
                                            style: TextStyle(
                                                color: myRed, fontSize: 20),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'A+',
                                          child: Text(
                                            'A+',
                                            style: TextStyle(
                                                color: myRed, fontSize: 20),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'B+',
                                          child: Text(
                                            'B+',
                                            style: TextStyle(
                                                color: myRed, fontSize: 20),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'AB+',
                                          child: Text(
                                            'AB+',
                                            style: TextStyle(
                                                color: myRed, fontSize: 20),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'O+',
                                          child: Text(
                                            'O+',
                                            style: TextStyle(
                                                color: myRed, fontSize: 20),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'A-',
                                          child: Text(
                                            'A-',
                                            style: TextStyle(
                                                color: myRed, fontSize: 20),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'B-',
                                          child: Text(
                                            'B-',
                                            style: TextStyle(
                                                color: myRed, fontSize: 20),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'AB-',
                                          child: Text(
                                            'AB-',
                                            style: TextStyle(
                                                color: myRed, fontSize: 20),
                                          ),
                                        ),
                                        DropdownMenuItem(
                                          value: 'O-',
                                          child: Text(
                                            'O-',
                                            style: TextStyle(
                                                color: myRed, fontSize: 20),
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
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Select Date',
                                          style: TextStyle(
                                            color: myRed,
                                            fontSize: 20,
                                          ),
                                        ),
                                        GestureDetector(
                                          child: Text(
                                            selectedDate.toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                          onTap: () async {
                                            await _selectDate(context);
                                            setState(() {});
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GFButton(
                                    onPressed: () async {
                                      _formKey.currentState!.save();
                                      Navigator.pop(context);
                                    },
                                    text: "Filter",
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
                icon: Icon(
                  Icons.tune,
                  color: myRed,
                  size: 30,
                ))
          ],
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(
                  color: myRed,
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('requests')
                        .orderBy('date', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: myRed,
                          ),
                        );
                      }
                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          var request = Request.fromJson(
                              document.data()! as Map<String, dynamic>);
                          return Container(
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.shade100,
                                  blurRadius: 15.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(
                                    0, // Move to right 10  horizontally
                                    5.0, // Move to bottom 10 Vertically
                                  ),
                                ),
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  myRed,
                                  Color(0xffcd705c),
                                ],
                              ),
                              color: myRed,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  width: 70,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Text(
                                    request.bloodGroup,
                                    style: TextStyle(
                                      color: myRed,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      request.name,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                    Text(
                                      request.phone,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      request.hospital
                                              .toLowerCase()
                                              .contains('hospital')
                                          ? '${request.hospital}-${request.city}'
                                          : '${request.hospital} Hospital-${request.city}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      Date(request.date.toDate()).toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }),
              ));
  }
}
