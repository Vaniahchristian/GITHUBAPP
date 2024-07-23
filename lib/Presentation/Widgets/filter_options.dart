import 'package:flutter/material.dart';

class FilterOptions extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController minFollowersController = TextEditingController();
  final TextEditingController minReposController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              'Filter Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            // Name Field
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 10),
            // Minimum Followers Field
            TextField(
              controller: minFollowersController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Minimum Followers',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.people),
              ),
            ),
            SizedBox(height: 10),
            // Minimum Repositories Field
            TextField(
              controller: minReposController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Minimum Repositories',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.storage),
              ),
            ),
            SizedBox(height: 20),
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    final filterOptions = {
                      'name': nameController.text,
                      'minFollowers': int.tryParse(minFollowersController.text) ?? 0,
                      'minRepos': int.tryParse(minReposController.text) ?? 0,
                    };
                    Navigator.pop(context, filterOptions);
                  },
                  child: Text('Apply Filters'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
