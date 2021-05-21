import 'package:flutter/material.dart';

class SliderSwitch extends StatefulWidget {
  const SliderSwitch({Key key, this.onTap, this.enabled});

  final GestureTapCallback onTap;
  final bool enabled;

  @override
  _SliderSwitchState createState() => _SliderSwitchState();
}

class _SliderSwitchState extends State<SliderSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 38.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFBFBFB),
              Color(0xFFBBBBBB),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(19.0)),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: Duration(milliseconds: 230),
              curve: Curves.easeIn,
              alignment:
              widget.enabled ? Alignment.topRight : Alignment.topLeft,
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    width: constraints.maxWidth / 2.0,
                    child: Container(
                      padding: EdgeInsets.all(1.0),
                      height: 38.0,
                      decoration: BoxDecoration(
                        // color: Color(0xFF38433f),
                        color: Color(0xFF121212),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "ЧОЛОВІК",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 18,
                        color: widget.enabled
                            ? Color(0xcc000000)
                            : Color(0xFFDBDBDB),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "ЖІНКА",
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 18,
                        color: widget.enabled
                            ? Color(0xFFDBDBDB)
                            : Color(0xcc000000),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
