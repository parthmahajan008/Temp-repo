import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationComponent(index: 20, color: Colors.red.shade50),
              LoadingAnimationComponent(index: 18, color: Colors.red.shade100),
              const LoadingAnimationComponent(index: 16, color: Colors.black12),
              const LoadingAnimationComponent(index: 14, color: Colors.black26),
              const LoadingAnimationComponent(index: 12, color: Colors.black26),
              const LoadingAnimationComponent(index: 10, color: Colors.black38),
              const LoadingAnimationComponent(index: 8, color: Colors.black45),
              const LoadingAnimationComponent(index: 6, color: Colors.black54),
              const LoadingAnimationComponent(index: 4, color: Colors.black87),
              const LoadingAnimationComponent(index: 2, color: Colors.black),
              const LoadingAnimationComponent(index: 2, color: Colors.black),
              const LoadingAnimationComponent(index: 4, color: Colors.black87),
              const LoadingAnimationComponent(index: 6, color: Colors.black54),
              const LoadingAnimationComponent(index: 8, color: Colors.black45),
              const LoadingAnimationComponent(index: 10, color: Colors.black38),
              const LoadingAnimationComponent(index: 12, color: Colors.black26),
              const LoadingAnimationComponent(index: 14, color: Colors.black26),
              const LoadingAnimationComponent(index: 16, color: Colors.black12),
              LoadingAnimationComponent(index: 18, color: Colors.red.shade100),
              LoadingAnimationComponent(index: 20, color: Colors.red.shade50),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingAnimationComponent extends StatefulWidget {
  final int index;
  final Color color;
  const LoadingAnimationComponent(
      {super.key, required this.color, required this.index});

  @override
  State<LoadingAnimationComponent> createState() =>
      _LoadingAnimationComponentState();
}

class _LoadingAnimationComponentState extends State<LoadingAnimationComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    //ruin the animation by changing duration to 100 or 50 ms
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // todo experiment with other curves style
    _scaleAnimation = Tween<double>(begin: 2.0, end: 50.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    Future.delayed(
      Duration(milliseconds: widget.index * 80),
      () => _animationController.forward(),
    );

    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      } else if (_animationController.isDismissed) {
        _animationController.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Container(
            height: _scaleAnimation.value,
            width: 10,
            decoration: BoxDecoration(
                color: widget.color, borderRadius: BorderRadius.circular(5.0)),
          );
        });
  }
}
