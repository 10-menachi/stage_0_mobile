import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final Color color;
  final bool isDone;

  const TodoCard({
    required this.title,
    required this.description,
    required this.time,
    required this.color,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDone ? 0.65 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 1.1,
                      fontWeight: FontWeight.w500,
                      decoration: isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: Colors.white60,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: isDone
                        ? Colors.white.withOpacity(0.35)
                        : Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isDone ? Icons.check : Icons.more_horiz,
                    color: Colors.white,
                    size: isDone ? 20 : 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 13,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 18,
                  color: Colors.white.withOpacity(0.95),
                ),
                const SizedBox(width: 6),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.95),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 64,
                  height: 32,
                  child: Stack(
                    children: List.generate(3, (index) {
                      return Positioned(
                        left: index * 18.0,
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            shape: BoxShape.circle,
                            border: Border.all(color: color, width: 2),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 16,
                            color: color.withOpacity(0.9),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
