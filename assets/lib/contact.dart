import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String _fullName = "";
  String _phoneNumber = "";
  String _emailAddress = "";
  String _inquiry = '';
  String _comments = '';

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

  void _showMessage(String message, bool success) {
    showDialog(
      barrierDismissible: false,

      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(success ? 'Success' : 'Error', style: TextStyle(color: Colors.white),),
          content: Text(message ,style: TextStyle(color: Colors.white),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (success) {
                  _formKey.currentState!.reset();
                }
              },
              child: Text('OK',style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
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
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Comments',
                            ),
                            maxLines: null, // Allow multiple lines
                            keyboardType: TextInputType.multiline,
                            validator: (value) {
                              // Validation logic for comments (if needed)
                              return null;
                            },
                            onSaved: (value) => setState(() => _comments = value!),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 24.0),
                          Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  try {
                                    // Create a new document in the "help" collection
                                    await _firestore.collection('help').add({
                                      'fullName': _fullName,
                                      'phoneNumber': _phoneNumber,
                                      'emailAddress': _emailAddress,
                                      'inquiry': _selectedInquiry,
                                      'comments': _comments,
                                      'timestamp': FieldValue.serverTimestamp(), // Add the current server timestamp
                                    });

                                    // Show a success message
                                    _showMessage('Form submitted successfully!', true);
                                  } catch (e) {
                                    // Show an error message
                                    _showMessage('Error submitting form: $e', false);
                                  }
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
