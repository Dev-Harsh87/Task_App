import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String createdDate;
  final String status;
  final String dueDate;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  TaskCardWidget({
    required this.title,
    required this.description,
    required this.createdDate,
    required this.status,
    required this.dueDate,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor = status == "Completed" ? Colors.green : Colors.red;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine screen size
        bool isLargeScreen = constraints.maxWidth > 600; // Tablet/desktop
        bool isMediumScreen = constraints.maxWidth <= 600 && constraints.maxWidth > 400; // Mobile in landscape or tablet
        bool isSmallScreen = constraints.maxWidth <= 400; // Small mobile screens

        // Adjust text size based on screen size
        double titleFontSize = isLargeScreen ? 22 : isMediumScreen ? 18 : 16;
        double descriptionFontSize = isLargeScreen ? 16 : isMediumScreen ? 14 : 12;
        double dateFontSize = isLargeScreen ? 14 : isMediumScreen ? 12 : 10;

        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(isLargeScreen ? 20 : isMediumScreen ? 16 : 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: descriptionFontSize,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(
                          createdDate,
                          style: TextStyle(
                            fontSize: dateFontSize,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 18, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(
                          dueDate,
                          style: TextStyle(
                            fontSize: dateFontSize,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.check_circle, size: 18, color: statusColor),
                    SizedBox(width: 5),
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: isLargeScreen ? 16 : 14,
                        fontWeight: FontWeight.w500,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
