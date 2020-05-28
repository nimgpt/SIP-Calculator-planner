import 'dart:math';
import 'dart:ui';
//import 'dart:io' as Io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './utils/constant.dart';
//import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_share_me/flutter_share_me.dart';

class SipcalculatorScreen extends StatefulWidget {
  SipcalculatorScreen({Key key}) : super(key: key);

  @override
  _SipcalculatorScreenState createState() => _SipcalculatorScreenState();
}

class _SipcalculatorScreenState extends State<SipcalculatorScreen> {
  double p = 0, n = 0, r = 0, amount = 0, i = 0;
  double principal =0;
  int finalAmount = 0, freq=0;
  String dropdownValue;

  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();

  _onClear() {
    setState(() {
      _textFieldController.text = "";
      _textFieldController1.text = "";
      _textFieldController2.text = "";
      dropdownValue = null;
    });
    //inputFrequency();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.lightBlue[500],
                      Colors.lightBlue[500],
                      Colors.lightBlue[500],
                      Colors.lightBlue[500],
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  )),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 80,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "SIP Calculator/ Planner",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Roboto",
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    inputPrincipalTf(), //! calling of the function principal textfield
                    SizedBox(height: 30),
                    inputMonthTf(), //! calling of the month text field
                    SizedBox(height: 30),
                    inputRateTf(), //! calling of the rate textfield
                    //calculateButton(),
                   // clearButton(),
                    inputFrequency(),
                    inputClsCalButton(),
                  Container(
                      alignment: Alignment.topLeft,
                      child: (amount == 0)
                          ? Text(
                        "",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                          :Text(
                        "Invested Amount : ₹ $principal ",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.topLeft,
                      child: (amount == 0)
                          ? Text(
                        "Enter correct value or no returns !",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                          :Text(
                        "Maturity Amount : ₹ $finalAmount ",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  int calculate() {

   if (freq == 0) freq =12;

   i = r / freq;
    print("Monthly Amount = $p \n Rate = $r \n year = $n \n I= $i");
    principal = p * n * 12; //total invested amount

    print("Final princial = $principal");

    setState(() {
      amount = principal * (pow((1 + (r / (100 * freq))), (freq * n)));
      finalAmount = amount.round();
    });
    return 0;
  }

  int clear(){
    finalAmount = 0;

    return 0;
  }

  inputRateTf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Expected rate (%) :",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 10, left: 5),
          decoration: kBoxDecorationStyle,
          height: 40,
          child: TextField(
            controller: _textFieldController,
            keyboardType: TextInputType.number,
            autofocus: true,
            style: TextStyle(color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              hintText: "Enter the expected ROI!",
              hintStyle: kHintTextStyle,
            ),
            onChanged: (String s) {
              r = double.parse(s);
            },
          ),
        ),
      ],
    );
  }

  inputMonthTf() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Total duration (in Years) :",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.only(bottom: 10, left: 5),
          alignment: Alignment.center,
          decoration: kBoxDecorationStyle,
          height: 40,
          child: TextField(
            controller: _textFieldController1,
            keyboardType: TextInputType.number,
            autofocus: true,
            style: TextStyle(color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              hintText: "Enter the years!",
              hintStyle: kHintTextStyle,
            ),
            onChanged: (String s) {
              n = double.parse(s);
            },
          ),
        ),
      ],
    );
  }

  inputFrequency()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.centerLeft,
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_drop_down_circle, color: Colors.white,),
            iconSize: 30,
            elevation: 16,
            dropdownColor: Colors.lightBlueAccent,
            autofocus: true,
            style: TextStyle(fontSize: 20, color: Colors.white),
            hint: Text("Select Compounding Frequency",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            underline: Container(
              height: 2,
              color: Colors.white,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
                print(dropdownValue);
                if(dropdownValue == "Monthly") freq = 12;
                else if(dropdownValue == "Quarterly") freq = 4;
                else if(dropdownValue == "Annually") freq = 1;
                else freq = 0;
                print( freq);
              });
            },
            items: <String>['Monthly', 'Quarterly', 'Annually'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
  inputClsCalButton(){
    return  ButtonBar(
      buttonMinWidth: 100,
      mainAxisSize: MainAxisSize.min,
      buttonPadding: EdgeInsets.all(20),

      //padding: new EdgeInsets.all(0.0),
      children: <Widget>[
        RaisedButton(
          elevation: 5.0,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: () {
            print("Calculate button pressed");
            calculate();
          },
          color: Colors.white,
          child: Text(
            "Calculate",
            style: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF527DAA),
            ),
          ),
        ),
        RaisedButton(
          elevation: 5.0,
          padding: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          onPressed: () {
            print("Clear button pressed");
            _onClear();
            finalAmount = 0;
            principal = 0;
          },
          color: Colors.white,
          child: Text(
            "Reset",
            style: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF527DAA),
            ),
          ),
        ),
      ],
    );
  }
  inputPrincipalTf() //!Widget to return the principal textfield
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Monthly deposit:",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 10, left: 5),
          decoration: kBoxDecorationStyle,
          height: 40,
          child: TextField(
            controller: _textFieldController2,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              hintText: "Enter the amount to be deposited!",
              hintStyle: kHintTextStyle,
            ),
            onChanged: (String s) {
              p = double.parse(s);
            },
          ),
        ),
      ],
    );
  }
}
