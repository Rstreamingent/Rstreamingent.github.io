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
            Text(
              """आमचे सहकारी
                      """,
              style: TextStyle(
                fontSize: 20,
                color: Colors.amber,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.justify,
            ),


          ],
        ),
      ),
            ResponsiveLayout(
              rowChildren: [
                MemberCard(
                  imagePath: 'assets/Posters/gauravNath.jpg',
                  name: 'नाथ गौरव पद्माकर',
                  designation: 'CEO, DIRECTOR',
                ),
                MemberCard(
                  imagePath: 'assets/Posters/adityaSharma.jpg',
                  name: 'अदित्य राजेश शर्मा',
                  designation: 'CTO, DIRECTOR',
                ),
                MemberCard(
                  imagePath: 'assets/Posters/pramod.jpg',
                  name: 'प्रमोद मनिलाल पाटील',
                  designation: 'FINANCIAL\n WORK',
                ),
                MemberCard(
                  imagePath: 'assets/Posters/adityaBirhade.jpg',
                  name: 'अदित्य दिनेश बिऱ्हाडे',
                  designation: 'CONTENT\nCREATOR',
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(0.5),
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
    );
  }
}

class MemberCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String designation;

  const MemberCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.designation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the corresponding member's page
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              switch (name) {
                case 'नाथ गौरव पद्माकर':
                  return GauravPage();
                case 'अदित्य राजेश शर्मा':
                  return AdityaSharmaPage();
                case 'प्रमोद मनिलाल पाटील':
                  return PramodPatilPage();
                case 'अदित्य दिनेश बिऱ्हाडे':
                  return AdityaBirhadePage();
                default:
                  return Container();
              }
            },
          ),
        );
      },
      child: Center(
        child: Card(
          color: Colors.grey[900],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 4,
                  width: 200,
                  child: Center(
                    child: Divider(
                      height: 2,
                    ),
                  ),
                ),
                Text(
                  designation,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  final List<Widget> rowChildren;

  const ResponsiveLayout({Key? key, required this.rowChildren})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: rowChildren,
          );
        } else {
          return Column(
            children: rowChildren
                .map((child) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: child,
            ))
                .toList(),
          );
        }
      },
    );
  }
}


class GauravPage extends StatelessWidget {
  const GauravPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nath Gaurav Padmakar",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "CEO, DIRECTOR",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Nath Gaurav Padmakar is the Chief managing director of R STREAMING. He is film writer, director and producer, his dynamism and high entrepreneurial skills are making a game changer in the Aahirani film industry.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
                Text(
                  "He is succesing his desire to carry the idea of Indian entertainment literature to global level by the R STREAMING OTT platform. He says proudly \"In a Film sector, The movies of Indian ideology should be made by which the golden history of India comes out. That is my sincere efforts for this.\" His ambitious",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
                Text(
                  "He worked as a writer and wrote many stories and screenplays. He worked as a part of many feature films, short films, documentary films and web series. He is a member of \"Bharatiya Chitra Sadhana and Devagiri Chitra Sadhana\", organizations working in the field of film. Through the platform of OTT, He wants to reach out to those young people who wants to work in the film industry but are unable to do so due to lack of opportunities. So he wants to provide opportunities to such young artists through R STREAMING, an OTT channel.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdityaSharmaPage extends StatelessWidget {
  const AdityaSharmaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Aditya Rajesh Sharma ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "CTO, DIRECTOR",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Aditya Rajesh Sharma is a Cheif Technology Officer of the R STREAMING. He is also a Director, his dynamism and high entrepreneurial skills are making a game changer in the Aahirani film industry.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
                Text(
                  "He is succesing his desire to carry the idea of Indian entertainment literature to global level by the R STREAMING OTT platform. He says proudly \"In a Film sector, The movies of Indian ideology should be made by which the golden history of India comes out. That is my sincere efforts for this.\" His ambitious",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
                Text(
                  "He worked as a writer and wrote many stories and screenplays. He worked as a part of many feature films, short films, documentary films and web series. He is a member of \"Bharatiya Chitra Sadhana and Devagiri Chitra Sadhana\", organizations working in the field of film. Through the platform of OTT, He wants to reach out to those young people who wants to work in the film industry but are unable to do so due to lack of opportunities. So he wants to provide opportunities to such young artists through R STREAMING, an OTT channel.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PramodPatilPage extends StatelessWidget {
  const PramodPatilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class AdityaBirhadePage extends StatelessWidget {
  const AdityaBirhadePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Aditya Dinesh Birhade",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Content Creator",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Aditya Dinesh Birhade serves as the Content Director at R Streaming, where he plays a pivotal role in shaping the platform's creative direction. With a diverse background encompassing film acting, writing, and directing, he brings a wealth of knowledge and skills to his position.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
                Text(
                  "Aditya is deeply passionate about promoting Indian cinema, leveraging its rich cultural heritage and history to showcase the essence of the nation. Rooted in the ethos of Bharata and Bharatiya Vichar (National Thought), he aims to highlight the depth and diversity of Indian storytelling through the R Streaming OTT Platform",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16),
                Text(
                  """His artistic journey includes performances in theatre dramas, skits, and short films, where he has not only showcased his acting prowess but also penned captivating stories and screenplays. Aditya's directorial ventures have earned him recognition, including certification for directing a short film at a remarkably young age.

Beyond his contributions to the entertainment industry, Aditya is also a proficient speaker and anchor, adept at engaging audiences with his charismatic presence. As a member of "Bhartiya Chitrasadhna" and "Devgiri Chitrasadhna," organizations dedicated to promoting films with a nationalistic perspective, he strives to unite the finest talents of India to present its rich heritage to the global stage.

Through the R Streaming OTT Platform, Aditya endeavors to fulfill his vision of promoting Rashtriya Vichar (National Thought), bringing together the core talent of Bharat to offer unparalleled storytelling experiences that resonate with audiences worldwide.""",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


