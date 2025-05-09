import 'package:flutter/material.dart';

import 'ConstantData.dart';


class DottedSlider extends StatefulWidget {
  final Color color;
  final List<Widget> children;
  final double maxHeight;

  DottedSlider({required Key key, required this.color, required this.children, required this.maxHeight})
      : super(key: key);

  @override
  _DottedSliderState createState() => new _DottedSliderState();
}

class _DottedSliderState extends State<DottedSlider> {
  PageController controller = PageController();

  double currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // ConstrainedBox(
        //   constraints: BoxConstraints(maxHeight: widget.maxHeight),
        //   child:
        Expanded(
          child: PageView(
            controller: controller,
            children: widget.children,
          ),
          flex: 1,
        ),
        // SizedBox(height: 7,),
        // // ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(7),
            child: _drawDots(currentPage),
          ),
        ),
        // SizedBox(height: 5,)
      ],
    );
  }

  _drawDots(page) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < widget.children.length; i++) dot((page == i)),
      ],
    );
  }

  dot(bool selected) {
    double size = 12;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 2, left: 2, bottom: 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (selected) ? ConstantData.primaryColor : Colors.white),
      ),
    );
  }
}
