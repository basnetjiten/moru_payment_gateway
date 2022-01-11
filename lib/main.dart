import 'package:flutter/material.dart';
import 'package:moru_payment_gateway/moru_payment_gateway.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moru Payment Gateway',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //access key
  final String accessKey =
      'test_760d2f08a3c64ff18b8b94978b28ac9e1b966c00bcc742a88f4deb8435409b2d';
  //paying amount
  double amount=1.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moru Payment Gateway'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 100,
                filterQuality: FilterQuality.high,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                color: Colors.grey[200],
                child: Center(
                    child: Text(
                  "Total Amount: Rs.$amount",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                )),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Color(0xffC91F3D),
                textColor: Colors.black,
                minWidth: MediaQuery.of(context).size.width,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                height: 48,
                highlightColor: Colors.white30,
                elevation: 0,
                highlightElevation: 0,
                onPressed: () {
                  final Widget paymentWidget = MoruPaymentSDK.builder(
                          accessKey: accessKey, amount: amount)
                      .withAdditionalData(additionalData: {'daraz': 'ITEM-44'})
                      .withProductIdentifier(identifier: 'snap-dragon')
                      .build()
                      .launch(checkoutListener: (checkoutStatus,  status) {
                        //check the CheckoutStatus []
                        print("${checkoutStatus}");
                        print("${status.accessData!.moruTxnIdentifier!}");
                      });
print("test");
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => paymentWidget));
                },
                padding: EdgeInsets.all(12),
                child: Text(
                  "BUY NOW",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
