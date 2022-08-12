import 'package:flutter/material.dart';
import 'package:gym_go/module/training_details/training_details.dart';

class TrainingItem extends StatelessWidget {
  const TrainingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (context) => const TrainingDetails(),
          ),
        );
      },
      child: Container(
        height: 120,
        width: 120,
        color: Colors.black,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  children: const <Widget>[
                    Text(
                      'Text',
                      style: TextStyle(
                        fontSize: 38,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '#masa, sicbierbfo hifwer fuie fiure uhfr ui nui gnie rngi uiern gieru',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // fontSize: 38,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 38,
            ),
            const SizedBox(width: 15)
          ],
        ),
      ),
    );
  }
}
