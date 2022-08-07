part of '../pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List pages = [
    const MainFoodPage(),
    const OrderPage(),
    const CartHistory(),
    const ProfilePage(),
  ];

  void onTopNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryYellow,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        currentIndex: _selectedIndex,
        onTap: onTopNav,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: AppColors.secondaryDark,
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.secondaryDark,
            icon: Icon(Icons.archive),
            label: 'History',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.secondaryDark,
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.secondaryDark,
            icon: Icon(Icons.person),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}
