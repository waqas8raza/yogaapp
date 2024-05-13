import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:velocity_x/velocity_x.dart';
import 'WeeklyYogaScreen.dart';

class DesiredShapeMale extends StatefulWidget {
  final List<Map<String, dynamic>>? desiredShape;
  const DesiredShapeMale({super.key, this.desiredShape});

  @override
  State<DesiredShapeMale> createState() => _DesiredShapeMaleState();
}

class _DesiredShapeMaleState extends State<DesiredShapeMale> {
  int selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 350,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "What's Your ",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'Desired',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink)),
                            TextSpan(text: ' Body Shape?!'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedValue = 1;
                    });
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                widget.desiredShape![0]['shapeImage'],
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              )),
                          Positioned(
                              bottom: 10,
                              right: 10,
                              child: Text(
                                widget.desiredShape![0]['shapeName'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                          //"Rectangle".text.bold.size(17).make().positioned(top: 128, left: 230, height: 22, width: 89),
                          Positioned(
                            height: 12,
                            width: 12,
                            top: 20,
                            right: 20,
                            child: Radio(
                                value: 1,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedValue = 2;
                    });
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                widget.desiredShape![1]['shapeImage'],
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              )),
                          Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(
                                widget.desiredShape![1]['shapeName'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                          Positioned(
                            height: 12,
                            width: 12,
                            top: 20,
                            left: 20,
                            child: Radio(
                                value: 2,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedValue = 3;
                    });
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      height: 170,
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                widget.desiredShape![2]['shapeImage'],
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              )),
                          Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(
                                widget.desiredShape![2]['shapeName'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                          Positioned(
                            height: 12,
                            width: 12,
                            top: 20,
                            left: 20,
                            child: Radio(
                                value: 3,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedValue = 4;
                    });
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      height: 170,
                      decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                widget.desiredShape![3]['shapeImage'],
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              )),
                          Positioned(
                              bottom: 10,
                              right: 10,
                              child: Text(
                                widget.desiredShape![3]['shapeName'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),
                          Positioned(
                            height: 12,
                            width: 12,
                            top: 20,
                            right: 20,
                            child: Radio(
                                value: 4,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black38,
                        ).onTap(() {
                          Navigator.pop(context);
                        }),
                        "  Previous"
                            .text
                            .caption(context)
                            .bold
                            .xl2
                            .make()
                            .onTap(() {
                          Navigator.pop(context);
                        }),
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 42,
                        width: 106,
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedValue == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WeeklyYogaScreen(
                                            weeklyYoga: widget.desiredShape![0]
                                                ["weeklyYoga"],
                                            yogaImage: widget.desiredShape![0]
                                                ["shapeImage"],
                                            yogaName: widget.desiredShape![0]
                                                ["shapeName"],
                                          )));
                            } else if (selectedValue == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WeeklyYogaScreen(
                                            weeklyYoga: widget.desiredShape![1]
                                                ["weeklyYoga"],
                                            yogaImage: widget.desiredShape![1]
                                                ["shapeImage"],
                                            yogaName: widget.desiredShape![1]
                                                ["shapeName"],
                                          )));
                            } else if (selectedValue == 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WeeklyYogaScreen(
                                            weeklyYoga: widget.desiredShape![2]
                                                ["weeklyYoga"],
                                            yogaImage: widget.desiredShape![2]
                                                ["shapeImage"],
                                            yogaName: widget.desiredShape![2]
                                                ["shapeName"],
                                          )));
                            } else if (selectedValue == 4) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WeeklyYogaScreen(
                                            weeklyYoga: widget.desiredShape![3]
                                                ["weeklyYoga"],
                                            yogaImage: widget.desiredShape![3]
                                                ["shapeImage"],
                                            yogaName: widget.desiredShape![3]
                                                ["shapeName"],
                                          )));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Center(
                                          child: Text(
                                              "Please Select Desired Body"))));
                            }
                          },
                          child: "Next".text.bold.color(Colors.white).xl.make(),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.pinkAccent),
                            shape: MaterialStatePropertyAll(StadiumBorder()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
