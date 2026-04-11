import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stage_0_mobile/src/theme.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _filters = ['Today', 'Tomorrow', 'Upcoming'];
  int selectedFilterIndex = 0;

  final List<Map<String, dynamic>> todos = [
    {
      'title': 'Finish mobile dashboard UI',
      'description':
          'Polish the task cards and align spacing properly. Make sure everything is pixel-perfect before the design review.',
      'date': DateTime.now(),
      'startTime': '09:00 AM',
      'endTime': '10:30 AM',
      'priorityColor': const Color(0xFF7B6EF6),
      'category': 'Work',
      'done': false,
    },
    {
      'title': 'Prepare Flutter navigation refactor',
      'description':
          'Clean up the custom bottom navigation and reduce repetition. Extract reusable components.',
      'date': DateTime.now(),
      'startTime': '11:00 AM',
      'endTime': '12:00 PM',
      'priorityColor': const Color(0xFF2196F3),
      'category': 'Work',
      'done': false,
    },
    {
      'title': 'Write journal flow ideas',
      'description':
          'Draft how journaling and todos can work together in one app. Think about transitions and shared state.',
      'date': DateTime.now(),
      'startTime': '03:00 PM',
      'endTime': '04:00 PM',
      'priorityColor': const Color(0xFF10B981),
      'category': 'Personal',
      'done': true,
    },
  ];

  void _openCreateTodoModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _CreateTodoModal(),
    );
  }

  void _openTaskDetail(Map<String, dynamic> todo, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _TaskDetailModal(
        todo: todo,
        onToggleDone: () {
          setState(() {
            todos[index]['done'] = !(todos[index]['done'] as bool);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat(
      'EEEE, d MMM',
    ).format(DateTime.now());

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.backgroundColor,
      drawer: const _AppDrawer(),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Top bar ──
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: Container(
                      height: 46,
                      width: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.menu, size: 22),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _openCreateTodoModal,
                    icon: const Icon(Icons.add),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.tertiaryColor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                DateFormat('MMMM').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                formattedDate,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 8),
              Text(
                'You Have ${todos.length} Tasks Today',
                style: const TextStyle(
                  fontSize: 32,
                  height: 1.05,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 18),
              // ── Search ──
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.black12),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search task, project, etc...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // ── Filter chips ──
              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final bool isSelected = selectedFilterIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => selectedFilterIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.black12,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _filters[index],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),
              Text(
                "It's a good day to make progress on your tasks.",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),
              // ── Task list ──
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 120),
                  itemCount: todos.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return GestureDetector(
                      onTap: () => _openTaskDetail(todo, index),
                      child: _TodoCard(
                        title: todo['title'] as String,
                        description: todo['description'] as String,
                        time: '${todo['startTime']} - ${todo['endTime']}',
                        color: todo['priorityColor'] as Color,
                        isDone: todo['done'] as bool,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// DRAWER — no user/auth stuff
// ─────────────────────────────────────────────────────────────────────────────

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      child: Container(
        color: const Color(0xFF1A1A2E),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── App identity ──
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 30,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Stage 0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your productivity companion',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Quick stats
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: Row(
                        children: [
                          _DrawerStat(label: 'Tasks', value: '3'),
                          _DrawerDivider(),
                          _DrawerStat(label: 'Done', value: '1'),
                          _DrawerDivider(),
                          _DrawerStat(label: 'Left', value: '2'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    _DrawerItem(
                      icon: Icons.check_circle_outline_rounded,
                      label: 'My Tasks',
                      isActive: true,
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerItem(
                      icon: Icons.book_outlined,
                      label: 'Journal',
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerItem(
                      icon: Icons.currency_exchange_rounded,
                      label: 'Converter',
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerItem(
                      icon: Icons.calendar_month_outlined,
                      label: 'Calendar',
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerItem(
                      icon: Icons.bar_chart_rounded,
                      label: 'Analytics',
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
                child: Column(
                  children: [
                    Divider(color: Colors.white.withOpacity(0.08)),
                    const SizedBox(height: 8),
                    _DrawerItem(
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerStat extends StatelessWidget {
  final String label;
  final String value;
  const _DrawerStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 1,
      color: Colors.white.withOpacity(0.1),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = isActive
        ? AppColors.secondary
        : Colors.white.withOpacity(0.75);

    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.secondary.withOpacity(0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        onTap: onTap,
        dense: true,
        leading: Icon(icon, color: textColor, size: 22),
        title: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        trailing: isActive
            ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
              )
            : null,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TODO CARD
// ─────────────────────────────────────────────────────────────────────────────

class _TodoCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final Color color;
  final bool isDone;

  const _TodoCard({
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

// ─────────────────────────────────────────────────────────────────────────────
// TASK DETAIL MODAL
// ─────────────────────────────────────────────────────────────────────────────

class _TaskDetailModal extends StatelessWidget {
  final Map<String, dynamic> todo;
  final VoidCallback onToggleDone;

  const _TaskDetailModal({required this.todo, required this.onToggleDone});

  @override
  Widget build(BuildContext context) {
    final Color color = todo['priorityColor'] as Color;
    final bool isDone = todo['done'] as bool;
    final String date = DateFormat(
      'EEEE, d MMMM y',
    ).format(todo['date'] as DateTime);

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F7F3),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // ── Colored header ──
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 20, 24),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle + close
                Row(
                  children: [
                    Center(
                      child: Container(
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Category badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    todo['category'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Title
                Text(
                  todo['title'] as String,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                    decoration: isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.white54,
                  ),
                ),
                const SizedBox(height: 16),
                // Time + date row
                Row(
                  children: [
                    _HeaderChip(
                      icon: Icons.access_time,
                      label: '${todo['startTime']} – ${todo['endTime']}',
                    ),
                    const SizedBox(width: 10),
                    _HeaderChip(
                      icon: Icons.calendar_today_outlined,
                      label: DateFormat(
                        'd MMM',
                      ).format(todo['date'] as DateTime),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Scrollable body ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description section
                  const _DetailSectionLabel('Description'),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Text(
                      todo['description'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Details grid
                  const _DetailSectionLabel('Details'),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Column(
                      children: [
                        _DetailRow(
                          icon: Icons.calendar_today_outlined,
                          label: 'Date',
                          value: date,
                          iconColor: color,
                        ),
                        _Divider(),
                        _DetailRow(
                          icon: Icons.schedule_outlined,
                          label: 'Start time',
                          value: todo['startTime'] as String,
                          iconColor: color,
                        ),
                        _Divider(),
                        _DetailRow(
                          icon: Icons.schedule_outlined,
                          label: 'End time',
                          value: todo['endTime'] as String,
                          iconColor: color,
                        ),
                        _Divider(),
                        _DetailRow(
                          icon: Icons.label_outline_rounded,
                          label: 'Category',
                          value: todo['category'] as String,
                          iconColor: color,
                        ),
                        _Divider(),
                        _DetailRow(
                          icon: Icons.check_circle_outline_rounded,
                          label: 'Status',
                          value: isDone ? 'Completed' : 'In Progress',
                          iconColor: isDone
                              ? const Color(0xFF10B981)
                              : Colors.orange,
                          valueColor: isDone
                              ? const Color(0xFF10B981)
                              : Colors.orange,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action buttons
                  Row(
                    children: [
                      // Toggle done button
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            onToggleDone();
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 54,
                            decoration: BoxDecoration(
                              color: isDone ? const Color(0xFFF0F0F0) : color,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isDone
                                      ? Icons.refresh_rounded
                                      : Icons.check_rounded,
                                  color: isDone ? Colors.black54 : Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  isDone ? 'Mark Undone' : 'Mark Done',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: isDone
                                        ? Colors.black54
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Edit button
                      Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Delete button
                      Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEEEE),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.delete_outline_rounded,
                          size: 20,
                          color: Color(0xFFE53935),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _HeaderChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailSectionLabel extends StatelessWidget {
  final String text;
  const _DetailSectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black45,
        letterSpacing: 0.4,
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final Color? valueColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 14),
          Text(label, style: TextStyle(fontSize: 14, color: Colors.black45)),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.black.withOpacity(0.05),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// CREATE TODO MODAL
// ─────────────────────────────────────────────────────────────────────────────

class _CreateTodoModal extends StatefulWidget {
  const _CreateTodoModal();

  @override
  State<_CreateTodoModal> createState() => _CreateTodoModalState();
}

class _CreateTodoModalState extends State<_CreateTodoModal> {
  String _selectedCategory = 'Work';
  String _selectedNotify = '15 min';
  Color _selectedColor = const Color(0xFF7B6EF6);

  final List<Color> _colorOptions = const [
    Color(0xFF7B6EF6),
    Color(0xFF2196F3),
    Color(0xFF10B981),
    Color(0xFFD6755B),
    Color(0xFFF59E0B),
    Color(0xFFEC4899),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F7F3),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // ── Header ──
          Container(
            padding: const EdgeInsets.fromLTRB(24, 14, 16, 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'New Task',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // ── Body ──
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ModalLabel('Title'),
                  const SizedBox(height: 8),
                  _StyledTextField(
                    hintText: 'e.g. Design sprint review',
                    fontSize: 16,
                  ),
                  const SizedBox(height: 20),
                  _ModalLabel('Description'),
                  const SizedBox(height: 8),
                  _StyledTextField(
                    hintText: 'What does this task involve?',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  _ModalLabel('Priority Color'),
                  const SizedBox(height: 12),
                  Row(
                    children: _colorOptions.map((c) {
                      final bool sel = _selectedColor == c;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColor = c),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.only(right: 10),
                          height: sel ? 36 : 30,
                          width: sel ? 36 : 30,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                            border: sel
                                ? Border.all(color: Colors.black, width: 2.5)
                                : null,
                            boxShadow: sel
                                ? [
                                    BoxShadow(
                                      color: c.withOpacity(0.4),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : null,
                          ),
                          child: sel
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  _ModalLabel('Date'),
                  const SizedBox(height: 8),
                  _PickerTile(
                    icon: Icons.calendar_today_outlined,
                    value: DateFormat('EEEE, d MMMM y').format(DateTime.now()),
                    accentColor: _selectedColor,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ModalLabel('Start'),
                            const SizedBox(height: 8),
                            _PickerTile(
                              icon: Icons.schedule_outlined,
                              value: '09:00 AM',
                              accentColor: _selectedColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ModalLabel('End'),
                            const SizedBox(height: 8),
                            _PickerTile(
                              icon: Icons.schedule_outlined,
                              value: '10:30 AM',
                              accentColor: _selectedColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _ModalLabel('Category'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Work', 'Personal', 'Health', 'Study'].map((
                      cat,
                    ) {
                      final bool sel = _selectedCategory == cat;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: sel ? _selectedColor : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: sel ? _selectedColor : Colors.black12,
                            ),
                          ),
                          child: Text(
                            cat,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: sel ? Colors.white : Colors.black54,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  _ModalLabel('Remind Me'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['5 min', '15 min', '30 min', '1 hour'].map((n) {
                      final bool sel = _selectedNotify == n;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedNotify = n),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: sel ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: sel ? Colors.black : Colors.black12,
                            ),
                          ),
                          child: Text(
                            n,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: sel ? Colors.white : Colors.black54,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: _selectedColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Create Task',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Modal helpers ─────────────────────────────────────────────────────────────

class _ModalLabel extends StatelessWidget {
  final String text;
  const _ModalLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black45,
        letterSpacing: 0.4,
      ),
    );
  }
}

class _StyledTextField extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final double fontSize;

  const _StyledTextField({
    required this.hintText,
    this.maxLines = 1,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black26,
          fontSize: fontSize,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.black38, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

class _PickerTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color accentColor;

  const _PickerTile({
    required this.icon,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: accentColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 18,
            color: Colors.black38,
          ),
        ],
      ),
    );
  }
}
