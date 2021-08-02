import 'package:flutter/material.dart';
import 'clipper.dart';

class Homie extends StatefulWidget {
  @override
  _HomieState createState() => _HomieState();
}

class _HomieState extends State<Homie> {
  TextEditingController _npkController,
      _val2Controller,
      _val3Controller,
      _val4Controller,
      _val5Controller,
      _val6Controller,
      _val7Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //GO logo widget
    Widget logo() {
      return Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: Stack(
            children: <Widget>[
              Positioned(
                  child: Container(
                child: Align(
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    width: 150,
                    height: 150,
                  ),
                ),
                height: 154,
              )),
              Positioned(
                child: Container(
                    height: 154,
                    child: Align(
                      child: Text(
                        "Agrobot",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.15,
                bottom: MediaQuery.of(context).size.height * 0.046,
                right: MediaQuery.of(context).size.width * 0.22,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.width * 0.08,
                bottom: 0,
                right: MediaQuery.of(context).size.width * 0.32,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    void _loginSheet(context) {
      showBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return BottomSheet(
            npkController: _npkController,
            val2Controller: _val2Controller,
            val3Controller: _val3Controller,
            val4Controller: _val4Controller,
            val5Controller: _val5Controller,
            val6Controller: _val6Controller,
            val7Controller: _val7Controller,
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            logo(),
            Padding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton(
                    label: "Check Prediction",
                    primaryColor: Colors.white,
                    secondaryColor: Theme.of(context).primaryColor,
                    onPressed: () => _loginSheet(context),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              padding: EdgeInsets.only(top: 80, left: 20, right: 20),
            ),
            Expanded(
              child: Align(
                child: ClipPath(
                  child: Container(
                    color: Colors.white,
                    height: 300,
                  ),
                  clipper: BottomWaveClipper(),
                ),
                alignment: Alignment.bottomCenter,
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        );
      }),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Color primaryColor;
  final Color secondaryColor;

  final String label;
  final Function() onPressed;
  const CustomButton({
    Key key,
    this.primaryColor,
    this.secondaryColor,
    @required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: RaisedButton(
        highlightElevation: 0.0,
        splashColor: secondaryColor,
        highlightColor: primaryColor,
        elevation: 0.0,
        color: primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
            side: BorderSide(color: Colors.white, width: 3)),
        child: Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: secondaryColor, fontSize: 20),
        ),
        onPressed: onPressed,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final Icon icon;
  final String hint;
  final TextEditingController controller;
  final bool obsecure;

  const CustomTextField({
    this.controller,
    this.hint,
    this.icon,
    this.obsecure,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecure ?? false,
      style: TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
          hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
          ),
          prefixIcon: Padding(
            child: IconTheme(
              data: IconThemeData(color: Theme.of(context).primaryColor),
              child: icon,
            ),
            padding: EdgeInsets.only(left: 30, right: 10),
          )),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    Key key,
    @required TextEditingController npkController,
    @required TextEditingController val2Controller,
    @required TextEditingController val3Controller,
    @required TextEditingController val4Controller,
    @required TextEditingController val5Controller,
    @required TextEditingController val6Controller,
    @required TextEditingController val7Controller,
    TextEditingController nameController,
  })  : _npkController = npkController,
        _val2Controller = val2Controller,
        _nameController = nameController,
        _val3Controller = val3Controller,
        _val4Controller = val4Controller,
        _val5Controller = val5Controller,
        _val6Controller = val6Controller,
        _val7Controller = val7Controller,
        super(key: key);

  final TextEditingController _npkController;
  final TextEditingController _val2Controller;
  final TextEditingController _nameController;
  final TextEditingController _val3Controller;
  final TextEditingController _val4Controller;
  final TextEditingController _val5Controller;
  final TextEditingController _val6Controller;
  final TextEditingController _val7Controller;

  List<Widget> get _loginLogo => [
        Align(
          alignment: Alignment.center,
          child: Container(
            child: Text(
              "Please fill \n   detials",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            alignment: Alignment.center,
          ),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Theme.of(context).canvasColor),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 10,
                      top: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _npkController.clear();
                          _val2Controller.clear();
                          _val3Controller.clear();
                          _val4Controller.clear();
                          _val5Controller.clear();
                          _val6Controller.clear();
                          _val7Controller.clear();
                          _nameController?.clear();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                height: 50,
                width: 50,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              child: Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor),
                              ),
                              alignment: Alignment.center,
                            ),
                            ..._nameController != null ? _loginLogo : _loginLogo
                          ],
                        ),
                      ),
                      SizedBox(height: 60),

                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _npkController,
                        hint: "Val1",
                        icon: Icon(Icons.poll_outlined),
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _val2Controller,
                        hint: "Val2",
                        icon: Icon(Icons.poll_outlined),
                      ),
                      SizedBox(height: 20),
                      // SizedBox(height: 20),
                      CustomTextField(
                        controller: _val3Controller,
                        hint: "Val3",
                        icon: Icon(Icons.poll_outlined),
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _val4Controller,
                        hint: "Val4",
                        icon: Icon(Icons.poll_outlined),
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _val5Controller,
                        hint: "Val5",
                        icon: Icon(Icons.poll_outlined),
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _val6Controller,
                        hint: "Val6",
                        icon: Icon(Icons.poll_outlined),
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _val7Controller,
                        hint: "Val7",
                        icon: Icon(Icons.poll_outlined),
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        label: "Submit",
                        primaryColor: Theme.of(context).primaryColor,
                        secondaryColor: Colors.white,
                        onPressed: () {},
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height / 1.1,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
        ),
      ),
    );
  }
}
