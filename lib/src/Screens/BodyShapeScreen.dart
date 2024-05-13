import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yogaapp/src/Screens/DesiredBodyShapeScreen.dart';

class BodyShapeScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? bodyShape;
  const BodyShapeScreen({super.key, this.bodyShape});

  @override
  State<BodyShapeScreen> createState() => _BodyShapeScreenState();
}

class _BodyShapeScreenState extends State<BodyShapeScreen> {
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
                SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "What's Your",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " Body",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      " Shape?",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
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
                  child: Container(
                    width: double.infinity,
                    height: 170,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                widget.bodyShape![0]["shapeImage"],
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              )),
                          Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(widget.bodyShape![0]["shapeName"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          Positioned(
                            height: 12,
                            width: 12,
                            top: 20,
                            left: 20,
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
                  child: Container(
                    decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    height: 170,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                widget.bodyShape![1]["shapeImage"],
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              )),
                          Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(widget.bodyShape![1]["shapeName"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
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
                  child: Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                widget.bodyShape![2]["shapeImage"],
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )),
                          Positioned(
                              bottom: 10,
                              right: 10,
                              child: Text(widget.bodyShape![2]["shapeName"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          Positioned(
                            height: 12,
                            width: 12,
                            top: 20,
                            right: 20,
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
                  child: Container(
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                widget.bodyShape![3]["shapeImage"],
                                height: double.infinity,
                                width: double.infinity,
                                fit: BoxFit.fill,
                              )),
                          Positioned(
                              bottom: 10,
                              right: 10,
                              child: Text(widget.bodyShape![3]["shapeName"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
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
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black38,
                        ).py64().onTap(() {
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
                                      builder: (context) => DesiredShapeMale(
                                          desiredShape: widget.bodyShape![0]
                                              ["desiredShape"])));
                            } else if (selectedValue == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesiredShapeMale(
                                          desiredShape: widget.bodyShape![1]
                                              ["desiredShape"])));
                            } else if (selectedValue == 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesiredShapeMale(
                                          desiredShape: widget.bodyShape![2]
                                              ["desiredShape"])));
                            } else if (selectedValue == 4) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DesiredShapeMale(
                                          desiredShape: widget.bodyShape![3]
                                              ["desiredShape"])));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                      content: Center(
                                          child: Text(
                                "Please chose one Body Shape",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ))));
                            }
                          },
                          child: "Next".text.xl.bold.make(),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.pinkAccent),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            shape: MaterialStatePropertyAll(StadiumBorder()),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
