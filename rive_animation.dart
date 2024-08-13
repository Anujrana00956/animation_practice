import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class SimpleanimationRive extends StatefulWidget {
  const SimpleanimationRive({super.key});

  @override
  State<SimpleanimationRive> createState() => _SimpleanimationRiveState();
}

class _SimpleanimationRiveState extends State<SimpleanimationRive> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  StateMachineController? _controller;
  Artboard? mainArtboard;
  SMIBool? check;
  SMINumber? look;
  SMIBool? success;
  SMIBool? fail;
  SMIBool? hands_up;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.load("assets/login_screen_character.riv").then((riveBytes) {
      var rivefile = RiveFile.import(riveBytes);
      var mArtboard = rivefile.mainArtboard;
      _controller =
          StateMachineController.fromArtboard(mArtboard, "State Machine 1");
      mainArtboard = mArtboard;
      if (_controller != null) {
        mArtboard.addController(_controller!);
        mainArtboard = mArtboard;
        check = _controller?.findSMI("Check");
        success = _controller?.findSMI("success");
        fail = _controller?.findSMI("fail");
        hands_up = _controller?.findSMI("hands_up");
        look = _controller?.findSMI("Look");
        setState(() {});
      }
    });
  }

  bool isPasswordVissible = false;

  @override
  Widget build(BuildContext context) {
    void ischeckField() {
      check?.change(true);
      hands_up?.change(false);
      look?.change(0);
    }

    void eyesMoving(value) {
      look?.change(value.length.toDouble());
    }

    void passwordHide() {
      hands_up?.change(true);
    }

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            RiveAnimation.asset("assets/shapes.riv", fit: BoxFit.cover),
            Column(
              children: [
                Container(
                    child:
                        //RiveAnimation.asset(
                        //   "assets/login_screen_character.riv",
                        //   stateMachines: ["State Machine 1"],
                        //   onInit: (mainArtboard) {
                        //     _controller = StateMachineController.fromArtboard(
                        //         mainArtboard, "State Machine 1");
                        //     if (_controller == null) return;
                        //     mainArtboard.addController(_controller!);
                        //     check = _controller?.findSMI("Check");
                        //     success = _controller?.findSMI("success");
                        //     fail = _controller?.findSMI("fail");
                        //     hands_up = _controller?.findSMI("hands_up");
                        //     look = _controller?.findSMI("Look");
                        //   },
                        // )
                        mainArtboard != null
                            ? Rive(
                                artboard: mainArtboard!,
                                useArtboardSize: true,
                                antialiasing: true,
                              )
                            : Center(child: CircularProgressIndicator())),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 350, left: 20, right: 20),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.sizeOf(context).height / 2.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            spreadRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "please enter the email";
                                }
                              },
                              onChanged: eyesMoving,
                              onTap: ischeckField,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "email",
                                  prefixIcon: Icon(
                                    Icons.email,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "please enter the Password";
                                } else if (value.length < 6) {
                                  return "password not less than 6 chacaters";
                                }
                              },
                              obscureText: !isPasswordVissible,
                              onTap: passwordHide,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "password",
                                  prefixIcon: Icon(
                                    Icons.key,
                                  ),
                                  suffixIcon: ToggleFunc(),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide:
                                          BorderSide(color: Colors.red))),
                            ),
                            const SizedBox(height: 50),
                            ElevatedButton(
                              onPressed: () {
                                formValidation();
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  fixedSize: const Size(200, 50),
                                  backgroundColor: Colors.white),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ToggleFunc() {
    return IconButton(
        onPressed: () {
          setState(() {
            isPasswordVissible = !isPasswordVissible;
          });
        },
        icon: isPasswordVissible
            ? Icon(Icons.visibility)
            : Icon(Icons.visibility_off));
  }

  void formValidation() {
    if (_formKey.currentState!.validate()) {
      check?.change(false);
      hands_up?.change(false);
      fail?.change(false);
      success?.change(true);
    } else {
      check?.change(false);
      hands_up?.change(false);
      fail?.change(true);
      success?.change(false);
    }
  }
}
