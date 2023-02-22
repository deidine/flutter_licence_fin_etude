import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';


class ContactUss extends StatelessWidget {
  const ContactUss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: ContactUsBottomAppBar(
          companyName: 'Abhishek Doshi',
          textColor: Colors.white,
          backgroundColor: Colors.teal.shade300,
          email: 'adoshi26.ad@gmail.com',
          // textFont: 'Sail',
        ),
        backgroundColor: Colors.teal,
        body: ContactUs(
            cardColor: Colors.white,
            textColor: Colors.teal.shade900,
            logo: const AssetImage('images/cv.png'),
            email: 'adoshi26.ad@gmail.com',
            companyName: 'Abhishek Doshi',
            companyColor: Colors.teal.shade100,
            dividerThickness: 2,
            phoneNumber: '+917818044311',
            website: 'https://abhishekdoshi.godaddysites.com',
            githubUserName: 'AbhishekDoshi26',
            linkedinURL:
            'https://www.linkedin.com/in/abhishek-doshi-520983199/',
            tagLine: 'Flutter Developer',
            taglineColor: Colors.teal.shade100,
            twitterHandle: 'AbhishekDoshi26',
            instagram: '_abhishek_doshi',
            facebookHandle: '_abhishek_doshi'),
      ),
    );
  }
}