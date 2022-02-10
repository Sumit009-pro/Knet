import 'package:flutter/material.dart';
import 'package:knet/entities/on_boarding_entity.dart';
import 'package:knet/screen/RegisterScreen.dart';
import 'package:knet/screen/SubscriptionPlanScreen.dart';
import 'package:knet/utils/StringUtils.dart';

import 'auth_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _onBoardingData = OnBoardingEntity.onBoardingData;
  int _currentPageIndex = 0;
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
        ],
      ),
      body: Stack(
        children: [
          // _pageViewBuilderWidget(),
          // SizedBox(height: 15,),
          _columnWidget(),
          // Visibility(
          //     visible:value,child: _columnWidget()),
          // HeaderWidget(),
        ],
      ),
    );
  }

  Widget _pageViewBuilderWidget() {
    return PageView.builder(
      itemCount: _onBoardingData.length,
      onPageChanged: (index) {
        setState(() {
          _currentPageIndex = index;
          if (index == 2) {
            value = true;
          } else {
            value = false;
          }
        });
      },
      itemBuilder: (ctx, index) {
        return index == 0
            ? Stack(
                fit: StackFit.passthrough,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          _onBoardingData[index].image,
                          fit: BoxFit.cover,
                        ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        // Image.asset(
                        //   _onBoardingData[index].image1,
                        //   fit: BoxFit.cover,
                        // ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          _onBoardingData[index].heading,
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Poppins",
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            _onBoardingData[index].description,
                            maxLines: 2,
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              color: parseHexColor('#6B6F78'),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Container(
                        //   // margin: EdgeInsets.only(left: 47, right: 47),
                        //   child: Text(
                        //     _onBoardingData[index].description,
                        //     overflow: TextOverflow.ellipsis,
                        //     textAlign: TextAlign.center,
                        //     // softWrap: true,
                        //     maxLines: 2,
                        //     style: TextStyle(
                        //       color: Colors.black54,
                        //
                        //       fontSize: 12.0,
                        //       // fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  // index == 3
                  //     ? Align(
                  //   alignment: Alignment.bottomCenter,
                  //       child: Container(
                  //   height: double.infinity,
                  //   child: Image.asset(
                  //       _onBoardingData[index].image2,
                  //       fit: BoxFit.cover,
                  //   ),
                  // ),
                  //     )
                  //     :
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //       child: Container(
                  //   margin: EdgeInsets.only(bottom: 60),
                  //   child: Image.asset(
                  //       _onBoardingData[index].image2,
                  //   ),
                  // ),
                  //     ),
                  index == 3
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    begin: Alignment(0.9, 0.0),
                                    end: Alignment(0.8, 0.4),
                                    /*stops: [
                            0.1,
                            0.9
                          ],*/
                                    tileMode: TileMode.clamp,
                                    colors: [
                                      Colors.black.withOpacity(.5),
                                      Colors.black.withOpacity(.1),
                                      Colors.black.withOpacity(.8),
                                    ])),
                          ),
                        )
                      : Container(),
                ],
              )
            : index == 1
                ? Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              _onBoardingData[index].image,
                              fit: BoxFit.cover,
                            ),
                            // SizedBox(
                            //   height: 30,
                            // ),
                            // Image.asset(
                            //   _onBoardingData[index].image1,
                            //   fit: BoxFit.cover,
                            // ),
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              _onBoardingData[index].heading,
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "Poppins",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text(
                                _onBoardingData[index].description,
                                maxLines: 2,
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                  color: parseHexColor('#6B6F78'),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            // Container(
                            //   // margin: EdgeInsets.only(left: 47, right: 47),
                            //   child: Text(
                            //     _onBoardingData[index].description,
                            //     overflow: TextOverflow.ellipsis,
                            //     textAlign: TextAlign.center,
                            //     // softWrap: true,
                            //     maxLines: 2,
                            //     style: TextStyle(
                            //       color: Colors.black54,
                            //
                            //       fontSize: 12.0,
                            //       // fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      // index == 3
                      //     ? Align(
                      //   alignment: Alignment.bottomCenter,
                      //       child: Container(
                      //   height: double.infinity,
                      //   child: Image.asset(
                      //       _onBoardingData[index].image2,
                      //       fit: BoxFit.cover,
                      //   ),
                      // ),
                      //     )
                      //     :
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //       child: Container(
                      //   margin: EdgeInsets.only(bottom: 60),
                      //   child: Image.asset(
                      //       _onBoardingData[index].image2,
                      //   ),
                      // ),
                      //     ),
                      index == 3
                          ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        begin: Alignment(0.9, 0.0),
                                        end: Alignment(0.8, 0.4),
                                        /*stops: [
                            0.1,
                            0.9
                          ],*/
                                        tileMode: TileMode.clamp,
                                        colors: [
                                          Colors.black.withOpacity(.5),
                                          Colors.black.withOpacity(.1),
                                          Colors.black.withOpacity(.8),
                                        ])),
                              ),
                            )
                          : Container(),
                    ],
                  )
                : index == 2
                    ? Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 40, right: 40),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  _onBoardingData[index].image,
                                  fit: BoxFit.cover,
                                ),
                                // SizedBox(
                                //   height: 30,
                                // ),
                                // Image.asset(
                                //   _onBoardingData[index].image1,
                                //   fit: BoxFit.cover,
                                // ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  _onBoardingData[index].heading,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: "Poppins",
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: Text(
                                    _onBoardingData[index].description,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.0,
                                      color: parseHexColor('#6B6F78'),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          index == 3
                              ? Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                            begin: Alignment(0.9, 0.0),
                                            end: Alignment(0.8, 0.4),
                                            /*stops: [
                            0.1,
                            0.9
                          ],*/
                                            tileMode: TileMode.clamp,
                                            colors: [
                                              Colors.black.withOpacity(.5),
                                              Colors.black.withOpacity(.1),
                                              Colors.black.withOpacity(.8),
                                            ])),
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    : Container();
      },
    );
  }

  _createAccountView(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 8, top: 8),
      height: 25,
      child: FlatButton(
        // onPressed: () {
        //   // __pushTORegistrationScreen();
        // },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Already Have An Account?',
                style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    color: Color(0XFF767676))),
            SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    /* builder: (_) => ChooseYourPlanPage(),*/
                    builder: (_) => AuthScreen(true),
                  ),
                );
                // setState(() {
                //   _isLogin = !_isLogin;
                // });
              },
              child: Text('Sign In',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: "Roboto",
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: parseHexColor('#6B6F78'))),
            )
          ],
        ),
      ),
    );
  }

  Widget _columnWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: _pageViewBuilderWidget()),
        SizedBox(
          height: 24,
        ),
        Container(
          // margin: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _onBoardingData.map(
              (data) {
                //get index
                int index = _onBoardingData.indexOf(data);
                return Container(
                  height: 10,
                  width: 10,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: index == _currentPageIndex
                        ? parseHexColor(StringUtils.themeColor)
                        : Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                /* builder: (_) => ChooseYourPlanPage(),*/
                builder: (_) => RegisterScreen(),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(right: 40, left: 40, bottom: 16, top: 8),
            child: Container(
              // margin: EdgeInsets.only(bottom: 10, right: 15, left: 15),
              height: 50,
              // padding: EdgeInsets.all(8),
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFA23FA2),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        // color: Colors.white,
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  /* builder: (_) => ChooseYourPlanPage(),*/
                                  builder: (_) => AuthScreen(false),
                                ),
                              );
                            },
                            child: Text(
                              "New User? Sign Up",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Roboto",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        _createAccountView(context),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
