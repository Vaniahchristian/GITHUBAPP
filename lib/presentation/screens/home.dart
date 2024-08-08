import 'package:http/http.dart' as http;
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:connectivity/connectivity.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/github_user_entity.dart';
import '../providers/filter_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/filter_options.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  final PagingController<int, GitHubUserEntity> _pagingController = PagingController(
    firstPageKey: 1,
  );

  final int _perPage = 30; // Adjust perPage as needed
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  late Stream<ConnectivityResult> _connectivityStream;
  late Connectivity _connectivity;

  final List<GitHubUserEntity> _filteredUsers = [];
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
    const intent = AndroidIntent(
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
        title: const Text(
          'GitHub Users App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF36827F),
        centerTitle: true,
      ),
      body: _isNoInternet
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No internet connection', style: TextStyle(color: Color(0xFF757575))),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _openSettings,
              child: const Text('Open Settings'),
            ),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
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
                    offset: const Offset(0, 3),
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
                        labelStyle: const TextStyle(color: Color(0xFF757575)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(12.0),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search, color: Color(0xFF26C6DA)),
                          onPressed: () {
                            setState(() {
                              _isFiltered = false;
                            });
                            FocusScope.of(context).unfocus();
                            _pagingController.refresh();
                          },
                        ),
                      ),
                      cursorColor: const Color(0xFF1E88E5),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.filter_list, color: Color(0xFF26C6DA)),
                    onPressed: () async {
                      _showFilterOptions(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isFiltered
                  ? Consumer<FilterProvider>(
                builder: (context, filterProvider, child) {
                  return ListView.builder(
                    itemCount: filterProvider.filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filterProvider.filteredUsers[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user.avatarUrl),
                          ),
                          title: Text(user.login, style: const TextStyle(color: Color(0xFF212121))),
                          subtitle: Text(user.htmlUrl, style: const TextStyle(color: Color(0xFF757575))),
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
                  return PagedListView<int, GitHubUserEntity>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<GitHubUserEntity>(
                      itemBuilder: (context, item, index) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(item.avatarUrl),
                          ),
                          title: Text(item.login, style: const TextStyle(color: Color(0xFF212121))),
                          subtitle: Text(item.htmlUrl, style: const TextStyle(color: Color(0xFF757575))),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/userDetails',
                              arguments: item,
                            );
                          },
                        ),
                      ),
                      firstPageErrorIndicatorBuilder: (context) => const Center(
                        child: Text('No users found', style: TextStyle(color: Color(0xFF757575))),
                      ),
                      noItemsFoundIndicatorBuilder: (context) => const Center(
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
        //exactFollowers: filterOptions['exactFollowers'],
        //exactRepos: filterOptions['exactRepos'],
      );
      setState(() {
        _isFiltered = true;
      });
    }
  }
}
