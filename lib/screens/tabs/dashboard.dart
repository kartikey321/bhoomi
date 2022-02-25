import 'package:bhoomi/DataModels/soil_data.dart';
import 'package:bhoomi/DataProviders/AppData.dart';
import 'package:bhoomi/HelperMethods/notification_helper.dart';
import 'package:bhoomi/screens/Notifications.dart';
import 'package:bhoomi/services/location_helper.dart';
import 'package:bhoomi/services/polygon_helper.dart';
import 'package:bhoomi/services/weather_api_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> months = [
    "JAN",
    "FEB",
    "MARCH",
    "APRIL",
    "MAY",
    "JUNE",
    "JULY",
    "AUG",
    "SEPT",
    "OCT",
    "NOV",
    "DEC"
  ];
  String name = "";
  DateTime datetime = DateTime.now();
  SoilData? soilData1 = SoilData(
      time: Timestamp.now(), temp_10cm: 0.0, moisture: 0.0, surface_temp: 0.0);
  @override
  void initState() {
    super.initState();
    SharedPreferences sharedPreferences =
        Provider.of<AppData>(context, listen: false).sharedPreferences!;
    name = Provider.of<AppData>(context, listen: false)
        .sharedPreferences!
        .getString("name")!;

    PolygonHelper.getSoilData("6217aa69390ec4c67c4dda4f").then((value) {
      setState(() {
        soilData1 = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => NotificationsScreen())));
              },
              icon: Icon(
                Icons.notifications,
                size: 25,
                color: Colors.red,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "${datetime.weekday}, ${datetime.day} ${months[datetime.month]}",
                            //'TUESDAY, 24 OCT',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          'Good Morning, ${name.substring(0, name.trim().indexOf(" "))}',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        )
                      ],
                    ),
                    CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://www.clipartmax.com/png/middle/364-3643767_about-brent-kovacs-user-profile-placeholder.png"))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                // Row(
                //   children: [
                //     Container(
                //       height: 35,
                //       width: 35,
                //       decoration: BoxDecoration(
                //         border: Border.all(color: Colors.grey[300]!, width: 3),
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       child: Icon(Icons.menu),
                //     ),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     Container(
                //       height: 35,
                //       width: 315,
                //       decoration: BoxDecoration(
                //         color: Colors.grey[300],
                //         borderRadius: BorderRadius.circular(15),
                //       ),
                //       child: Padding(
                //         padding: const EdgeInsets.only(left: 8.0),
                //         child: Row(
                //           children: [
                //             Icon(
                //               Icons.search,
                //               color: Colors.grey,
                //             ),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Text(
                //               'Search',
                //               style:
                //                   TextStyle(fontSize: 16, color: Colors.grey),
                //             ),
                //           ],
                //         ),
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
          ),
          //Center(child: Text('Dashboard')),
          // ElevatedButton(
          //     onPressed: () async {
          //       Position position = await LocationHelper.determinePosition();
          //       SharedPreferences sharedPreferences =
          //           await SharedPreferences.getInstance();

          //       PolygonHelper.getSoilData("6217aa69390ec4c67c4dda4f");
          //     },
          //     child: Text('Get location'))
          // CarouselSlider(
          //   options: CarouselOptions(height: 400.0),
          //   items: [1, 2, 3, 4, 5].map((i) {
          //     return Builder(
          //       builder: (BuildContext context) {
          //         return Container(
          //             width: MediaQuery.of(context).size.width,
          //             margin: EdgeInsets.symmetric(horizontal: 5.0),
          //             decoration: BoxDecoration(color: Colors.amber),
          //             child: Text(
          //               'text $i',
          //               style: TextStyle(fontSize: 16.0),
          //             ));
          //       },
          //     );
          //   }).toList(),
          // ),

          SizedBox(
            height: 50,
          ),

          Text(
            "Your Farm stats",
            style:
                GoogleFonts.poppins(fontSize: 21, fontWeight: FontWeight.bold),
          ),

          /// Chip(label: label)
        ],
      ),
    );
  }
}
