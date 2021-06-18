import 'package:flutter/material.dart';

class MostEffectedCountries extends StatelessWidget {

  final List? countryData;
  const MostEffectedCountries({this.countryData});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
            child: Row(
              children: [
                Image.network(countryData![index]["countryInfo"]["flag"], height: 25,),
                SizedBox(width: 10,),
                Text(countryData![index]["country"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                SizedBox(width: 10,),
                Text("Deaths: " + countryData![index]["deaths"].toString(), style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),)
              ],
            ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
