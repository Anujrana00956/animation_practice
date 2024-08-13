import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool change=false;

  List Location=['assets/mountain.jpg','assets/sea.jpg','assets/mountain2.jpg','assets/sea.jpg'];
  List addressLine=['La Cresenta-Montrose, CA91020 Glendale','La Cresenta-Montrose, CA91020 Glendale','La Cresenta-Montrose, CA91020 Glendale','La Cresenta-Montrose, CA91020 Glendale'];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("animation"),
        backgroundColor: Colors.blue,

      ),
body: Container(
  color: Colors.black12,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(
        child: CarouselSlider.builder(
          itemCount: Location.length,
          itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
              Stack(
                children: [

                  AnimatedContainer(
                    duration: Duration(milliseconds: 700),
                    color: Colors.red,
                    height: change==true?700:310,
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('title'),
                        Text('Description will be here')
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                     setState(() {
                     if(change==false){
                       change=true;
                     }else{
                       change=false;
                     }
                     });

                    },
                    child: AnimatedAlign(
                      duration: Duration(milliseconds: 300),
                      alignment:change==true?Alignment.topCenter: Alignment.bottomCenter,

                      child: Container(

                        height: 300,
                        width: 300,
                        child: Image.asset(Location[itemIndex]),
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 380,
                  //   width: 215,
                  //   color: Colors.amberAccent,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Text(addressLine[itemIndex]),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: GestureDetector(
                  //       onTap: (){
                  //         setState(() {
                  //           change!=change;
                  //         });
                  //       },
                  //       child: Image.asset(Location[itemIndex],height: 300,)),
                  // ),
                ],
              ), options: CarouselOptions(height: 400.0),

        ),
      ),


    ],
  ),
)
    );
  }
}
