import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '../../Data/Models/github_user_model.dart';
import '../../Providers/filter_provider.dart';
import '../../Providers/user_provider.dart';
import 'user_details.dart';
import '../widgets/filter_options.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  final PagingController<int, GitHubUserModel> _pagingController = PagingController(
    firstPageKey: 1,
  );

  final int _perPage = 30; // Adjust perPage as needed
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late Stream<ConnectivityResult> _connectivityStream;
  late Connectivity _connectivity;

  List<GitHubUserModel> _filteredUsers = [];
  bool _isFiltered = false;
  bool _isNoInternet = false;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _connectivityStream = _connectivity.onConnectivityChanged;
    _checkConnection();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _connectivityStream.listen((ConnectivityResult result) {
      _checkConnection();
    });
  }

  Future<void> _checkConnection() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    bool isConnected = result != ConnectivityResult.none;

    // Perform an actual network request to verify internet connectivity
    if (isConnected) {
      try {
        final response = await http.get(Uri.parse('https://www.google.com'));
        isConnected = response.statusCode == 200;
      } catch (e) {
        isConnected = false;
      }
    }

    setState(() {
      _connectionStatus = result;
      _isNoInternet = !isConnected;
    });

    if (!_isNoInternet) {
      _pagingController.refresh();
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    if (_isNoInternet) {
      setState(() {
        _pagingController.error = "No internet connection.";
      });
      return;
    }
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.fetchUsersByLocation(_searchController.text);
      final newUsers = userProvider.users;
      final isLastPage = newUsers.length < _perPage;
      if (isLastPage) {
        _pagingController.appendLastPage(newUsers);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newUsers, nextPageKey);
      }
      setState(() {
        _isNoInternet = false;
      });
    } catch (e) {
      setState(() {
        _pagingController.error = e;
        _isNoInternet = true;
      });
    }
  }

  Future<void> _openSettings() async {
    final intent = AndroidIntent(
      action: 'android.settings.SETTINGS',
      flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
    );
    await intent.launch();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GitHub Users App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF36827F),
        centerTitle: true,
      ),
      body: _isNoInternet
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No internet connection', style: TextStyle(color: Color(0xFF757575))),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _openSettings,
              child: Text('Open Settings'),
            ),
          ],
        ),
      )
          : Padding(
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
                    offset: Offset(0, 3),
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
                        labelStyle: TextStyle(color: Color(0xFF757575)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12.0),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search, color: Color(0xFF26C6DA)),
                          onPressed: () {
                            setState(() {
                              _isFiltered = false;
                            });
                            FocusScope.of(context).unfocus();
                            _pagingController.refresh();
                          },
                        ),
                      ),
                      cursorColor: Color(0xFF1E88E5),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Color(0xFF26C6DA)),
                    onPressed: () async {
                      _showFilterOptions(context);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _isFiltered
                  ? Consumer<FilterProvider>(
                builder: (context, filterProvider, child) {
                  return ListView.builder(
                    itemCount: filterProvider.filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filterProvider.filteredUsers[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatarUrl),
                          ),
                          title: Text(user.login, style: TextStyle(color: Color(0xFF212121))),
                          subtitle: Text(user.htmlUrl, style: TextStyle(color: Color(0xFF757575))),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/userDetails',
                              arguments: user,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              )
                  : Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return PagedListView<int, GitHubUserModel>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<GitHubUserModel>(
                      itemBuilder: (context, item, index) => Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(item.avatarUrl),
                          ),
                          title: Text(item.login, style: TextStyle(color: Color(0xFF212121))),
                          subtitle: Text(item.htmlUrl, style: TextStyle(color: Color(0xFF757575))),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/userDetails',
                              arguments: item,
                            );
                          },
                        ),
                      ),
                      firstPageErrorIndicatorBuilder: (context) => Center(
                        child: Text('No users found', style: TextStyle(color: Color(0xFF757575))),
                      ),
                      noItemsFoundIndicatorBuilder: (context) => Center(
                        child: Text('No users found', style: TextStyle(color: Color(0xFF757575))),
                      ),
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

  void _showFilterOptions(BuildContext context) async {
    final filterOptions = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => FilterOptions(),
    );

    if (filterOptions != null) {
      final filterProvider = Provider.of<FilterProvider>(context, listen: false);
      await filterProvider.fetchUsersByFilter(
        filterOptions['name'],
        exactFollowers: filterOptions['exactFollowers'],
        exactRepos: filterOptions['exactRepos'],
      );
      setState(() {
        _isFiltered = true;
      });
    }
  }
}
