import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/todo_model.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 180),
      vsync: this,
      lowerBound: 0.97,
      upperBound: 1.0,
    );
    _scaleAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _controller.reverse();
  void _onTapUp(TapUpDetails details) => _controller.forward();
  void _onTapCancel() => _controller.forward();

  @override
  Widget build(BuildContext context) {
    final isCompleted = widget.todo.isCompleted;
    final description = widget.todo.description;
    return ScaleTransition(
      scale: _scaleAnim,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        splashColor: Colors.blue.withOpacity(0.08),
        highlightColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.35),
            border: Border.all(
              color: isCompleted
                  ? Colors.green.withOpacity(0.35)
                  : Colors.blue.withOpacity(0.18),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            leading: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? Colors.green.withOpacity(0.18)
                    : Colors.blue.withOpacity(0.10),
              ),
              child: IconButton(
                icon: Icon(
                  isCompleted
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: isCompleted ? Colors.green : Colors.blue.shade700,
                  size: 28,
                ),
                onPressed: widget.onToggle,
                tooltip:
                    isCompleted ? 'Mark as incomplete' : 'Mark as complete',
              ),
            ),
            title: Text(
              widget.todo.title,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: isCompleted
                    ? Colors.green.shade700.withOpacity(0.7)
                    : Colors.blue.shade900,
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                letterSpacing: 0.5,
              ),
            ),
            subtitle: description.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      description,
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: Colors.blueGrey.shade700.withOpacity(0.85),
                        fontStyle:
                            isCompleted ? FontStyle.italic : FontStyle.normal,
                      ),
                    ),
                  )
                : null,
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline_rounded,
                  color: Colors.redAccent, size: 26),
              onPressed: widget.onDelete,
              tooltip: 'Delete',
              splashRadius: 22,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          ),
        ),
      ),
    );
  }
}
