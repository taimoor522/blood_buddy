import 'package:blood_buddy/constants.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';

class RadioGroupedButton extends StatelessWidget {
  var bgInit;

  RadioGroupedButton(this.bgInit);

  @override
  Widget build(BuildContext context) {
    return CustomRadioButton(
      autoWidth: false,
      radius: 10,
      padding: 3,
      unSelectedColor: Colors.white,
      buttonLables: [
        "A+",
        "B+",
        "AB+",
        "O+",
        "A-",
        "B-",
        "AB-",
        "O-",
      ],
      buttonValues: [
        "A+",
        "B+",
        "AB+",
        "O+",
        "A-",
        "B-",
        "AB-",
        "O-",
      ],
      buttonTextStyle: ButtonTextStyle(
        selectedColor: Colors.white,
        unSelectedColor: myRed,
        textStyle: TextStyle(
          fontSize: 20,
        ),
      ),
      radioButtonValue: (value) {
        bgInit(value);
      },
      selectedColor: myRed,
      height: MediaQuery.of(context).size.width / 5.5,
      width: MediaQuery.of(context).size.width / 5.5,
      enableButtonWrap: true,
      unSelectedBorderColor: myRed,
      selectedBorderColor: myRed,
      defaultSelected: "A+",
      enableShape: true,
      shapeRadius: 10,
    );
  }
}
