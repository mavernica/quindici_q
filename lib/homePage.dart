import 'package:flutter/material.dart';
import 'package:quindici_q/styleguide.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'secondPage.dart';
import 'homePageBackground.dart';
import 'myAppBar.dart';
import 'myDrawer.dart';
import 'modeClass.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
                  "15Q",
                  style: applicationNameTextStyle,
                  textAlign: TextAlign.center,
                )),
                const Center(
                  //distanza orizzontale degli ogetti sotto
                  child: Text(
                    'indovina chi sono',
                    style: applicationSubNameTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, top: 5),
                  height: 350, //dimensione del container che ospita le card
                  child: Swiper(
                    physics: NeverScrollableScrollPhysics(),
                    viewportFraction: 0.10,
                    scale: 0.9,
                    loop: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: modeList.length,
                    itemWidth: MediaQuery.of(context).size.width - 4 * 25,
                    layout: SwiperLayout.STACK,
                    pagination: null,
                    itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, a, b) => SecondPage(
                                  singleCard: modeList[index],
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
                                          80), //spazia le carte dalla dall'inizio del container
                                  Card(
                                    elevation: 5, //ombra
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
                                              height: 50), //altezza Card
                                          Text(
                                            modeList[index].title,
                                            style: categoriesTitleTextStyle,
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(height: 2,),
                                          Text(
                                            modeList[index].subTitle,
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
                                tag: modeList[index].title.toString(),
                                child: Image.asset(
                                  modeList[index].iconImage,
                                  height: 210,
                                  width: 250,
                                ),
                              ),
                              Positioned(
                                right: 30,
                                bottom: 5,
                                child: Text(
                                  modeList[index].position.toString(),
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
          ))
        ]));
  }
}
