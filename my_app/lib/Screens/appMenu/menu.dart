// import 'package:fithompro/Screens/addProduct/addProduct.dart';
import 'package:fithompro/Screens/Settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import '../accueil/accueil.dart';
import '../profil/profil.dart';
import '../home_page/home_page.dart';
import '../Contact_page/contact_page.dart';
import '../Help_page/help_page.dart';
import 'package:fithompro/Screens/addProduct/addProduct.dart';
import '../Welcome/welcome_screen.dart';
import '../Settings_page/settings_page.dart';

class MenuBurger extends StatefulWidget {
  const MenuBurger(
    this.logList,
  );
  final Map logList;
  @override
  State<MenuBurger> createState() => _MenuBurgerState(logList);
}

class _MenuBurgerState extends State<MenuBurger> {
  int currentTab = 0;
  int _selectedIndex = 0;
  _MenuBurgerState(
    this.logList,
  );
  final Map logList;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = WelcomePage(); //

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Align(alignment: Alignment.center),
            DrawerHeader(
              child: Text(
                logList["FIRSTNAME"] + " " + logList["NAME"],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text(
                'Help',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.mail),
              title: const Text(
                'Contact us',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeedBackPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text(
                'Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text(
                'Log out',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.account_circle,
                size: 50,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        onPressed: () {
          setState(() {
            currentScreen = AddProduct(
                logList); // if user taps on this dashboard tab will be active
            currentTab = 0;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            WelcomePage(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color:
                              currentTab == 0 ? Colors.deepPurple : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0
                                ? Colors.deepPurple
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        currentScreen = Accueil(
                          logList: logList,
                        ); // if user taps on this dashboard tab will be active
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color:
                              currentTab == 1 ? Colors.deepPurple : Colors.grey,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                            color: currentTab == 1
                                ? Colors.deepPurple
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 110,
                    onPressed: () {
                      setState(() {
                        currentScreen = Profil(
                            logList:
                                logList); // if user aps on this dashboard tab will be active
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: currentTab == 3 ? Colors.purple : Colors.grey,
                        ),
                        Text(
                          'Profil',
                          style: TextStyle(
                            color:
                                currentTab == 3 ? Colors.purple : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
