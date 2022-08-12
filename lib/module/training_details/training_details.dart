import 'package:flutter/material.dart';
import 'package:gym_go/module/home/components/training_item.dart';

class TrainingDetails extends StatefulWidget {
  const TrainingDetails({super.key});

  @override
  State<TrainingDetails> createState() => _TrainingDetailsState();
}

class _TrainingDetailsState extends State<TrainingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('LOGO'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        children: const <Widget>[
          TrainingItem(),
          Center(
            child: Text(
              'TEXT',
              style: TextStyle(
                fontSize: 23,
              ),
            ),
          ),
          Text(
            'yh oruth ewrgoirhe gerihg h guier hgiuegihewiog  gwheuri hh bi bufytgu ugtyftyf tyfcruduyfyt tgfyfkfu fufufoutful futfutfulfuf ful,gfuyglvfuyyh gyuglhyug bgggiuy ngnk mljkh fy k fgvhbjnlkm; dftgvhb vghbj uhlb jinkminjkml jinkml jnhk yvu trcewrx ub brtbt ytdtc vb ygfgefg ewhfkkbemf,,fhadskbfmdsb  vjkdajvkbdahjvbkjdanvjk nivhafj nerierhfui hearf hhfiosafsdiaojpf urfh uawefkewbnfui hwejfwej jiu hewjwajfu aew fjewinfuiaweh fiufhnewuafhuiewahfaewnflaehf uasnf hawe fhuwen fwhlifhiwqeqnf kweeiufh ewiuwehefuiewnfoweqiufosjf hauieh fh78ewyfdhuiwae jabifgewayjb fkwaeuhf ioewhabj fkgewauif ghlkaewjgf uyaewgjkfbaew jkuf gkjaewbfyuia gewwkjfnkerur gkjaerkg fjewbafjkhegarif j berjk huieawebkjfbeae fbaewgrfhjaewbfjk.earglkfg kreugf raehbfk lrege uierbaifgyaewbf,kdshifgskjfbge rufue erifbnaewkfhuaeriuw breu gerha rg uierahgfu healu',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
