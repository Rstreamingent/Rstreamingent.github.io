

import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/icons/R-streaming-TEXT-logo.png',
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
                Divider(height: 2,),
                SizedBox(height: 10,)
              ],

            ),

            Text(
              'आर स्ट्रीमिंग मोबाइल अ‍ॅपलिकेशनसाठी गोपनीयता धोरण\n\n',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold , color: Colors.white),
            ),
            Text(
              'आर स्ट्रीमिंग मोबाइल अ‍ॅपलिकेशनसाठी गोपनीयता धोरण: आपले वाचक आणि वापरकर्ते, या गोपनीयता धोरणातील माहितीचे पालन करून, आपले आणि आपले वापरकर्ते आपल्या गोपनीयतेची खात्री करू शकता. आपल्या गोपनीयतेची आपल्या सुरक्षेसाठी आम्हाला महत्त्वाची आहे आणि आम्ही आपली गोपनीयतेचे आणि डेटाचे संरक्षण करण्यात आपल्या सुरक्षितीची काळजी घेतली आहे. माहिती जुळवणारी संबंधित केलेल्या वैयक्तिक आणि वापर आकड्यांसह, आपली माहिती वैयक्तिकृत करण्यासाठी, संवाद साधण्यासाठी वापरली जाते. आपली गोपनीयता धोरणातील कोणत्याही बदलांसाठी आम्ही सूचित करू शकतो आणि आपल्या प्रश्नांसाठी आपले संपर्क करू शकतो:',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ],
        ),
      ),

    );
  }
}
