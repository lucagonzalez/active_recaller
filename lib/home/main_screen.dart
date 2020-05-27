import 'package:activerecaller/home/capture.dart';
import 'package:activerecaller/home/integrate.dart';
import 'package:activerecaller/home/review.dart';
import 'package:activerecaller/persistance/database.dart';
import 'package:activerecaller/persistance/db/user.dart';
import 'package:activerecaller/ui/reusable/db_widget_state.dart';
import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  final int index;

  const MainScreenWidget({Key key, this.index = 1}) : super(key: key);
  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState(this.index);
}

class _MainScreenWidgetState extends DbWidgetState<MainScreenWidget> {
  User _user;
  int _selectedIndex;
  final List<Widget> _children = [
    CaptureWidget(),
    ReviewWidget(),
    IntegrateWidget(),
  ];

  _MainScreenWidgetState(this._selectedIndex);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> initStateAsync(AppDatabase database) async {
    _user = await database.userDao.findCurrentUser();
  }

  @override
  Widget buildLoaded(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text('Capture'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Review'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.av_timer),
            title: Text('Integrate'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xff112d4e),
        unselectedItemColor: Colors.white38,
        onTap: _onItemTapped,
      ),
    );
  }
}