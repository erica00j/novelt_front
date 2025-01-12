import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SelectScene extends StatefulWidget {
  const SelectScene({super.key});

  @override
  State<SelectScene> createState() => _SelectSceneState();
}

class _SelectSceneState extends State<SelectScene>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 1;
  final double imgwidth = 112;
  final double imgheight = 200;

  final controller = PageController(
    viewportFraction: 0.8,
    keepPage: false,
    initialPage: 0,
  );


  final pages = List.generate(
      6,
          (index) =>
          Container(
              margin: EdgeInsets.all(10),
              child: Container(height: 400,
                child:
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                      children: [
                        Image.asset('images/testimg.png',
                          width: 120,
                          height: 205,
                        ),
                        Image.asset('images/testimg.png',
                          width: 120,
                          height: 205,
                        )
                      ],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
                      children: [
                        Image.asset('images/testimg.png',
                          width: 120,
                          height: 205,
                        ),
                        Image.asset('images/testimg.png',
                          width: 120,
                          height: 205,
                        )
                      ],),
                  ],),)
            // child: Container(
            //   height: 280,
            //   child: Center(
            //       child: Text(
            //         "Page $index",
            //         style: TextStyle(color: Colors.black),
            //       )),
            // ),
          ));


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(
            () => setState(() => _selectedIndex = _tabController.index));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: SizedBox(
        height: 70,
        child: TabBar(controller: _tabController, tabs: const <Widget>[
          Tab(
            icon: Icon(
              Icons.grid_on,
              color: Colors.black,
              size:28,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.add_circle,
              color: Colors.deepPurpleAccent,
              size: 42,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.person,
              color: Colors.black,
              size: 32,
            ),
          )
        ]),
      ),
      body: SingleChildScrollView( // Added SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Text(
                '장면 설명',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'gpt 내용 입력',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 430,
              child: PageView.builder(
                controller: controller,
                // itemCount: pages.length,
                itemBuilder: (_, index) {
                  return pages[index % pages.length];
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: const WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  type: WormType.thinUnderground,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

final colors = const [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
