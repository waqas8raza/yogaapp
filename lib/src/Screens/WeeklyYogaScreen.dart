import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:yogaapp/src/Screens/PlayerListScreen.dart';

class WeeklyYogaScreen extends StatelessWidget {
  final String? yogaImage;
  final String? yogaName;
  final List<Map<String, dynamic>>? weeklyYoga;

  const WeeklyYogaScreen({
    super.key,
    this.yogaImage,
    this.yogaName,
    this.weeklyYoga,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Weekly Yoga",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.pinkAccent.shade100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Stack(children: [
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          yogaImage.toString(),
                          height: 250,
                          fit: BoxFit.cover,
                        )),
                  ).pOnly(top: 8),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Text(
                        yogaName.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.white.withOpacity(0.3)),
                      )),
                ),
              ]),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                itemCount: weeklyYoga!.length,
                itemBuilder: (context, index) {
                  var videoList = weeklyYoga![index]['videoList'];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Material(
                      elevation: 20,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Vx.black.withOpacity(0.01),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.timeline_outlined,
                                  size: 50,
                                  color: Colors.pinkAccent,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, top: 10),
                                  child: Text(
                                    weeklyYoga![index]['day'].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).onTap(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerListScreen(
                                      videoList: videoList,
                                    )));
                      }),
                    ),
                  );
                },
                physics: ScrollPhysics(),
                shrinkWrap: true,
                //itemCount: 7,
              )
            ],
          ),
        ),
      ),
    );
  }
}
