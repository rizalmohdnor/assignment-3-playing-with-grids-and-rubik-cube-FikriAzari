import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2x2 Rubik\'s Cube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CubeScreen(),
    );
  }
}

class CubeState {
  List<List<Color>> faces = [
    [Colors.red, Colors.red, Colors.red, Colors.red], 
    [Colors.blue, Colors.blue, Colors.blue, Colors.blue], 
    [Colors.green, Colors.green, Colors.green, Colors.green], 
    [Colors.yellow, Colors.yellow, Colors.yellow, Colors.yellow], 
    [Colors.orange, Colors.orange, Colors.orange, Colors.orange], 
    [Colors.white, Colors.white, Colors.white, Colors.white], 
  ];

  void rotateTop() {
    List<Color> tempTop = [...faces[4]];
    faces[4] = [tempTop[2], tempTop[0], tempTop[3], tempTop[1]];

    List<Color> tempRow = [faces[0][0], faces[0][1]];
    faces[0][0] = faces[1][0];
    faces[0][1] = faces[1][1];
    faces[1][0] = faces[3][2];
    faces[1][1] = faces[3][3];
    faces[3][2] = faces[2][0];
    faces[3][3] = faces[2][1];
    faces[2][0] = tempRow[0];
    faces[2][1] = tempRow[1];
  }

  void rotateBottom() {
    List<Color> tempBottom = [...faces[5]];
    faces[5] = [tempBottom[2], tempBottom[0], tempBottom[3], tempBottom[1]];

    List<Color> tempRow = [faces[0][2], faces[0][3]];
    faces[0][2] = faces[2][2];
    faces[0][3] = faces[2][3];
    faces[2][2] = faces[3][0];
    faces[2][3] = faces[3][1];
    faces[3][0] = faces[1][2];
    faces[3][1] = faces[1][3];
    faces[1][2] = tempRow[0];
    faces[1][3] = tempRow[1];
  }

  void rotateLeft() {
    List<Color> tempLeft = [...faces[1]];
    faces[1] = [tempLeft[2], tempLeft[0], tempLeft[3], tempLeft[1]];

    List<Color> tempColumn = [faces[0][0], faces[0][2]];
    faces[0][0] = faces[4][0];
    faces[0][2] = faces[4][2];
    faces[4][0] = faces[3][3];
    faces[4][2] = faces[3][1];
    faces[3][3] = faces[5][0];
    faces[3][1] = faces[5][2];
    faces[5][0] = tempColumn[0];
    faces[5][2] = tempColumn[1];
  }

  void rotateRight() {
    List<Color> tempRight = [...faces[2]];
    faces[2] = [tempRight[2], tempRight[0], tempRight[3], tempRight[1]];

    List<Color> tempColumn = [faces[0][1], faces[0][3]];
    faces[0][1] = faces[5][1];
    faces[0][3] = faces[5][3];
    faces[5][1] = faces[3][2];
    faces[5][3] = faces[3][0];
    faces[3][2] = faces[4][1];
    faces[3][0] = faces[4][3];
    faces[4][1] = tempColumn[0];
    faces[4][3] = tempColumn[1];
  }
}

class CubeScreen extends StatefulWidget {
  const CubeScreen({Key? key}) : super(key: key);

  @override
  _CubeScreenState createState() => _CubeScreenState();
}

class _CubeScreenState extends State<CubeScreen> {
  CubeState cube = CubeState();

  void rotateTop() {
    setState(() {
      cube.rotateTop();
    });
  }

  void rotateBottom() {
    setState(() {
      cube.rotateBottom();
    });
  }

  void rotateLeft() {
    setState(() {
      cube.rotateLeft();
    });
  }

  void rotateRight() {
    setState(() {
      cube.rotateRight();
    });
  }

  Widget buildFace(List<Color> faceColors) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => Container(color: faceColors[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2x2 Rubik\'s Cube'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('Top'),
                    SizedBox(height: 100, width: 100, child: buildFace(cube.faces[4])),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('Left'),
                    SizedBox(height: 100, width: 100, child: buildFace(cube.faces[1])),
                  ],
                ),
                Column(
                  children: [
                    const Text('Front'),
                    SizedBox(height: 100, width: 100, child: buildFace(cube.faces[0])),
                  ],
                ),
                Column(
                  children: [
                    const Text('Right'),
                    SizedBox(height: 100, width: 100, child: buildFace(cube.faces[2])),
                  ],
                ),
                Column(
                  children: [
                    const Text('Back'),
                    SizedBox(height: 100, width: 100, child: buildFace(cube.faces[3])),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('Bottom'),
                    SizedBox(height: 100, width: 100, child: buildFace(cube.faces[5])),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: rotateTop, child: const Text('Rotate Top')),
                ElevatedButton(onPressed: rotateBottom, child: const Text('Rotate Bottom')),
                ElevatedButton(onPressed: rotateLeft, child: const Text('Rotate Left')),
                ElevatedButton(onPressed: rotateRight, child: const Text('Rotate Right')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
