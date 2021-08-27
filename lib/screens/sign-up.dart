import 'package:blood_buddy/screens/sign_up_form.dart';
import 'package:blood_buddy/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:getwidget/size/gf_size.dart';

import '../constants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var _auth = Authentication();
  late String _email;
  late String _password;
  var _showPassword = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Email",
          style: TextStyle(
            fontSize: 20,
            color: myRed,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          validator: (String? email) {
            if (email!.isEmpty == true) return "Enter Email";
            if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(email)) {
              return 'Enter Valid Email';
            }
          },
          onSaved: (String? email) {
            _email = email!;
          },
          style: TextStyle(
            color: myRed,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            hintText: 'abc@example.com',
            hintStyle: TextStyle(
              fontSize: 15,
            ),
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
          height: 20,
        ),
      ],
    );
  }

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 20,
            color: myRed,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          validator: (String? password) {
            if (password!.length < 6) return 'Enter Valid Password';
          },
          onSaved: (String? password) {
            _password = password!;
          },
          obscureText: !_showPassword,
          style: TextStyle(
            color: myRed,
            fontSize: 20,
          ),
          decoration: InputDecoration(
            hintText: 'At least 6 characters',
            hintStyle: TextStyle(
              fontSize: 15,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.remove_red_eye,
                color: _showPassword ? myRed : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: myRed, width: 2),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 25,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Image(
                  image: AssetImage('assets/images/A.png'),
                ),
              ),
            ),
            _buildEmail(),
            _buildPassword(),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: GFButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  _formKey.currentState!.save();

                  var userExist = await _auth.isUserExist(_email);
                  if (userExist)
                    Fluttertoast.showToast(msg: 'Email already Exist');
                  else
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SignUpForm(_email, _password)));
                },
                text: "Sign Up",
                textStyle: TextStyle(
                  fontSize: 20,
                ),
                shape: GFButtonShape.standard,
                blockButton: true,
                size: GFSize.LARGE * 1.5,
                color: myRed,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
