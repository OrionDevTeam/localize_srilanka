import 'package:flutter/material.dart';
import 'package:localize_sl/get_started.dart';

class GuideProfilePage extends StatefulWidget {
  const GuideProfilePage({super.key});

  @override
  State<GuideProfilePage> createState() => _GuideProfilePageState();
}

class _GuideProfilePageState extends State<GuideProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontFamily: 'Times New Roman',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to settings page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color.fromARGB(255, 220, 220, 220), // Grey background color for SafeArea
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(right: 10.0), // Margin to the right of the screen
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
                  const SizedBox(height: 100,),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/biru/profile.jpg'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Vimosh Vasanthakumar',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hi! Im Using Localize. Your friendly tour guide',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to wallet page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WalletPage()),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.white; // Change button color when hovered
                          }
                          return const Color.fromARGB(255, 42, 150, 108); // Use default color
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return const Color.fromARGB(255, 42, 150, 108); // Change text color when hovered
                          }
                          return Colors.white; // Use default color // Use default color
                        },
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Icon(Icons.account_balance_wallet,),
                    Text('Wallet', style: TextStyle(fontWeight: FontWeight.bold))],),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to activity page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ActivityPage()),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.white; // Change button color when hovered
                          }
                          return const Color.fromARGB(255, 42, 150, 108); // Use default color
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return const Color.fromARGB(255, 42, 150, 108); // Change text color when hovered
                          }
                          return Colors.white; // Use default color
                        },
                      ),
                    ),
                    child: const Column(
                      children: [
                    Icon(Icons.history),
                    Text('Activity', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                    ),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to help page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HelpPage()),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.white; // Change button color when hovered
                          }
                          return const Color.fromARGB(255, 42, 150, 108); // Use default color
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return const Color.fromARGB(255, 42, 150, 108); // Change text color when hovered
                          }
                          return Colors.white; // Use default color
                        },
                      ),
                    ),
                    child: const Column(children: [
                    Icon(Icons.help),
                    Text('Help', 
                    style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  
                  ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Your Memories',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 14, // Adjust the number of images as needed
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        'assets/biru/image_$index.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20,)
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 40),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20, height: 20,),
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/biru/profile.jpg'),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Vimosh Vasanthakumar',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          "Guide",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'vimosh02@gmail.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const GetStartedPage(),
                                  ),
                                  (route) => false,
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(const Color(0xFF2A966C)),
                              ),
                              child: const Text(
                                'Log Out',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              
              const SizedBox(height: 60),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigate to account settings page
                          // You can use Navigator.push to navigate to the respective page
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onHover: (_) {
                            // Handle hover effect
                          },
                          child: const ProfileBlock(
                            title: 'Account Settings',
                            subtext: 'Change Name, Email, Password',
                            icon: Icons.man,
                            // Set text color to white
                          ),
                        ),
                      ),
                      const SizedBox(width: 120),
                      InkWell(
                        onTap: () {
                          // Navigate to notification settings page
                          // You can use Navigator.push to navigate to the respective page
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onHover: (_) {
                            // Handle hover effect
                          },
                          child: const ProfileBlock(
                            title: 'Notification Settings',
                            subtext: 'Enable / Disable notifications',
                            icon: Icons.notifications,
                            // Set text color to white
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Outer code
              InkWell(
                onTap: () {
                  // Navigate to account settings page
                  // You can use Navigator.push to navigate to the respective page
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onHover: (_) {
                    // Handle hover effect
                  },
                  child: const ProfileBlock(
                    title: 'Account Settings',
                    subtext: 'Change Name, Email, Password',
                    icon: Icons.man,
                  ),
                ),
              ),
      
      const SizedBox(width: 120),
      InkWell(
        onTap: () {
          // Navigate to account settings page
          // You can use Navigator.push to navigate to the respective page
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (_) {
            // Handle hover effect
          },
          child: const ProfileBlock(
            title: 'Change Interests',
            subtext: 'Edit your experience interests',
            icon: Icons.interests,
             // Set text color to white
          ),
        ),
      ),
            ],
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
      const SizedBox(width: 5),
      InkWell(
        onTap: () {
          // Navigate to account settings page
          // You can use Navigator.push to navigate to the respective page
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (_) {
            // Handle hover effect
          },
          child: const ProfileBlock(
            title: 'Face ID',
            subtext: "   Manage your device's security   ",
            icon: Icons.face,
             // Set text color to white
          ),
        ),
      ),
      const SizedBox(width: 120),
      InkWell(
        onTap: () {
          // Navigate to account settings page
          // You can use Navigator.push to navigate to the respective page
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (_) {
            // Handle hover effect
          },
          child: const ProfileBlock(
            title: 'Need Help ?',
            subtext: 'Chat with a customer care agent',
            icon: Icons.help,
             // Set text color to white
          ),
        ),
      ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 40,),
      
                    ],
                  ),
        ),
      ],
            
          )

        
      
    );
  }
}

// Inside the ProfileBlock widget definition, you can set the text color directly

class ProfileBlock extends StatefulWidget {
  final String title;
  final String subtext;
  final IconData icon;

  const ProfileBlock({
    super.key,
    required this.title,
    required this.subtext,
    required this.icon,
  });

  @override
  State<ProfileBlock> createState() => _ProfileBlockState();
}

class _ProfileBlockState extends State<ProfileBlock> {
    
  final bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isHovered ? const Color.fromARGB(255, 42, 150, 108) : const Color.fromARGB(255, 235, 235, 235),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: 50,
            color: const Color.fromARGB(255, 42, 150, 108), // Set icon color to white
          ),
          const SizedBox(height: 10),
          Text(
            widget.title,
            style: const TextStyle(
              color: Color.fromARGB(255, 42, 150, 108), // Set text color to white
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.subtext,
            style: const TextStyle(
              color: Color.fromARGB(255, 42, 150, 108), // Set text color to white
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}



class CardInfoItem extends StatelessWidget {
  final AssetImage cardImage;
  final String cardNumber;
  final String cardName;

  const CardInfoItem({super.key, 
    
    required this.cardImage,
    required this.cardNumber,
    required this.cardName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: cardImage),
            const SizedBox(height: 10),
            Text('Card Number: $cardNumber'),
            const SizedBox(height: 10),
            Text('Card Owner: $cardName'),
          ],
        ),
      ),
    );
  }
}



class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int selectedChipIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200], // Grey background color for SafeArea
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(right: 10.0), // Margin to the right of the screen
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
                  const SizedBox(height: 100,),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/biru/profile.jpg'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Vimosh Vasanthakumar',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hi! Im Using Localize. Your friendly tour guide',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to wallet page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WalletPage()),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.white; // Change button color when hovered
                          }
                          return const Color.fromARGB(255, 42, 150, 108); // Use default color
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return const Color.fromARGB(255, 42, 150, 108); // Change text color when hovered
                          }
                          return Colors.white; // Use default color
                        },
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Icon(Icons.account_balance_wallet),
                    Text('Wallet', style: TextStyle(fontWeight: FontWeight.bold))],),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to activity page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ActivityPage()),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.white; // Change button color when hovered
                          }
                          return const Color.fromARGB(255, 42, 150, 108);
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return const Color.fromARGB(255, 42, 150, 108); // Change text color when hovered
                          }
                          return Colors.white; 
                        },
                      ),
                    ),
                    child: const Column(
                      children: [
                    Icon(Icons.history),
                    Text('Activity', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                    ),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to help page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HelpPage()),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.white; // Change button color when hovered
                          }
                          return const Color.fromARGB(255, 42, 150, 108); // Use default color
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return const Color.fromARGB(255, 42, 150, 108); // Change text color when hovered
                          }
                          return Colors.white; // Use default color
                        },
                      ),
                    ),
                    child: const Column(children: [
                    Icon(Icons.help),
                    Text('Help', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  
                  ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
  flex: 3,
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Wallet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        
        ),
        const Padding(padding: EdgeInsets.all(8.0),
        child: Text(
            'My Cards',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
        const SizedBox(height: 20),
        // Display Card Information
        
        const SizedBox(height: 20),
      // Display Card Information
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 20), // Add space before the first choice chip
            ChoiceChip(
              label: const Column(
                children: [
                  SizedBox(height: 10),
                  Image(image: AssetImage('assets/biru/card1.png')),
                  SizedBox(height: 10,),
                  Text('Card no: **** **** **** 4206',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ],
              ),
              selected: selectedChipIndex == 0,
                    backgroundColor: selectedChipIndex == 0 ? const Color.fromARGB(255, 42, 150, 108) : null,
                    labelStyle: TextStyle(
                      color: selectedChipIndex == 0 ? Colors.white : null,
                    ),
                    onSelected: (isSelected) {
                      setState(() {
                        selectedChipIndex = isSelected ? 0 : -1;
                      });
                    }
            ),
            const SizedBox(width: 20), // Add space between choice chips
            ChoiceChip(
              label: const Column(
                children: [
                  SizedBox(height: 10),
                  Image(image: AssetImage('assets/biru/card2.png')),
                  SizedBox(height:10),
                  Text('Card No: **** **** **** 0000',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )
                  ),
                  SizedBox(height: 10),
                ],
              ),
              selected: selectedChipIndex == 1,
                    backgroundColor: selectedChipIndex == 1 ? const Color.fromARGB(255, 42, 150, 108) : null,
                    labelStyle: TextStyle(
                      color: selectedChipIndex == 1 ? Colors.white : null,
                    ),
                    onSelected: (isSelected) {
                      setState(() {
                        selectedChipIndex = isSelected ? 1 : -1;
                      });
                    }
            ),
            // Add more ChoiceChips as needed
          ],
        ),
      ),
      const SizedBox(height: 30),
      Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton.extended(
                  heroTag: 'edit',
                  onPressed: () {
                    // Add your edit action here
                  },
                  label: const Text('Edit your cards'),
                  icon: const Icon(Icons.edit),
                  backgroundColor: const Color.fromARGB(255, 42, 150, 108),
                  foregroundColor: Colors.white,
                ),
                FloatingActionButton.extended(
                  heroTag: 'add',
                  onPressed: () {
                    // Add your add card action here
                  },
                  label: const Text('Add card'),
                  icon: const Icon(Icons.add),
                  backgroundColor: const Color.fromARGB(255, 42, 150, 108),
                  foregroundColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              height: 1,
              color: Color.fromARGB(255, 173, 173, 173),
              thickness: 5,
            ),
            const SizedBox(height: 10),
            // Three ElevatedCards separated by dividers
            const ElevatedCard(
              title: 'Payment Methods',
              buttonText: 'Add Card',
              dropdownItems: ["Cash", 'Visa', 'MasterCard', 'American Express'],
              defaultDropdownValue: 'Cash',
            ),
            
            const SizedBox(height: 10),
            const Divider(
              height: 1,
              color: Colors.black,
              thickness: 1,
            ),
            const SizedBox(height: 10),
            const ElevatedCard(
              title: 'Vouchers',
              buttonText: 'Add Vouchers',
              dropdownItems: ['Vouchers'],
              defaultDropdownValue: 'Vouchers',
            ),
            
            const SizedBox(height: 10),
            const Divider(
              height: 1,
              color: Colors.black,
              thickness: 1,
            ),
            const SizedBox(height: 10),
            const ElevatedCard(
              title: 'Promotions',
              buttonText: 'Add Promotions',
              dropdownItems: ['Promotions'],
              defaultDropdownValue: 'Promotions',
            ),

            const SizedBox(height: 20,),
            
        

      ],
    ),
  ),
  
),

        ],
          
    ),
    );

      
    
  }
}


class ElevatedCard extends StatefulWidget {
  final String title;
  final List<String> dropdownItems;
  final String buttonText;
  final String defaultDropdownValue;

  const ElevatedCard({
    super.key,
    required this.title,
    required this.dropdownItems,
    required this.buttonText,
    required this.defaultDropdownValue,
  });

  @override
  State<ElevatedCard> createState() => _ElevatedCardState();
}

class _ElevatedCardState extends State<ElevatedCard> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.defaultDropdownValue;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: widget.dropdownItems
                    .map<DropdownMenuItem<String>>(
                        (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(width: 40,),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Add button onPressed action here
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(65, 65),
                  backgroundColor: const Color.fromARGB(255, 42, 150, 108),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    widget.buttonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200], // Grey background color for SafeArea
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(right: 10.0), // Margin to the right of the screen
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                
                children: [
                  const SizedBox(height: 100,),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/biru/profile.jpg'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Vimosh Vasanthakumar',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hi! Im Using Localize. Your friendly tour guide',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to wallet page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WalletPage()),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.white; // Change button color when hovered
                          }
                          return const Color.fromARGB(255, 42, 150, 108); // Use default color
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return const Color.fromARGB(255, 42, 150, 108); // Change text color when hovered
                          }
                          return Colors.white; // Use default color
                        },
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Icon(Icons.account_balance_wallet),
                    Text('Wallet', style: TextStyle(fontWeight: FontWeight.bold))],),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to activity page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ActivityPage()),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.white; // Change button color when hovered
                          }
                          return const Color.fromARGB(255, 42, 150, 108); // Use default color
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return const Color.fromARGB(255, 42, 150, 108); // Change text color when hovered
                          }
                          return Colors.white; // Use default color
                        },
                      ),
                    ),
                    child: const Column(
                      children: [
                    Icon(Icons.history),
                    Text('Activity', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                    ),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to help page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HelpPage()),
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.white; // Change button color when hovered
                          }
                          return const Color.fromARGB(255, 42, 150, 108); // Use default color
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return const Color.fromARGB(255, 42, 150, 108); // Change text color when hovered
                          }
                          return Colors.white; // Use default color
                        },
                      ),
                    ),
                    child: const Column(children: [
                    Icon(Icons.help),
                    Text('Help', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                    ),
                  ),
                  
                  ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Activity',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5, // Change this to the actual number of posts
                    itemBuilder: (BuildContext context, int index) {
                      return _buildActivityPost(context);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20,)
        ],
      ),
    );
  }

  Widget _buildActivityPost(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/biru/profile.jpg'),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vimosh Vasanthakumar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'April 12, 2024',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Here is the content of the activity post. You can customize this text with dynamic data.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 200, // Adjust the height as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: const DecorationImage(
                  image: AssetImage('assets/biru/place_image.jpg'), // Replace with actual image path
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Add more widgets as needed for actions like like, comment, share
          ],
        ),
        Positioned(
              top: 0,
              right: 0,
              child: ElevatedButton(
                onPressed: () {
                  // Add your rebook functionality here
                },
                style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color.fromARGB(255, 42, 150, 108); // Change button color when pressed
                              }

                              else if (states.contains(MaterialState.hovered)) {
                                return Colors.white; // Change button color when hovered
                          }
                          return const Color.fromARGB(255, 42, 150, 108); // Use default color
                        },
                          ),
                          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color.fromARGB(255, 42, 150, 108); // Change button color when pressed
                              }

                              else if (states.contains(MaterialState.hovered)) {
                                return const Color.fromARGB(255, 42, 150, 108); // Change button color when hovered
                              }
                              return Colors.white; // Use default color
                            },
                          ),
                        ),
                child: const Text(
                  'Rebook', 
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
              ),
              ),
        ],
    ),
  );
}
}

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey[200], // Grey background color for SafeArea
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(right: 10.0), // Margin to the right of the screen
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100,),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/biru/profile.jpg'),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Vimosh Vasanthakumar',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hi! I\'m Using Localize. Your friendly tour guide',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const WalletPage()),
                          );
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.white; // Change button color when hovered
                              }
                              return const Color.fromARGB(255, 42, 150, 108); // Use default color
                            },
                          ),
                          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return const Color.fromARGB(255, 42, 150, 108); // Change text color when hovered
                              }
                              return Colors.white; // Use default color
                            },
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_balance_wallet),
                            Text('Wallet', style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      const SizedBox(width: 20,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ActivityPage()),
                          );
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.white; // Change button color when hovered
                              }
                              return const Color.fromARGB(255, 42, 150, 108); // Use default color
                            },
                          ),
                          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return const Color.fromARGB(255, 42, 150, 108); // Change text color when hovered
                              }
                              return Colors.white; // Use default color
                            },
                          ),
                        ),
                        child: const Column(
                          children: [
                            Icon(Icons.history),
                            Text('Activity', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20,),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HelpPage()),
                          );
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          ),
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.white; // Change button color when hovered
                              }
                              return const Color.fromARGB(255, 42, 150, 108); // Use default color
                            },
                          ),
                          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return const Color.fromARGB(255, 42, 150, 108); // Change text color when hovered
                              }
                              return Colors.white; // Use default color
                            },
                          ),
                        ),
                        child: const Column(
                          children: [
                            Icon(Icons.help),
                            Text('Help', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
            
          
          const SizedBox(width: 10,),
          const Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Help',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // List of Questions and Answers
                  FAQContainer(
                    question: 'How do I reset my password?',
                    answer:
                    'To reset your password, go to the login page and click on "Forgot Password?" link. Follow the instructions sent to your email to reset your password.',
                  ),
                  FAQContainer(
                    question: 'How do I contact customer support?',
                    answer:
                    'You can contact our customer support team by emailing support@example.com or by calling +1-800-123-4567.',
                  ),
                  // Add more FAQContainers as needed
                ],
              ),
            ),
          ),
          const SizedBox(width: 20,)
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Ask me anything',
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
  onPressed: () {
    // Add functionality to submit button
  },
  icon: const Icon(Icons.send),
  label: const Text('Submit'),
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return const Color.fromARGB(255, 42, 150, 108); // Green background when hovered
        }
        return Colors.white; // Default background color
      },
    ),
    foregroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return Colors.white; // White text color when hovered
        }
        return const Color.fromARGB(255, 42, 150, 108); // Default text color
      },
    ),
  ),
),

            ],
          ),
        ),
      ),
    );
  }
}


class FAQContainer extends StatefulWidget {
  final String question;
  final String answer;

  const FAQContainer({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FAQContainer> createState() => _FAQContainerState();
}

class _FAQContainerState extends State<FAQContainer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            if (isExpanded)
              Text(
                widget.answer,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}



