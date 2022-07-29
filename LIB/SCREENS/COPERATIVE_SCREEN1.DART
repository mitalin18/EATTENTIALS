import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/items.dart';

import '../widgets/app_drawer2.dart';
import '../widgets/items_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class CoperativeScreen1 extends StatefulWidget {
  @override
  CoperativeScreen1State createState() => CoperativeScreen1State();
  static const routeName = '/coperative1';
}

class CoperativeScreen1State extends State<CoperativeScreen1> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Items>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eattentials'),
      ),
      drawer: AppDrawer2(),
      body: ItemsGrid(_showOnlyFavorites),
    );
  }
}
