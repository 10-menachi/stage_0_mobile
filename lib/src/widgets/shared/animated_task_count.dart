import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedTaskCount extends StatefulWidget {
  final int? count;
  final bool isLoading;

  const AnimatedTaskCount({
    super.key,
    required this.count,
    required this.isLoading,
  });

  const AnimatedTaskCount.loading({super.key}) : count = null, isLoading = true;

  @override
  State<AnimatedTaskCount> createState() => _AnimatedTaskCountState();
}

class _AnimatedTaskCountState extends State<AnimatedTaskCount> {
  Timer? _timer;
  final Random _random = Random();
  int _displayNumber = 0;

  @override
  void initState() {
    super.initState();
    _updateAnimation();
  }

  @override
  void didUpdateWidget(covariant AnimatedTaskCount oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateAnimation();
  }

  void _updateAnimation() {
    _timer?.cancel();

    if (widget.isLoading) {
      _timer = Timer.periodic(const Duration(milliseconds: 70), (_) {
        if (!mounted) return;

        setState(() {
          _displayNumber = _random.nextInt(20) + 1;
        });
      });
    } else {
      setState(() {
        _displayNumber = widget.count ?? 0;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'You Have $_displayNumber Tasks Today',
      style: const TextStyle(
        fontSize: 24,
        height: 1.05,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
