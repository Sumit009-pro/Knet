import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:knet/provider/subscription_provider.dart';
import 'package:provider/provider.dart';


class Payment extends StatefulWidget {
  final amount;
  const Payment({Key key, this.amount}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  var _subscription;

  @override
  void initState() {
    super.initState();
    setState(() {
      _subscription = Provider.of<SubscriptionProvider>(context, listen: false);
    });
    callMakePayment();
  }

  callMakePayment()async{
    await makePayment();
  }

  Map<String, dynamic> paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFA23FA2),
        title: Text('Stripe Payment'),
      ),
      body: Center(
        child: InkWell(
          onTap: ()async{
            await makePayment();
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.07,
            width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Color(0xFFA23FA2),
                borderRadius: BorderRadius.circular(30)
            ),
            child: Center(
              child: Text('Proceed to Pay: £${widget.amount}' , style: TextStyle(color: Colors.white , fontSize: 20),),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {

      paymentIntentData =
      await createPaymentIntent(widget.amount, 'GBP'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(primaryButtonColor: Color(0xFFA23FA2),
              paymentIntentClientSecret: paymentIntentData['client_secret'],
              applePay: true,
              googlePay: true,
              testEnv: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'GBP',
              merchantDisplayName: 'KNET')).then((value){
      });


      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {

    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
            clientSecret: paymentIntentData['client_secret'],
            confirmPayment: true,
          )).then((newValue){


        print('payment intent'+paymentIntentData['id'].toString());
        print('payment intent'+paymentIntentData['client_secret'].toString());
        print('payment intent'+paymentIntentData['amount'].toString());
        print('payment intent'+paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));
        Future.delayed(Duration.zero, () {
          this.hitpostAddSubscription();
        });
        paymentIntentData = null;

      }).onError((error, stackTrace){
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });


    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(widget.amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
            'Bearer sk_test_51JzLtLH2QgrbE84tILAOwdyitpoKSn92Oags5VnycfcWYmmUqCzIIzowdKlGp3BVkhgof5ALqD8hV7xWq9sKcFjl00ADiZi1GH',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100 ;
    return a.toString();
  }

  hitpostAddSubscription() {
    _subscription.postSubscription(context);
  }

}