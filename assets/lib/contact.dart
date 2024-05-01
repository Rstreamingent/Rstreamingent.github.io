import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = "";
  String _phoneNumber = "";
  String _emailAddress = "";
  String _inquiry = '';

  late String _selectedInquiry = '';

  final List<String> _inquiryOptions = [
    "I have a question about your product",
    "I would like to report a bug",
    "I have a suggestion for improvement",
    "Other",
  ];

  final List<SocialMediaLink> _socialMediaLinks = [
    SocialMediaLink(
      title: "Facebook",
      icon: "assets/icons/facebook.png",
      url: 'https://www.facebook.com/rstreamingent/',
    ),
    SocialMediaLink(
      title: "Instagram",
      icon: "assets/icons/instagram.png",
      url: 'https://www.instagram.com/rstreamingent/',
    ),
    SocialMediaLink(
      title: "X/Twitter",
      icon: "assets/icons/twitter.png",
      url: 'https://twitter.com/rstreamingent',
    ),
    SocialMediaLink(
      title: "Thread",
      icon: "assets/icons/threads.png",
      url: 'https://www.threads.net/@rstreamingent',
    ),
    SocialMediaLink(
      title: "LinkedIn",
      icon: "assets/icons/linkedin.png",
      url: 'https://www.linkedin.com/company/rstreamingent/',
    ),
    SocialMediaLink(
      title: "WhatsApp",
      icon: "assets/icons/whatsapp.png",
      url: 'https://wa.me/917028010560',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedInquiry = _inquiryOptions.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 7, bottom: 10),
              child: Column(
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
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150, // Maximum width of each tile
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: _socialMediaLinks.length,
                itemBuilder: (context, index) {
                  final link = _socialMediaLinks[index];
                  return Link(
                    uri: Uri.parse(link.url),
                    target: LinkTarget.defaultTarget,
                    builder: (context, openLink) => ElevatedButton(
                      onPressed: openLink,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            link.icon,
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            link.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: Colors.amber,
                        padding: EdgeInsets.all(16.0),
                      ),
                    ),
                  );
                },
              ),
                  SizedBox(height: 20,),
                  Divider(
                    height: 2,
                  ),
                  SizedBox(height: 20,),
                  // Rest of the code remains the same
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "NEED HELP?",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            "Contact Us Below",
                            style:
                            TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            "We're Available From: Mon-Sat (excluding public holidays)",
                            style:
                            TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            "Time: 9am - 7pm",
                            style:
                            TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Your Full Name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                setState(() => _fullName = value!),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Your Phone Number",
                              fillColor: Colors.grey,
                              focusColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                setState(() => _phoneNumber = value!),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Your Email",
                              focusColor: Colors.white,
                            ),
                            cursorColor: Colors.white,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                setState(() => _emailAddress = value!),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 16.0),
                          DropdownButtonFormField(
                            dropdownColor: Colors.grey,
                            value: _selectedInquiry,
                            items: _inquiryOptions
                                .map((inquiry) => DropdownMenuItem(
                              value: inquiry,
                              child: Text(
                                inquiry,
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  color: Colors.white,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (value) => setState(
                                    () => _selectedInquiry = value as String),
                            decoration: InputDecoration(
                              labelText: "Select why you want to contact us",
                            ),
                          ),
                          SizedBox(height: 24.0),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  // Handle form submission
                                }
                              },
                              child: Text(
                                'SUBMIT',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 16),
                                textStyle: TextStyle(fontSize: 18),
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaLink {
  final String title;
  final String icon;
  final String url;

  SocialMediaLink({
    required this.title,
    required this.icon,
    required this.url,
  });
}
