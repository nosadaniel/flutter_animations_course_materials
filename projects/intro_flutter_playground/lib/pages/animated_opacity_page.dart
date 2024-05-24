import 'package:flutter/material.dart';

class AnimatedOpacityPage extends StatefulWidget {
  const AnimatedOpacityPage({super.key});

  @override
  State<AnimatedOpacityPage> createState() => AnimatedOpacityPageState();
}

class AnimatedOpacityPageState extends State<AnimatedOpacityPage> {
  Curve fadeInOut = Curves.fastOutSlowIn;
  double opacity = 1.0;
  void toggleOpacity() {
    setState(() {
      opacity = opacity == 0.0 ? 1.0 : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedOpacity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: opacity,
              duration: Duration(seconds: 1),
              curve: Curves.easeInBack,
              child: FlutterLogo(size: 200),
            ),
            ElevatedButton(
              child: Text('Fade Logo'),
              // TODO: Implement
              onPressed: toggleOpacity,
            ),
          ],
        ),
      ),
    );
  }
}
