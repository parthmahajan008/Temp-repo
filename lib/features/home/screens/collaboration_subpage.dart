import 'package:flutter/material.dart';

class CollaborationSubPage extends StatefulWidget {
  static const String routeName = '/collab-subpage';
  const CollaborationSubPage({super.key});

  @override
  _CollaborationSubPageState createState() => _CollaborationSubPageState();
}

class _CollaborationSubPageState extends State<CollaborationSubPage> {
  final PageController controller = PageController(initialPage: 0);

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < projectData.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          height: 10.0,
          decoration: BoxDecoration(
            color: isActive ? Colors.black54 : Colors.grey.shade300,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ),
    );
  }

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                Colors.white,
                Colors.blue.withOpacity(0.2),
                // Colors.white,
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: controller,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        for (var project in projectData)
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  project.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  project.description,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProjectData {
  final String name;
  // final String imageUrl;
  final String description;

  ProjectData({
    required this.name,
    // required this.imageUrl,
    required this.description,
  });
}

final List<ProjectData> projectData = [
  ProjectData(
    name: 'Talk on Revolution of AI in fitness industry',
    // imageUrl:
    //     'https://images.unsplash.com/photo-1547499417-29204c97a299?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80',
    description: 'Sam Altman will talk about this this this .Why did AI boom?',
  ),
  ProjectData(
    name: 'Talk on Revolution of AI in fitness industry',
    // imageUrl:
    //     'https://images.unsplash.com/photo-1547499417-29204c97a299?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80',
    description: 'Sam Altman will talk about this this this .Why did AI boom?',
  ),
  ProjectData(
    name: 'Talk on Revolution of AI in fitness industry',
    // imageUrl:
    //     'https://images.unsplash.com/photo-1547499417-29204c97a299?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80',
    description: 'Sam Altman will talk about this this this .Why did AI boom?',
  ),
];
