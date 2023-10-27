import 'package:flutter/material.dart';
import 'package:scrollegypt/utils/nav.dart';

const double mainXPadding = 18;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool winner = false;
  List<Map<String, dynamic>> panelList = [
    {'index': 1, 'drop': 0},
    {'index': 2, 'drop': 0},
    {'index': 3, 'drop': 0},
    {'index': 4, 'drop': 0},
    {'index': 5, 'drop': 0},
    {'index': 6, 'drop': 0},
    {'index': 7, 'drop': 0},
    {'index': 8, 'drop': 0},
    {'index': 9, 'drop': 0},
  ];
  List<Map<String, dynamic>> pieceList = [
    {'index': 1, 'drag': false},
    {'index': 2, 'drag': false},
    {'index': 3, 'drag': false},
    {'index': 4, 'drag': false},
    {'index': 5, 'drag': false},
    {'index': 6, 'drag': false},
    {'index': 7, 'drag': false},
    {'index': 8, 'drag': false},
    {'index': 9, 'drag': false},
  ];

  bool complete() {
    for (var panel in panelList) {
      if (panel['index'] != panel['drop']) return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    pieceList.shuffle();
  }

  @override
  void dispose() {
    winner = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    if (screenSize.width > screenSize.height) {
      return _landscape();
    } else {
      return _portrait();
    }
  }

  Widget _portrait() {
    return Scaffold(
      body: Stack(fit: StackFit.expand,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
            child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(winner? 0.5 : 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Padding(padding: const EdgeInsets.symmetric(horizontal: mainXPadding, vertical: 10), child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(onPressed: () {
                        NavigationRouter.back(context);
                      }, icon: Image.asset('assets/images/back.png'))
                    ],
                  ),
                ),
                Expanded(child:
                  Padding(padding: const EdgeInsets.symmetric(horizontal: mainXPadding, vertical: 10), child:
                    GridView(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                      children: grid()
                    )
                  )
                ),
                SizedBox(
                  height: 200,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: pieceList.map((piece) {
                          if (piece['drag'] == true) return Container();
                          return puzzlePieceBox(
                              piece);
                        }).toList(),
                      ))),
              ],
            ),
          ),
          if (winner)
            AlertDialog(
              title: const Text('Success!', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.transparent,
              content: Image.asset('assets/images/origin.jpg')
            )
        ]
      )
    );
  }

  Widget _landscape() {
    return Scaffold(
      body: Stack(fit: StackFit.expand,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height,
            child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(winner? 0.5 : 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: const EdgeInsets.symmetric(horizontal: mainXPadding, vertical: 10), child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(onPressed: () {
                        NavigationRouter.back(context);
                      }, icon: Image.asset('assets/images/back.png'))
                    ],
                  ),
                ),
                Expanded(child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: const EdgeInsets.symmetric(horizontal: mainXPadding), child:
                        SizedBox(
                          width: 300,
                          child: GridView(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10),
                              children: grid()
                            )
                        )
                      ),
                      SizedBox(
                        width: 200,
                        child: SingleChildScrollView(
                            child: Column(
                              children: pieceList.map((piece) {
                                if (piece['drag'] == true) return Container();
                                return puzzlePieceBox(
                                    piece);
                              }).toList(),
                            ))),
                    ],
                  )
                ),
              ],
            ),
          ),
          if (winner)
            AlertDialog(
              title: const Text('Success!', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.transparent,
              content: Image.asset('assets/images/origin.jpg')
            )
        ]
      )
    );
  }

  Widget puzzlePieceBox(Map<String, dynamic> piece) {
    return Padding(padding: const EdgeInsets.all(10), child:
      Draggable<String>(
        data: piece['index'].toString(),
        feedback: SizedBox(
          height: 100.0,
          width: 100.0,
          child: Center(
            child: Image.asset('assets/images/${piece["index"]}.png', fit: BoxFit.cover),
          ),
        ),
        childWhenDragging: Container(),
        onDragStarted: () {
        },
        child: SizedBox(
          height: 100.0,
          width: 100.0,
          child: Center(
            child: Image.asset('assets/images/${piece["index"]}.png', fit: BoxFit.cover),
          ),
        ),
      )
    );
  }

  List<Widget> grid() {
    List<Widget> list = panelList.map((element) => 
      InkWell(
        onDoubleTap: () {
          for (var i = 0; i < pieceList.length; i++) {
            if (pieceList[i]['index'] == element['drop']) { pieceList[i]['drag'] = false; }
          }
          for (var i = 0; i < panelList.length; i++) {
            if (panelList[i]['index'] == element['index']) { panelList[i]['drop'] = 0; }
          }
          setState(() {
          });
        },
        child:
        DragTarget<String>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: element['drop'] > 0 ? Image.asset('assets/images/${element["drop"]}.png', fit: BoxFit.cover) : Container()
            );
          },
          onWillAccept: (data) {
            return element['drop'] > 0 ? false : true;
          },
          onAccept: (data) {
            for (var i = 0; i < panelList.length; i++) {
              if (panelList[i]['index'] == element['index']) { panelList[i]['drop'] = int.parse(data); }
            }
            for (var i = 0; i < pieceList.length; i++) {
              if (pieceList[i]['index'] == int.parse(data)) { pieceList[i]['drag'] = true; }
            }
            if (complete()) winner = true;
            setState(() {
            });
          },
        )
      )
    ).toList();
    return list;
  }
}
