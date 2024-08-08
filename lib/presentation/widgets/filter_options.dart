import 'package:flutter/material.dart';

class FilterOptions extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController followersController = TextEditingController();
  final TextEditingController reposController = TextEditingController();

  FilterOptions({super.key});

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
              const Text(
                'Search By Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              // Name Field
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 40),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF36827F),
                    ),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      final filterOptions = {
                        'name': nameController.text,
                        'minFollowers': int.tryParse(followersController.text) ?? 0,
                        'minRepos': int.tryParse(reposController.text) ?? 0,
                      };
                      Navigator.pop(context, filterOptions);
                    },
                    style:ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Color(0xFF36827F),

                    ),
                    child: const Text('Search'),


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
