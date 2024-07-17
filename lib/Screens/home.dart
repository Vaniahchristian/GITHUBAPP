import 'package:flutter/material.dart';
import '../Services/github_service.dart';
import '../Models/github_user.dart';
import 'user_details.dart';
import 'filter_options.dart';

GitHubService _githubService = GitHubService();

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  List<GitHubUser> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsersByLocation();
  }

  void _fetchUsersByLocation() async {
    final users = await _githubService.fetchUsersByLocation(_searchController.text);
    setState(() {
      _users = users.map((json) => GitHubUser.fromJson(json)).toList();
    });
  }

  void _showFilterOptions(BuildContext context) async {
    final mediaQuery = MediaQuery.of(context);


    final filterOptions = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(



          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: FilterOptions(),
            );
          },
        );
      },
    );

    if (filterOptions != null) {
      final filteredUsers = await _githubService.fetchUsersByFilter(
        name: filterOptions['name'],
        minFollowers: filterOptions['minFollowers'],
        minRepos: filterOptions['minRepos'],
      );
      setState(() {
        _users = filteredUsers.map((json) => GitHubUser.fromJson(json)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GitHub Users App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF000080),
        // Primary Color
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 55.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Search by location',
                        labelStyle: TextStyle(color: Color(0xFF757575)), // Grey text
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12.0),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search, color: Color(0xFF26C6DA)), // Accent Color
                          onPressed: () {
                            FocusScope.of(context).unfocus(); // Dismiss the keyboard
                            _fetchUsersByLocation();
                          },
                        ),
                      ),
                      cursorColor: Color(0xFF1E88E5), // Primary Color
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Color(0xFF26C6DA)), // Accent Color
                    onPressed: () async {
                      _showFilterOptions(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _users.isEmpty
                  ? Center(child: Text('No users found', style: TextStyle(color: Color(0xFF757575)))) // Grey text
                  : ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  final user = _users[index];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatarUrl),
                      ),
                      title: Text(user.login, style: TextStyle(color: Color(0xFF212121))), // Black text
                      subtitle: Text(user.htmlUrl, style: TextStyle(color: Color(0xFF757575))), // Grey text
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetails(user: user),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
