import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:order/main.dart';
import 'package:order/screens/chat_screen.dart';
import 'package:order/screens/delivery.dart';
import 'package:order/screens/offerPage.dart';
import 'package:order/screens/receipt.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> _screens = [OfferPage(), Delivery(), Receipt()];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Data>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff11998E), Color(0xff38EF7D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
        elevation: 0,
        title: Text(provider.personName),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                        return ChatScreen();
                      }));
                    },
                    icon: Icon(FontAwesomeIcons.message)),
                // IconButton(
                //     onPressed: () {
                //       FirebaseAuth.instance.signOut();
                //       Navigator.pushReplacementNamed(
                //           context, Routes.introduction);

                //     },
                //     icon: Icon(Icons.logout)),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GNav(
        rippleColor: Colors.grey[300]!,
        hoverColor: Colors.grey[100]!,
        gap: 8,
        activeColor: Colors.black,
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: Colors.grey[100]!,
        color: Colors.black,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.delivery_dining,
            text: 'Delivery',
          ),
          GButton(
            icon: Icons.receipt,
            text: 'Receipt',
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _screens[_selectedIndex],
    );
  }
}
