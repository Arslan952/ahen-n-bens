import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hensbuns/detailscreen.dart';
import 'package:hensbuns/fooddata.dart';
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 22,top: 22),
          child: Text("Let\'s eat \n Quality Food 😋",style: GoogleFonts.lobster(
              fontSize: 32,
              fontWeight: FontWeight.bold
          ),),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22,top: 22),
          child: Row(children: [
            Expanded(child: TextField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  hintText: "Search",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide()
                  )
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(right: 22,left: 15),
              child: Card(
                color: const Color(0xffffc416),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: const Color(0xffffc416),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    FontAwesomeIcons.search,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            )
          ],),
        ),
        Padding(padding: const EdgeInsets.only(top: 22,right: 22,left: 22),
          child: Container(height: 60,
            child:  ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:Food.listOfFood.length,
                itemBuilder:(context,index){
                  return GestureDetector(
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c){
                        return DetailScreen(food: Food.listOfFood[index]);
                      }));
                    },
                    child: SizedBox(
                      width: 130,
                      child: Card(
                        elevation: 10,
                        color: const Color(0xffffc416),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3,right: 3),
                          child: Row(children: [
                            Image.asset(Food.listOfFood[index].image,height: 35,width: 35,),
                             Flexible(child: Text(Food.listOfFood[index].name,overflow: TextOverflow.ellipsis,))
                          ],),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
        Padding(padding: const EdgeInsets.only(top: 22,right: 35,left: 35),
          child: Container(height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Food.listOfFood.length,
                itemBuilder:(context,index){
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (c){
                        return DetailScreen(food: Food.listOfFood[index]);
                      }));
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Card(
                        elevation: 5,
                        shadowColor: const Color(0xffffc416),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(Food.listOfFood[index].image,height: 150,width: 150,),
                            Text(Food.listOfFood[index].name,style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 23
                            ),),
                            Text(Food.listOfFood[index].Description1,style: const TextStyle(color: Colors.black26),),
                            Text("🔥" + Food.listOfFood[index].calaries,style: const TextStyle(
                                color: Colors.red
                            ),),
                            Text("\$" +Food.listOfFood[index].price.toString(),style: const TextStyle(
                                fontSize: 22,fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );;
  }
}

