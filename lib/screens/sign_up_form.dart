import 'package:blood_buddy/reusables/card.dart';
import 'package:blood_buddy/reusables/radio_button_group.dart';
import 'package:blood_buddy/services/authentication.dart';
import 'package:blood_buddy/services/fire_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';
import '../constants.dart';
import 'app.dart';

class SignUpForm extends StatefulWidget {
  String email;
  String password;

  SignUpForm(this.email, this.password);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var _auth = Authentication();

  late String _name;
  late String _phone;
  late String _city;
  late String _bg;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Name",
          style: TextStyle(
            fontSize: 20,
            color: myRed,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          validator: (String? name) {
            if (name!.isEmpty) return "Enter Name";
          },
          onSaved: (String? name) {
            _name = name!;
          },
          style: TextStyle(
            color: myRed,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: myRed, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildPhone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Phone",
          style: TextStyle(
            fontSize: 20,
            color: myRed,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          validator: (String? phone) {
            if (phone!.isEmpty) return "Enter Phone";
            if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                .hasMatch(phone)) {
              return 'Enter Valid Phone';
            }
          },
          onSaved: (String? phone) {
            _phone = phone!;
          },
          style: TextStyle(
            color: myRed,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: myRed, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _buildCity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "City",
          style: TextStyle(
            fontSize: 20,
            color: myRed,
          ),
        ),
        const SizedBox(
          height: 5,
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
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: myRed, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void _bgInit(String bg) {
    _bg = bg;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Save a Life, Feel Proud',
                    style: TextStyle(
                      color: myRed,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _buildName(),
                  _buildPhone(),
                  _buildCity(),
                  Text(
                    'Choose Your Blood Group',
                    style: TextStyle(
                        fontSize: 25,
                        color: myRed,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: RadioGroupedButton(_bgInit)),
                  GFButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      await _auth.signUp(widget.email, widget.password, _name,
                          _phone, _city, _bg);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => App()));
                    },
                    text: "Get Started",
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
          ),
        ),
      ),
    );
  }
}
