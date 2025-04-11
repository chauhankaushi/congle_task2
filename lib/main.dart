// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: DockPage(),
    debugShowCheckedModeBanner: false,
  ));
}

// ignore: use_key_in_widget_constructors
class DockPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _DockPageState createState() => _DockPageState();
}

class _DockPageState extends State<DockPage> {
  List<int> items = [0, 1, 2, 3, 4];
  int? hoveringIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(items.length, (index) {
                return DragTarget<int>(
                  onWillAccept: (data) => data != index,
                  onAccept: (data) {
                    setState(() {
                      int fromIndex = items.indexOf(data);
                      items.removeAt(fromIndex);
                      items.insert(index, data);
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: LongPressDraggable<int>(
                        data: items[index],
                        // ignore: duplicate_ignore
                        feedback: IconButton(
                          onPressed: () {},
                          // ignore: prefer_const_constructors
                          icon: Icon(Icons.apps),
                          iconSize: 60,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.4,
                          child: dockIcon(index),
                        ),
                        child: MouseRegion(
                          onEnter: (_) {
                            setState(() {
                              hoveringIndex = index;
                            });
                          },
                          onExit: (_) {
                            setState(() {
                              hoveringIndex = null;
                            });
                          },
                          // ignore: duplicate_ignore
                          child: AnimatedContainer(
                            // ignore: prefer_const_constructors
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                            width: hoveringIndex == index ? 70 : 50,
                            height: hoveringIndex == index ? 70 : 50,
                            child: dockIcon(index),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget dockIcon(int index) {
    List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
    ];

    return Container(
      decoration: BoxDecoration(
        color: colors[index],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(
          Icons.apps,
          color: Colors.white,
        ),
      ),
    );
  }
}
