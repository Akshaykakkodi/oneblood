import 'package:flutter/material.dart';

class Privacy_policy_screen extends StatelessWidget {
  const Privacy_policy_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text('Privacy policy'),
      ),
      body: ListView(
        children: [
          Image.asset('Assets/images/privacy.jpg'),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('1 This document is an electronic record in terms of Information Technology Act, 2000 and rules there under as applicable and the amended provisions pertaining to electronic records in various statutes as amended by the Information Technology Act, 2000. This electronic record is generated by a computer system and does not require any physical or digital signature.'),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('2 This document is published in accordance with the provisions of Rule 3 (1) of the Information Technology (Intermediaries guidelines) Rules, 2011 that require publishing the rules and regulations, privacy policy and terms of use for access or usage of the domain name (“Website”) and the corresponding application (“Application”)'),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('3 By accessing the Website or Application, whether through a mobile device, mobile application or computer, the User agrees to be bound by the Terms of Use (Terms) and this Privacy Policy (Policy) whether or not the User creates an account to avail of the Service. If the User wishes to avail of the Service, the User does hereby unequivocally accept and agree to the contents of the Terms and Policy '),
          ),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('4 By using the Application and/ or by providing information to the Company through the Application, the User consents to the collection and use of the information disclosed by the User on the Application in accordance with this Policy, including but not limited to the Users consent to the Company/Application sharing/divulging the Users information, as per the terms contained herein. Please refer to Donor & Receiver Terms in addition to the Privacy policy for detailed understanding of the terms.'),
          )
        ],

      ),
    );
  }
}
