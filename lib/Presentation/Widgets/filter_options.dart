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
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: minFollowersController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Minimum Followers',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: minReposController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Minimum Repositories',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
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
