// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:knet/screen/rating_review/rate_comment_page.dart';
// import 'package:knet/screen/rating_review/rate_dialog_page.dart';
// import 'package:knet/screen/rating_review/rate_info_page.dart';
// import 'package:knet/screen/rating_review/rate_stars_page.dart';
// import 'package:knet/widget/rating/tabbar_widget.dart';
// import 'package:rate_my_app/rate_my_app.dart';
//
// import '../main.dart';
//
// class RatingReviewScreen extends StatefulWidget {
//   final RateMyApp rateMyApp;
//
//   const RatingReviewScreen({
//     Key key,
//     @required this.rateMyApp,
//   }) : super(key: key);
//   @override
//   _RatingReviewScreenState createState() => _RatingReviewScreenState();
// }
//
// class _RatingReviewScreenState extends State<RatingReviewScreen> {
//   @override
//   Widget build(BuildContext context) => TabBarWidget(
//     title: 'Rating',
//     tabs: [
//       Tab(icon: Icon(Icons.open_in_full), text: 'Dialog'),
//       Tab(icon: Icon(Icons.rate_review), text: 'Comment'),
//       Tab(icon: Icon(Icons.star_rate_sharp), text: 'Stars'),
//       Tab(icon: Icon(Icons.info_outline_rounded), text: 'Info'),
//     ],
//     children: [
//       RateDialogPage(rateMyApp: widget.rateMyApp),
//       RateCommentPage(rateMyApp: widget.rateMyApp),
//       RateStarsPage(rateMyApp: widget.rateMyApp),
//       RateInfoPage(rateMyApp: widget.rateMyApp),
//     ],
//   );
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knet/provider/user_provider.dart';
import 'package:knet/widget/ShimmerWidget.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';

class ShopScreen extends StatefulWidget {
  final RateMyApp rateMyApp;

  const ShopScreen({Key key, this.rateMyApp}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with WidgetsBindingObserver {
  // var _reviewDetails;
  var _user;
  String comment = '';

  @override
  void initState() {
    // TODO: implement initState
    triggerObservers();
    super.initState();
    _user = Provider.of<UserProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      this.hitpostallUserDetails();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void triggerObservers() {
    WidgetsBinding.instance.addObserver(this);
  }

  hitpostallUserDetails() async {
    await _user.allUserDetails(
      context,
    );
  }

  hitpostaddReview() async {
    await _user.addReview(
      context,
    );
  }

  hitpostdeleteReview(String _reviewID) async {
    await _user.deleteReview(context, _reviewID);
  }

  Widget _appBarView(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black54),
      backgroundColor: Colors.white,
      // Color(0xFF662D91),
      title: _title(context),
      elevation: 0,
      actions: <Widget>[],
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      child: Text(
        'Shop',
        style: TextStyle(
            fontSize: 18.0,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Color(0xFF0C5CCD),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBarView(context),
        body: Visibility(
          visible: false,
          child: SafeArea(
            child: Consumer<UserProvider>(
                builder: (context, allUserDetails, __) => allUserDetails
                        .isFetching
                    ? ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return buildShimmer();
                        })
                    : ListView.builder(
                        itemCount: allUserDetails
                            .getAllUserDetailsResponse()
                            .data
                            .length,
                        // (getAllAgentsRepo.allAgentResponseModel.responseData.length),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // var myInt = double.parse(
                          //   allUserDetails
                          //       .getAllUserDetailsResponse()
                          //       .data
                          //       .elementAt(index)
                          //       .rating,
                          // );
                          // assert(myInt is double);
                          // final items = List<String>;
                          final item = allUserDetails
                              .getAllUserDetailsResponse()
                              .data[index];
                          return Dismissible(
                            // secondaryBackground: slideLeftBackground(),
                            // Each Dismissible must contain a Key. Keys allow Flutter to
                            // uniquely identify widgets.
                            key: Key(item.id.toString()),
                            // Provide a function that tells the app
                            // what to do after an item has been swiped away.
                            // ignore: missing_return
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                final bool res = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Text(
                                            "Are you sure you want to delete?"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text(
                                              "Delete",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            onPressed: () {
                                              // TODO: Delete the item from DB etc..
                                              // setState(() {
                                              //   allUserDetails
                                              //       .getReviewDetailsResponse()
                                              //       .data
                                              //       .removeAt(index);
                                              // });
                                              // Navigator.of(context).pop();
                                              // Future.delayed(Duration.zero, () {
                                              //   this.hitpostdeleteReview(
                                              //       allUserDetails
                                              //           .getReviewDetailsResponse()
                                              //           .data
                                              //           .elementAt(index)
                                              //           .id
                                              //           .toString());
                                              // });
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                return res;
                              } else {
                                // TODO: Navigate to edit page;
                              }
                            },
                            onDismissed: (direction) {
                              // Remove the item from the data source.
                              // setState(() {
                              //   allUserDetails
                              //       .getReviewDetailsResponse()
                              //       .data
                              //       .removeAt(index);
                              // });

                              // Then show a snackbar.
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('$item dismissed')));
                            },
                            child: ListTile(
                              leading: Image.asset('assets/logo.png'),
                              title: Text(allUserDetails
                                  .getAllUserDetailsResponse()
                                  .data
                                  .elementAt(index)
                                  .name),
                              subtitle: Text(
                                  allUserDetails
                                              .getAllUserDetailsResponse()
                                              .data
                                              .elementAt(index)
                                              .description !=
                                          null
                                      ? allUserDetails
                                          .getAllUserDetailsResponse()
                                          .data
                                          .elementAt(index)
                                          .description
                                      : '',
                                  maxLines: 2),
                              trailing: Text(
                                  allUserDetails
                                      .getAllUserDetailsResponse()
                                      .data
                                      .elementAt(index)
                                      .mobile,
                                  maxLines: 1),
                            ),
                          );
                        })),
          ),
        ));
  }

  Widget buildShimmer() => ListTile(
      leading: ShimmerWidget.circular(
        width: 48,
        height: 48,
        shapeBorder:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),
      title: Align(
          alignment: Alignment.centerLeft,
          child: ShimmerWidget.rectangular(
            height: 16,
            width: MediaQuery.of(context).size.width * 0.3,
          )),
      subtitle: ShimmerWidget.rectangular(height: 14));
}
