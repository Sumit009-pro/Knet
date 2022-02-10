import 'package:flutter/material.dart';
import 'package:knet/provider/review_provider.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import '../../widget/rating/button_widget.dart';



class RateCommentPage extends StatefulWidget {
  final RateMyApp rateMyApp;

  const RateCommentPage({
    Key key,
    @required this.rateMyApp,
  }) : super(key: key);

  @override
  _RateCommentPageState createState() => _RateCommentPageState();
}

class _RateCommentPageState extends State<RateCommentPage> {
  String comment = '';
  var _review;

  @override
  void initState() {
    // TODO: implement initState
    _review = Provider.of<ReviewProvider>(context, listen: false);
    super.initState();
  }
  hitpostaddReview() async {
    await _review.addReview(context,);

  }
  @override
  Widget build(BuildContext context) =>

      Container(
        padding: EdgeInsets.all(48),
        child: Center(
          child: ButtonWidget(
            text: 'Rate App',
            onClicked: () => widget.rateMyApp.showRateDialog(
              context,
              contentBuilder: (context, _) => buildComment(context),
              actionsBuilder: actionsBuilder,
            ),
          ),
        ),
      );

  Widget buildComment(BuildContext context) => TextFormField(
        autofocus: true,
        onFieldSubmitted: (_) => Navigator.of(context).pop(),
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Write Comment...',
          border: OutlineInputBorder(),
        ),
        onChanged: (comment) => setState(() => this.comment = comment),
      );

  List<Widget> actionsBuilder(BuildContext context) =>
      [buildOkButton(), buildCancelButton()];

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
}
