import 'dart:convert';
import 'dart:ffi';

// ignore: import_of_legacy_library_into_null_safe
import 'package:admob_flutter/admob_flutter.dart';
import 'package:covid_tracker_app/admob_service.dart';
import 'package:covid_tracker_app/datascore.dart';
import 'package:covid_tracker_app/pages/countryPage.dart';
import 'package:covid_tracker_app/panels/infoPanel.dart';
import 'package:covid_tracker_app/panels/mosteffectedcountries.dart';
import 'package:covid_tracker_app/panels/worldwidepanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_native_admob/flutter_native_admob.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_native_admob/native_admob_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AdmobService? admob = AdmobService();

  Widget _buildPieChart() {
    return PieChart(
      dataMap: {
        'Confirmed': worldData['cases']?.toDouble() ?? 0.0,
        'Active': worldData['active']?.toDouble() ?? 0.0,
        'Recovered': worldData['recovered']?.toDouble() ?? 0.0,
        'Deaths': worldData['deaths']?.toDouble() ?? 0.0,
      },
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 60,
      chartRadius: MediaQuery.of(context).size.width / 2.0,
      colorList: [
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.grey,
      ],
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      ringStrokeWidth: 32,
      centerText: "COVID-19",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }

  late Map worldData = Map();
  fetchWorldWideData() async {
    http.Response response =
        await http.get(Uri.parse('https://corona.lmao.ninja/v2/all'));
    setState(() {
      worldData = jsonDecode(response.body);
    });
  }

  List? countryData;
  fetchCountryData() async {
    http.Response response = await http
        .get(Uri.parse('https://corona.lmao.ninja/v2/countries?sort=cases'));
    setState(() {
      countryData = jsonDecode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldWideData();
    fetchCountryData();
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.lightbulb_outline
                  : Icons.highlight,
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          "COVID-19 TRACKER",
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                height: 100,
                color: Colors.orange[100],
                child: Text(
                  DataSource.quote,
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "World Wide",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CountryPage()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Regional",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // ignore: unnecessary_null_comparison
              worldData == null
                  ? CircularProgressIndicator()
                  : WorldWidePanel(
                      worldData: worldData,
                    ),
              _buildPieChart(),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Text(
                  "Most Effected Countries",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              countryData == null
                  ? Container()
                  : MostEffectedCountries(
                      countryData: countryData,
                    ),
              Container(
                height: 60,
                width: double.infinity,
                child: AdmobBanner(
                  adUnitId: admob!.getBannerAdUnitId(),
                  adSize: AdmobBannerSize.BANNER,
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                  child: InfoPanel()),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Text(
                "WE ARE TOGETHER IN THE FIGHT",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )),
              SizedBox(
                height: 30,
              ),

              // Container(
              //   color: Colors.greenAccent,
              //   height: 200,
              //   width: double.infinity,
              //   child: NativeAdmob(
              //     adUnitID: 'ca-app-pub-3940256099942544/8135179316',
              //     numberAds: 3,
              //     controller: NativeAdmobController(),
              //     type: NativeAdmobType.full,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
