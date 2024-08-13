import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
    bool clickButton=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(

          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     colors: [
              //       Color.fromRGBO(145, 131, 222, 1),
              //       Color.fromRGBO(160, 148, 227, 1),
              //     ]
            image:DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/background.jpg")),
              ),



        child:Column(
          children: [
SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(child:
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "email",
                        prefixIcon: Icon(Icons.email,),
                        border: OutlineInputBorder(

                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ,borderSide: BorderSide(color: Colors.red)
                        )),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "password",
                        prefixIcon: Icon(Icons.key,),
                        suffixIcon: Icon(Icons.visibility),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ,borderSide: BorderSide(color: Colors.red)
                        )),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(onPressed: (){

                    setState(() {
                    clickButton=!clickButton;
                    });
                    print(clickButton);
                  },style: ElevatedButton.styleFrom(shape: StadiumBorder()
                    ,fixedSize: const Size(200, 50),
                    backgroundColor: Colors.white), child: Text("Login")
                  ,
                  )
                ],
              )),

            ),
Spacer(),
(clickButton==true)? AnimationIm(clickButton: clickButton):Image.asset("assets/roc.png")
          ],
        ),
      ),
    );
  }
}
class AnimationIm extends StatefulWidget {
   AnimationIm({super.key, required this.clickButton});
   bool clickButton;
  @override
  State<AnimationIm> createState() => _AnimationImState();
}

class _AnimationImState extends State<AnimationIm> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<Offset>  _animation;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=AnimationController(
        duration: Duration(seconds: 3),vsync: this);
    _animation=Tween<Offset>(
        begin: Offset.zero,
        end: Offset(0,-3)).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    if (widget.clickButton) {
      // Start animation if clickButton is true
      controller.forward();
    }
  }
// @override
//   void didUpdateWidget(covariant AnimationIm oldWidget) {
//     // TODO: implement didUpdateWidget
//     super.didUpdateWidget(oldWidget);
//     if(widget.clickButton!=oldWidget.clickButton)
//       {
//         if(widget.clickButton){
//           controller.forward();
//           print("animation strat");
//         }
//       }
//   }

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("didUpdateWidget called with clickButton: ${widget.clickButton}");

    return SlideTransition(position: _animation,
    child:  Image.asset("assets/roc.png"));
  }
}
