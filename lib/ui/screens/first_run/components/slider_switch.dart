import 'package:flutter/material.dart';

class SliderSwitch extends StatefulWidget {
  const SliderSwitch({
    required this.onTap,
    required this.enabled,
    super.key,
  });

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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFFFBFBFB),
              Color(0xFFBBBBBB),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(19.0)),
        ),
        child: Stack(
          children: <Widget>[
            AnimatedAlign(
              duration: const Duration(milliseconds: 230),
              curve: Curves.easeIn,
              alignment: widget.enabled ? Alignment.topRight : Alignment.topLeft,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.maxWidth / 2.0,
                    child: Container(
                      padding: const EdgeInsets.all(1.0),
                      height: 38.0,
                      decoration: const BoxDecoration(
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
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      'ЧОЛОВІК',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 18,
                            color: widget.enabled ? const Color(0xcc000000) : const Color(0xFFDBDBDB),
                          ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'ЖІНКА',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 18,
                            color: widget.enabled ? const Color(0xFFDBDBDB) : const Color(0xcc000000),
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
