import 'package:flutter/material.dart';

class _InkWellOverlay extends StatelessWidget {
  const _InkWellOverlay({
    this.openContainer,
    this.height,
    this.child,
  });

  final VoidCallback? openContainer;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: InkWell(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}

class CollaborationCard extends StatelessWidget {
  final VoidCallback openContainer;
  const CollaborationCard({
    super.key,
    required this.openContainer,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _InkWellOverlay(
      openContainer: openContainer,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                // Colors.lightBlue.withOpacity(0.1),
                Colors.grey.shade100
              ]),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.6,
                  child: const Text(
                    'Talk on Revolution of AI in fitness industry',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: size.height * 00.005,
                ),
                SizedBox(
                  width: size.width * 0.6,
                  child: Text(
                    'Sam Altman will talk about this this this .Why did AI boom?',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: size.height * 00.01,
                ),
                SizedBox(
                  width: size.width * 0.6,
                  child: Text(
                    'Creator Name : Parth Mahajan',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.6,
                  child: Text(
                    'Creator ID : @parthworcester',
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: size.height * 00.005,
                ),
                SizedBox(
                  width: size.width * 0.6,
                  child: Text(
                    'Project State : Ideating',
                    style: TextStyle(
                      color: Colors.red[600],
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: size.height * 00.003,
                ),
                SizedBox(
                  width: size.width * 0.6,
                  child: Text(
                    'Start Date : 11 Dec,2022',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8.0,
                top: 8,
                bottom: 8,
              ),
              child: Container(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    "https://images.unsplash.com/photo-1544750040-4ea9b8a27d38?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1674&q=80",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
