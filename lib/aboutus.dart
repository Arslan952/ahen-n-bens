import 'package:flutter/material.dart';
class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/image/image2.png'
                ),
              )),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.50,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.35),
          child: Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 20, left: 40, right: 40),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('About Us', style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 23),),
                Text('Hen n Bun is one of the most famous fast food place you canget'
                    'word class Broast.We have shared complete Hen NBun Menu with price for those'
                    'who are looking for home develry or take away. This Place is also open for'
                    'for dine-in. At this place you will get special deal and discount'
                    'on their entire menu that you can check on our application.',textAlign: TextAlign.justify,
                style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
              ],
            ),
          )
        )
      ],
    );
  }
}
