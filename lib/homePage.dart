import 'package:flutter/material.dart';
import 'package:quindici_q/styleguide.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'categoryPage.dart';
import 'homePageBackground.dart';
import 'myAppBar.dart';
import 'myDrawer.dart';
import 'data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const MyAppBar(),
        drawer: MyDrawer(),
        body: Stack(children: <Widget>[
          const HomePageBackground(),
          SafeArea(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Center(
                    child: Text(
                  "18Questions",
                  style: applicationNameTextStyle,
                  textAlign: TextAlign.center,
                )),
                const Center(
                  //distanza orizzontale degli ogetti sotto
                  child: Text(
                    'scopri chi minchia sono',
                    style: applicationSubNameTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 18, top: 5),
                  height: 400, //dimensione del container che ospita le card
                  child: Swiper(
                    scrollDirection: Axis.horizontal,
                    itemCount: planets.length,
                    itemWidth: MediaQuery.of(context).size.width - 4 * 24,
                    layout: SwiperLayout.STACK,
                    pagination: const SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          activeSize: 10, space: 8), //puntini
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, a, b) => CategoryPage(
                                planetInfo: planets[index],
                                key: null,
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            ListView(
                              children: <Widget>[
                                const SizedBox(
                                    height:
                                        70), //spazia le carte dalla dall'inizio del container
                                Card(
                                  elevation: 10, //ombra
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(
                                            height: 60), //altezza Card
                                        Text(
                                          planets[index].name,
                                          style: categoriesTitleTextStyle,
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          planets[index].subName,
                                          style: categorySubTitleStyle,
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(height: 32),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Hero(
                              tag: planets[index].position,
                              child: Image.asset(
                                planets[index].iconImage,
                                height: 210,
                                width: 250,
                              ),
                            ),
                            Positioned(
                              right: 30,
                              bottom: 50,
                              child: Text(
                                planets[index].position.toString(),
                                style: bigNumberTextStyle,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
          )
        ]));
  }
}
