import 'package:creator_connect/common/widgets/navbar_main.dart';
import 'package:creator_connect/features/auth/screens/signIn/screens/signin_screen.dart';
import 'package:creator_connect/features/auth/services/auth%20bloc/auth_bloc.dart';
import 'package:creator_connect/features/home/screens/collaboration_subpage.dart';
import 'package:creator_connect/features/home/widgets/analytics_card.dart';
// import 'package:creator_connect/features/auth/services/auth%20bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/services/auth bloc/auth_state.dart';
import '../widgets/collaboration_card.dart';

class HomeScreenBusiness extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreenBusiness({super.key});

  @override
  State<HomeScreenBusiness> createState() => _HomeScreenBusinessState();
}

class _HomeScreenBusinessState extends State<HomeScreenBusiness> {
  final PageController controller = PageController(initialPage: 0);
  int _currentPage = 0;
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;
  int totalDummyPages = 5;
  Widget _indicator(bool isActive, int ind, int n) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0),
      child: Row(
        children: [
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            height: 20.0,
            alignment: Alignment.center,
            width: 20,
            decoration: BoxDecoration(
              color: isActive ? Colors.black : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(60),
            ),
            child: Text(
              (ind + 1).toString(),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black45,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          ind == n - 1
              ? Container()
              : Container(
                  height: 2,
                  width: 20,
                  color: Colors.grey.shade300,
                ),
        ],
      ),
    );
  }

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone) {
    if (isMarkedAsDone ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Marked as done!'),
      ));
    }
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    int n = totalDummyPages;
    for (int i = 0; i < n; i++) {
      list.add(
          i == _currentPage ? _indicator(true, i, n) : _indicator(false, i, n));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const NavBarHome(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false,
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome 👋🏻',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const Text(
                    'Anytime Fitness',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.023,
                  ),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // add elevation to container
                        AnalyticsCard(
                            heading: "Views",
                            bottomText: "2.5M Views",
                            icon: Icons.remove_red_eye_sharp),
                        AnalyticsCard(
                          heading: "ROI",
                          bottomText: "2.5M Views",
                          icon: Icons.grain_sharp,
                        ),
                        AnalyticsCard(
                            heading: "Views",
                            bottomText: "2.5M Views",
                            icon: Icons.remove_red_eye_sharp),
                        AnalyticsCard(
                          heading: "ROI",
                          bottomText: "2.5M Views",
                          icon: Icons.grain_sharp,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'OnGoing Collabs',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 26,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.2,
                            ),
                            const Text(
                              'Swipe',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_right_alt_rounded,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.001,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: _buildPageIndicator(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.18,
                    child: PageView(
                      controller: controller,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        for (var i = 0; i < totalDummyPages; i++)
                          _OpenContainerWrapper(
                            transitionType: _transitionType,
                            closedBuilder:
                                (BuildContext _, VoidCallback openContainer) {
                              return CollaborationCard(
                                  openContainer: openContainer);
                            },
                            onClosed: _showMarkedAsDoneSnackbar,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return const CollaborationSubPage();
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}

class SwipableSection extends StatelessWidget {
  final List<CollaborationCard> collaborationCards;

  SwipableSection({required this.collaborationCards});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        padding: EdgeInsets.only(left: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: collaborationCards.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: screenWidth - 32.0,
            child: collaborationCards[index],
          );
        },
      ),
    );
  }
}
