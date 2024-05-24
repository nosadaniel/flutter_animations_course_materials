import 'package:flutter/material.dart';

class TweenAnimationBuilderPage extends StatelessWidget {
  const TweenAnimationBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TweenAnimationBuilder'),
      ),
      body: Center(
        child: HSVColorSelector(),
      ),
    );
  }
}

class HSVColorSelector extends StatefulWidget {
  @override
  State<HSVColorSelector> createState() => _HSVColorSelectorState();
}

double _hue = 0.0;

class _HSVColorSelectorState extends State<HSVColorSelector> {
  @override
  Widget build(BuildContext context) {
    final HSVColor containerColor = HSVColor.fromAHSV(1.0, _hue, 1.0, 1.0);

    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 250,
          width: 250,
          color: containerColor.toColor(),
          child: Center(
            child: Text(
              "Output",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 40),
        TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: _hue),
            duration: Duration(milliseconds: 1500),
            builder: (context, hue, child) {
              final hsvColor = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0);
              return Container(
                width: 250,
                height: 250,
                color: hsvColor.toColor(),
              );
            }),
        SizedBox(height: 40.0),
        Container(
          height: 30.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              for (var h = 0; h <= 360; h++)
                HSVColor.fromAHSV(1.0, h.toDouble(), 1.0, 1.0).toColor()
            ], stops: [
              for (var h = 0; h <= 360; h++) h.toDouble() / 360.0
            ]),
          ),
        ),
        Slider.adaptive(
            value: _hue,
            max: 360,
            min: 0,
            onChanged: (value) {
              setState(() {
                _hue = value;
              });
            }),
      ],
    );
  }
}
