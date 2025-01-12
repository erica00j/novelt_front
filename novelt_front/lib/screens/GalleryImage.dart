import 'package:flutter/material.dart';
import 'package:novelt_front/screens/InputPrompt.dart';

import 'GalleryVideo.dart';
import 'ShowGalleryImages.dart';

class GalleryImage extends StatefulWidget {
  const GalleryImage({Key? key}) : super(key: key);

  @override
  _GalleryImageState createState() => _GalleryImageState();
}

class CardImage {
  final AssetImage topLeft;
  final AssetImage topRight;
  final AssetImage bottomLeft;
  final AssetImage bottomRight;
  final String title;

  CardImage({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
    required this.title,
  });
}


class _GalleryImageState extends State<GalleryImage> with TickerProviderStateMixin {
  late TabController _tabController1;
  late TabController _tabController2;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController1 = TabController(length: 3, vsync: this);
    // _tabController1에 대한 리스너 설정
    _tabController1.addListener(() {
      if (_tabController1.indexIsChanging) {
        // _tabController2의 인덱스 변경이 완료되었는지 확인
        return;
      }
      if (_tabController1.index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InputPrompt()));
      }
      setState(() {
        _selectedIndex = _tabController1.index; // 선택된 탭 인덱스 업데이트
      });
    });
    _tabController2 = TabController(length: 2, vsync: this);
    _tabController2.addListener(() {
      if (_tabController2.indexIsChanging) {
        // _tabController2의 인덱스 변경이 완료되었는지 확인
        return;
      }
      if (_tabController2.index == 1) {
        // 두 번째 탭(인덱스가 1)이 선택되었을 때
        Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryVideo()));
        // GalleryVideo 페이지로 네비게이션
      }
      setState(() {
        _selectedIndex = _tabController2.index; // 선택된 탭 인덱스 업데이트
      });
    });
  }

  @override
  void dispose() {
    _tabController1.dispose();
    _tabController2.dispose();
    super.dispose();
  }
  // 위의 CardImage 리스트로 대체합니다.
  List<CardImage> imageCards = [
    CardImage(
      topLeft: AssetImage('images/1.png'),
      topRight: AssetImage('images/2.png'),
      bottomLeft: AssetImage('images/3.png'),
      bottomRight: AssetImage('images/4.png'),
      title: '내 남편과 결혼해줘',
    ),
    CardImage(
      topLeft: AssetImage('images/5.png'),
      topRight: AssetImage('images/6.png'),
      bottomLeft: AssetImage('images/7.png'),
      bottomRight: AssetImage('images/8.png'),
      title: '사내맞선',
    ),
    CardImage(
      topLeft: AssetImage('images/9.png'),
      topRight: AssetImage('images/10.png'),
      bottomLeft: AssetImage('images/11.png'),
      bottomRight: AssetImage('images/12.png'),
      title: '재벌집 막내아들',
    ),

    // ... 추가 카드 데이터
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7FF),
      appBar: AppBar(
        title: const Text(
          'TRAILER',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF9a7eff), // Left side color
                Color(0xFFbe82f4), // Right side color, change to desired color
              ],
            ),
          ),
        ),// Adds a shadow below the AppBar
      ),

      bottomNavigationBar: SizedBox(
        height: 70,
        child: TabBar(controller: _tabController1, tabs: const <Widget>[
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
      body: Column(
        children: <Widget>[
          // ToggleButtons with each icon centered in its half of the screen
          TabBar(
            controller: _tabController2,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.video_collection_outlined)),
            ],
          ),




        Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //2열 형태
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1 / 1.2,
              ),
              itemCount: imageCards.length,
              itemBuilder: (BuildContext context, int index) {
                final card = imageCards[index];
                return GestureDetector( // Wrap the card in GestureDetector
                    onTap: () {
                  // Navigate to ShowGalleryImages when the card is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShowGalleryImages()), // Pass the selected card data to the ShowGalleryImages page
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AspectRatio(
                      aspectRatio: 1, // 정사각형 카드
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 8, // 그림자 효과를 위한 elevation 값 추가
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(child: Image(image: card.topLeft, fit: BoxFit.cover)),
                                  Expanded(child: Image(image: card.topRight, fit: BoxFit.cover)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Expanded(child: Image(image: card.bottomLeft, fit: BoxFit.cover)),
                                  Expanded(child: Image(image: card.bottomRight, fit: BoxFit.cover)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        width: double.infinity, // This ensures the container takes all available width
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 10.0),// This aligns the child to the left of the container
                        child: Text(
                          card.title,
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left, // This ensures the text inside the Text widget is left-aligned
                        ),
                      ),
                    ),

                  ],
                ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
