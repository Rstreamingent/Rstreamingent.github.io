import 'package:flutter/material.dart';

class aboutus extends StatefulWidget {
  const aboutus({Key? key}) : super(key: key);

  @override
  State<aboutus> createState() => _aboutusState();
}

class _aboutusState extends State<aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
        Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/icons/R-streaming-TEXT-logo.png',
              height: 50,
            ),
            Text(
              "Thank you for joining R STREAMING entertainment:",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Divider(
          color: Colors.grey,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              """R STREAMING हे एक  OTT प्लॅटफॉर्म आहे जे खान्देशी बोलीभाषांमध्ये CONTENT तयार करते. 

खान्देशामधे एक आगळा वेगळा मनोरंजनात्मक अनुभव देणे हे आमचे काम आहे. आम्हाला वाटते की डिजीटल स्ट्रीमिंगच्या सामर्थ्याने खान्देशची संस्कृती, भाषा आणि कथा मना मनात रुजायला मदत होऊ शकते. आमचे व्यासपीठ केवळ सामग्री पाहण्यापुरते नाही तर खान्देशी संस्कृतीला आणि त्यांच्या हाकेला एक व्यासपीठ उपलब्ध करुन देणे हे सुद्धा आहे. या प्रवासात आमच्यासोबत सामील व्हा कारण आम्ही खान्देशचे हृदय आणि आत्मा सर्वत्र स्क्रीनवर आणत आहोत. 

""",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              """MISSION VALUES 
""",
              style: TextStyle(
                fontSize: 20,
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              """R STREAMING ह्या OTT प्लॅटफॉर्मद्वारे, आम्ही चित्रपट उद्योगात काम करु इच्छिणाऱ्या खान्देशी तरुणांना एक व्यासपीठ उपलब्ध करून देऊ इच्छितो. ज्यामुळे त्यांना आपल्याच भागात काम करता येऊ शकेल.
""",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(
              height: 50,
            ),

            SizedBox(
              height: 50,
            ),
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  """WE ARE NATION THOUGHT. \n खान्देश आम्हन तन, मन, धन. """,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    ]
    )
        )

    ); }
}
