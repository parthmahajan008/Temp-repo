import 'package:creator_connect/features/auth/screens/signup/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class WelcomeAdvantages extends StatelessWidget {
  static const String routeName = '/welcome-advantages-screen';
  const WelcomeAdvantages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Welcome to CreaAD",
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.pushReplacementNamed(context, SignUpScreen.routeName),
        backgroundColor: Colors.black,
        label: const Text(
          'Get Started',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.games_outlined,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                  """Find the perfect creators for your business by selecting the skills and expertise you need. Choose from a variety of creators and resources to grow your business and increase your ROI."""),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            const AdvantageWithIcon(
              text: "Distance based Search",
              subtext: "Find Creators nearbuy",
              icon: Icons.search,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const AdvantageWithIcon(
              text: "Contract Management",
              subtext: "Manage your contracts with ease",
              icon: Icons.document_scanner,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const AdvantageWithIcon(
              text: "ROI Tracking ",
              subtext: "Track your return on investment with ease",
              icon: Icons.auto_graph_rounded,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            const AdvantageWithIcon(
              text: "Collaboration management",
              subtext: "Manage your collaborations with creators with ease",
              icon: Icons.person,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}

class AdvantageWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final String subtext;
  const AdvantageWithIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.subtext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    subtext,
                    overflow: TextOverflow.ellipsis,
                    // maxLines: 2,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
