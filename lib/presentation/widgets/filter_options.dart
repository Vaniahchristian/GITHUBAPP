import 'package:flutter/material.dart';

class FilterOptions extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController followersController = TextEditingController();
  final TextEditingController reposController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(

      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text(
                'Search By Name',
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

              SizedBox(height: 10),
              // Minimum Repositories Field

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
                      foregroundColor: Colors.green,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      final filterOptions = {
                        'name': nameController.text,
                        'minFollowers': int.tryParse(followersController.text) ?? 0,
                        'minRepos': int.tryParse(reposController.text) ?? 0,
                      };
                      Navigator.pop(context, filterOptions);
                    },
                    child: Text('Search'),
                    style:ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green,

                    ),


                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );



  }
}
