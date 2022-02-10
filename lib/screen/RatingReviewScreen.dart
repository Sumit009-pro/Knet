
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knet/Network/Api/ApiHandler.dart';
import 'package:knet/provider/review_provider.dart';
import 'package:knet/widget/ShimmerWidget.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingReviewScreen extends StatefulWidget {
  final RateMyApp rateMyApp;

  const RatingReviewScreen({Key key, this.rateMyApp}) : super(key: key);
  @override
  _RatingReviewScreenState createState() => _RatingReviewScreenState();
}

class _RatingReviewScreenState extends State<RatingReviewScreen> with WidgetsBindingObserver {
  // var _reviewDetails;
  var _review;
  String comment = '';
  double rating = 5.0;

  @override
  void initState() {
    // TODO: implement initState
    triggerObservers();
    super.initState();
    _review = Provider.of<ReviewProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      this.hitpostreviewDetails();
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

  hitpostreviewDetails() async {
    await _review.reviewDetails(
      context,
    );
  }

  hitpostaddReview() async {
    await _review.addReview(
      context, comment, rating.toString()
    );
    //await ApiHandler.addRatingReview(context, comment, rating.toString());
  }

  hitpostdeleteReview(String _reviewID) async {
    await _review.deleteReview(context, _reviewID);
  }

  Widget buildComment(BuildContext context) => Container(
    height: MediaQuery.of(context).size.height * 0.3,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.02
          ),
          child: SmoothStarRating(
              allowHalfRating: true,
              onRated: (v) {
                setState(() {
                  rating = v;
                });
              },
              starCount: 5,
              rating: rating,
              size: MediaQuery.of(context).size.height * 0.06,
              isReadOnly: false,
              // fullRatedIconData: Icons.blur_off,
              // halfRatedIconData: Icons.blur_on,
              color: Color(0xFFA23FA2),
              borderColor: Color(0xFF662D91),
              spacing: 0.0),
        ),
        TextFormField(
              autofocus: true,
              onFieldSubmitted: (_) => Navigator.of(context).pop(),
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Write Comment...',
                border: OutlineInputBorder(),
              ),
              onChanged: (comment) => setState(() => this.comment = comment),
            ),
      ],
    ),
  );

  List<Widget> actionsBuilder(BuildContext context) =>
      [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04),
          child: GestureDetector(

            onTap: ()  {
              // ApiHandler.addRatingReview(context, comment, rating.toString());
              hitpostaddReview();
              Navigator.pop(context);
              hitpostreviewDetails();
            },
            child: Container(
                child: Text("Submit",
                  style: TextStyle(
                      color: Colors.purple
                  ),
                )
            ),
          ),
        ),
        GestureDetector(

          onTap: ()  {
            // ApiHandler.addRatingReview(context, comment, rating.toString());
            Navigator.pop(context);
          },
          child: Container(
              child: Text("Cancel",
                style: TextStyle(
                    color: Colors.purple
                ),
              )
          ),
        ),
        //buildOkButton(),
        //buildCancelButton()
      ];

  Widget buildOkButton() => RateMyAppRateButton(
        widget.rateMyApp,
        text: 'SEND',
        callback: () {
          Future.delayed(Duration.zero, () {
            this.hitpostaddReview();
          });
          // print('Comment: $comment');
        },
      );

  Widget buildCancelButton() => RateMyAppNoButton(
        widget.rateMyApp,
        text: 'CANCEL',
      );

  Widget _appBarView(BuildContext context) {
    return AppBar(
      //iconTheme: IconThemeData(color: Colors.black54),
      backgroundColor: Color(0xFFA23FA2),

      // Color(0xFF662D91),
      title: _title(context),
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            //color: Colors.black54,
          ),
          onPressed: () {
            widget.rateMyApp.showRateDialog(
              context,
              contentBuilder: (context, _) => buildComment(context),
              actionsBuilder: actionsBuilder,
              title: "Rate KNET"
            );
          },
        )
      ],
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      child: Text(
        'Rating & Reviews',
        style: TextStyle(
            fontSize: 18.0,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            //color: Colors.black
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
  final makeCard = Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.autorenew, color: Colors.white),
          ),
          title: Text(
            "Introduction to Driving",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Icon(Icons.linear_scale, color: Colors.yellowAccent),
              Text(" Intermediate", style: TextStyle(color: Colors.white))
            ],
          ),
          trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0))
    ),
  );


  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
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
      backgroundColor: Colors.white,
        appBar: _appBarView(context),
        body: SafeArea(
          child:
          Consumer<ReviewProvider>(
              builder: (context, reviewDetails, __) => reviewDetails.isFetching
                  ?
              ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return buildShimmer();
                      })
                  :
              ListView.builder(
                      itemCount:
                          reviewDetails.getReviewDetailsResponse().data.length,
                      // (getAllAgentsRepo.allAgentResponseModel.responseData.length),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var myInt = double.parse(
                          reviewDetails
                              .getReviewDetailsResponse()
                              .data
                              .elementAt(index)
                              .rating,
                        );
                        assert(myInt is double);
                        // final items = List<String>;
                        final item = reviewDetails
                            .getReviewDetailsResponse()
                            .data[index];
                        return
                          Dismissible(
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
                                    return
                                      AlertDialog(
                                      content: Text(
                                          "Are you sure you want to delete ${reviewDetails.getReviewDetailsResponse().data[index]}?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(color: Colors.purple),
                                          ),
                                          onPressed: () {
                                            // TODO: Delete the item from DB etc..
                                            setState(() {
                                              reviewDetails
                                                  .getReviewDetailsResponse()
                                                  .data
                                                  .removeAt(index);
                                            });
                                            Navigator.of(context).pop();
                                            Future.delayed(Duration.zero, () {
                                              print("Review ID From Screen : "+reviewDetails
                                                  .getReviewDetailsResponse()
                                                  .data
                                                  .elementAt(index)
                                                  .reviewId
                                                  .toString());
                                              this.hitpostdeleteReview(
                                                  reviewDetails
                                                      .getReviewDetailsResponse()
                                                      .data
                                                      .elementAt(index)
                                                      .reviewId
                                                      .toString());
                                            });
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
                            setState(() {
                              reviewDetails
                                  .getReviewDetailsResponse()
                                  .data
                                  .removeAt(index);
                            });

                            // Then show a snackbar.
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('$item dismissed')));
                          },
                          child:
                          // makeCard
                          Padding(
                            padding: const EdgeInsets.only(left:4.0,right:4.0),
                            child: Card(
                              elevation: 4.0,
                              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                              child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                  // leading: Image.asset('assets/logo.png'),
                                  leading:Container(
                                    padding: EdgeInsets.only(right: 12.0),
                                    decoration: new BoxDecoration(
                                        border: new Border(
                                            right: new BorderSide(width: 1.0, color: Colors.grey[200]))),
                                    child: Icon(Icons.repeat, color: Colors.grey),
                                  ),
                                  title: Text(reviewDetails
                                      .getReviewDetailsResponse()
                                      .data
                                      .elementAt(index).name
                                      ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SmoothStarRating(
                                          allowHalfRating: true,
                                          onRated: (v) {},
                                          starCount: 5,
                                          rating: myInt,
                                          size: 10.0,
                                          isReadOnly: true,
                                          // fullRatedIconData: Icons.blur_off,
                                          // halfRatedIconData: Icons.blur_on,
                                          color: Color(0xFFA23FA2),
                                          borderColor: Color(0xFF662D91),
                                          spacing: 0.0),
                                      Text(
                                          reviewDetails
                                              .getReviewDetailsResponse()
                                              .data
                                              .elementAt(index)
                                              .review,
                                          maxLines: 1),
                                      // Text(" Intermediate", style: TextStyle(color: Colors.white))
                                    ],
                                  ),

                                  // trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey[300], size: 30.0)
                              ),
                            ),
                          ),
                        );
                      })
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
