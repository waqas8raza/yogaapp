import 'package:flutter/material.dart';
import 'package:yogaapp/src/Screens/WeeklyYogaScreen.dart';

class YogaTypeScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? learnYoga;
  const YogaTypeScreen({
    super.key,
    this.learnYoga,
  });
  @override
  State<YogaTypeScreen> createState() => _YogaTypeScreenState();
}

class _YogaTypeScreenState extends State<YogaTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.red,
      //backgroundColor: Colors.black,

      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  final List<Map<String, dynamic>> weeklyListData =
                      widget.learnYoga![index]["weeklyYoga"];
                  final String yogaImage =
                      widget.learnYoga![index]["yogaImage"].toString();
                  final String yogaName =
                      widget.learnYoga![index]["yogaName"].toString();
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeeklyYogaScreen(
                                yogaImage: yogaImage,
                                yogaName: yogaName,
                                weeklyYoga: weeklyListData,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image(
                                height: 230,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: AssetImage(widget.learnYoga![index]
                                        ["yogaImage"]
                                    .toString()),
                              ),
                            ),
                            Positioned(
                              top: 30,
                              left: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Text(
                                    widget.learnYoga![index]["yogaName"]
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        backgroundColor:
                                            Colors.white.withOpacity(0.3)),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
