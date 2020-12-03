import 'package:flutter/material.dart';
import 'package:modoh/screens/authenticate/home.dart';
import 'package:modoh/screens/authenticate/login.dart';
import 'package:modoh/services/auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  final AuthService _auth = AuthService();

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
                          navigateToSignUp(context);
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
                        onTap: () {
                          navigateToLogIn(context);
                        },
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
                image: ExactAssetImage("lib/assets/images/login.jpg"),
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
          Form(
            key: _formKey,
            child: Scrollbar(
              child: Align(
                alignment: FractionalOffset(0.2, 0.5),
                child: Card(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 400),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Welcome!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff8adc16),
                              fontSize: 72,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          ...[
                            TextFormField(
                              decoration: InputDecoration(
                                filled: true,
                                hintText: 'Enter an email...',
                                labelText: 'Email',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                filled: true,
                                hintText: 'Enter a password...',
                                labelText: 'Password',
                              ),
                              obscureText: true,
                              onChanged: (value) {
                                _password = value;
                              },
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                                "Sign Up",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xff8adc16),
                                                  fontSize: 24,
                                                  fontFamily: "Roboto",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            onPressed: () async {
                                              dynamic result = await _auth
                                                  .registerWithEmailAndPassword(
                                                      _email, _password);
                                              if (result == null) {
                                                print('Error signing in!');
                                              } else {
                                                print('Signed up!');
                                                print(result.email);
                                              }
                                              Navigator.pop(context);
                                            }),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ].expand(
                            (widget) => [
                              widget,
                              SizedBox(
                                height: 24,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future navigateToSignUp(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  Future navigateToHome(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  }

  Future navigateToLogIn(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }
}

// // ignore: must_be_immutable
// class Login extends StatelessWidget {

// }

// void setState(Null Function() param0) {}
