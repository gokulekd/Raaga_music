import 'package:flutter/material.dart';

class termsAndConditions extends StatefulWidget {
  const termsAndConditions({ Key? key }) : super(key: key);

  @override
  State<termsAndConditions> createState() => _termsAndConditionsState();
}

class _termsAndConditionsState extends State<termsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms And Conditions"),
      ),
      body: Center(
        child: Text("Terms And Conditions"),
      ),
    );
  }
}