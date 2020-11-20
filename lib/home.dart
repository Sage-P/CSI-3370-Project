import 'package:flutter/material.dart';
import 'package:modoh/login.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MODOH - The Budgeting Tool for Students',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List _isHovering = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
          color: Color(0xff37474f),
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              right: 20,
              left: 20,
            ),
            child: Row(
              children: [
                FlatButton(
                    child: Text(
                      'MODOH',
                      style: TextStyle(
                        color: Color(0xff8adc16),
                        fontSize: 30,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 3,
                      ),
                    ),
                    onPressed: () {
                      navigateToHome(context);
                    }),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[0] = true
                                : _isHovering[0] = false;
                          });
                        },
                        onTap: () {
                          navigateToLogin(context);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                color: _isHovering[0]
                                    ? Colors.white
                                    : Color(0xff8adc16),
                              ),
                            ),
                            SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[0],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Color(0xff8adc16),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: screenSize.width / 50),
                      InkWell(
                        onHover: (value) {
                          setState(() {
                            value
                                ? _isHovering[1] = true
                                : _isHovering[1] = false;
                          });
                        },
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                color: _isHovering[1]
                                    ? Colors.white
                                    : Color(0xff8adc16),
                              ),
                            ),
                            SizedBox(height: 5),
                            Visibility(
                              maintainAnimation: true,
                              maintainState: true,
                              maintainSize: true,
                              visible: _isHovering[1],
                              child: Container(
                                height: 2,
                                width: 20,
                                color: Color(0xff8adc16),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            // image below the top bar
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage("lib/assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            width: screenSize.width,
            height: screenSize.height,
          ),
          Center(
            heightFactor: 1,
            child: Padding(
              padding: EdgeInsets.only(
                top: screenSize.height * 0.40,
                left: screenSize.width / 5,
                right: screenSize.width / 5,
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "A better way to budget",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff8adc16),
                              fontSize: 72,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "A simple, intuitive budgeting tool for the everyday student.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff37474f),
                              fontSize: 24,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff37474f),
                      ),
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 24,
                        top: 18,
                        bottom: 17,
                      ),
                      child: FlatButton(
                          color: Color(0xff37474f),
                          child: SizedBox(
                            width: 231,
                            child: Text(
                              "Sign up now",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff8adc16),
                                fontSize: 24,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          onPressed: () {
                            navigateToLogin(context);
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future navigateToLogin(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  Future navigateToHome(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LandingPage()));
  }
}
