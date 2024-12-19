import 'package:flutter/material.dart';

class JobCard extends StatefulWidget {
  const JobCard({
    super.key,
    required this.jobTitle,
    required this.companyName,
    required this.jobLocation,
    this.imagePath,
    this.subtitle,
  });

  final String jobTitle;
  final String companyName;
  final String jobLocation;
  final String? subtitle;
  final String? imagePath;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  bool isBookmarked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Job Image or Placeholder
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: widget.imagePath != null
                    ? DecorationImage(
                        image: AssetImage(widget
                            .imagePath!), // Use AssetImage or NetworkImage
                        fit: BoxFit.cover,
                      )
                    : null,
                color: widget.imagePath == null ? Colors.grey[300] : null,
              ),
              child: widget.imagePath == null
                  ? Icon(Icons.image_not_supported, color: Colors.grey[600])
                  : null,
            ),
            const SizedBox(width: 16),
            // Job Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.jobTitle,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.companyName,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Text(
                    widget.jobLocation,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      widget.subtitle!,
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ],
                ],
              ),
            ),
            // Bookmark Button
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                color: isBookmarked ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isBookmarked = !isBookmarked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
