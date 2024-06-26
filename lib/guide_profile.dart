import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localize_sl/screens/getStarted.dart';
import 'package:localize_sl/screens/users/user_settings.dart';
import 'package:localize_sl/screens/users/user_help.dart';
import 'package:localize_sl/screens/users/user_memories.dart';
import 'package:localize_sl/screens/users/user_wallet.dart';

class GuideProfilePage extends StatefulWidget {
  const GuideProfilePage({super.key});

  @override
  State<GuideProfilePage> createState() => _GuideProfilePageState();
}

class _GuideProfilePageState extends State<GuideProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  String? userRole;
  String userName = '';
  String userEmail = '';
  String userBio = '';

  Future<void> _fetchUserRole() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('user_role')) {
        setState(() {
          userRole = data['user_role'];
          userName = data['username'];
          userEmail = data['email'];
          userBio = data['bio'];
        });
      } else {
        print('User role not found in snapshot data');
      }
    } catch (e) {
      print('Error fetching user role: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  @override
  Widget build(BuildContext context) {
    if (userRole == 'Guide') {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'My Profile',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.only(right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/biru/profile.jpg'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      userEmail,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userBio,
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
                              MaterialPageRoute(
                                  builder: (context) => const WalletPage()),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                            ),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.white;
                                }
                                return const Color.fromARGB(255, 42, 150, 108);
                              },
                            ),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return const Color.fromARGB(
                                      255, 42, 150, 108);
                                }
                                return Colors.white;
                              },
                            ),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.account_balance_wallet),
                              Text('Wallet',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ActivityPage()),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                            ),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.white;
                                }
                                return const Color.fromARGB(255, 42, 150, 108);
                              },
                            ),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return const Color.fromARGB(
                                      255, 42, 150, 108);
                                }
                                return Colors.white;
                              },
                            ),
                          ),
                          child: const Column(
                            children: [
                              Icon(Icons.history),
                              Text('Portfolio',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HelpPage()),
                            );
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                            ),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.white;
                                }
                                return const Color.fromARGB(255, 42, 150, 108);
                              },
                            ),
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return const Color.fromARGB(
                                      255, 42, 150, 108);
                                }
                                return Colors.white;
                              },
                            ),
                          ),
                          child: const Column(
                            children: [
                              Icon(Icons.help),
                              Text(
                                'Help',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      height: 400, // Specify a fixed height for the GridView
                      child: MemoriesDisplay(),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  String userRole = '';
  String userName = '';
  String userEmail = '';

  Future<void> _fetchUserRole() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      // Cast snapshot.data() to Map<String, dynamic>?
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('user_role')) {
        setState(() {
          userRole = data['user_role'];
          userName = data['username'];
          userEmail = data['email'];
        });
      } else {
        print('User role not found in snapshot data');
        // Handle the case where user role is not found
      }
    } catch (e) {
      print('Error fetching user role: $e');
      // Handle error fetching user role
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserRole(); // Call _fetchUserRole in initState to fetch user data
  }

  // Build method remains the same
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 10),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/biru/profile.jpg'),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          userRole,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          userEmail,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {
                            // Implement logout functionality
                            // For example:
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => WelcomeScreen(),
                              ),
                              (route) => false,
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF2A966C)),
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
                const SizedBox(height: 60),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        _buildProfileBlock(
                          context,
                          title: 'Account Settings',
                          subtext: 'Change Name, Email, Password',
                          icon: Icons.man,
                          onTap: () {
                            // Navigate to account settings page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserSettingsPage(),
                              ),
                            );
                          },
                        ),
                        _buildProfileBlock(
                          context,
                          title: 'Need Help?',
                          subtext: 'Chat with a customer care agent',
                          icon: Icons.help,
                          onTap: () {
                            // Navigate to help page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NeedHelpPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildProfileBlock(
  BuildContext context, {
  required String title,
  required String subtext,
  required IconData icon,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ProfileBlock(
        title: title,
        subtext: subtext,
        icon: icon,
      ),
    ),
  );
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
        color: _isHovered
            ? const Color.fromARGB(255, 42, 150, 108)
            : const Color.fromARGB(255, 235, 235, 235),
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
            color: const Color.fromARGB(
                255, 42, 150, 108), // Set icon color to white
          ),
          const SizedBox(height: 10),
          Text(
            widget.title,
            style: const TextStyle(
              color:
                  Color.fromARGB(255, 42, 150, 108), // Set text color to white
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.subtext,
            style: const TextStyle(
              color:
                  Color.fromARGB(255, 42, 150, 108), // Set text color to white
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Porfolio'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
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
              const SizedBox(height: 8),
              Row(
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
                    image: AssetImage(
                        'assets/biru/place_image.jpg'), // Replace with actual image path
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
                      return const Color.fromARGB(255, 42, 150,
                          108); // Change button color when pressed
                    } else if (states.contains(MaterialState.hovered)) {
                      return Colors.white; // Change button color when hovered
                    }
                    return const Color.fromARGB(
                        255, 42, 150, 108); // Use default color
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color.fromARGB(255, 42, 150,
                          108); // Change button color when pressed
                    } else if (states.contains(MaterialState.hovered)) {
                      return const Color.fromARGB(255, 42, 150,
                          108); // Change button color when hovered
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
    final TextEditingController _controller = TextEditingController();

    void _handleSubmit() {
      // Display the SnackBar message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              "Successfully received your question and we'll get back to you shortly"),
        ),
      );

      // Clear the text input field
      _controller.clear();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                        'Go to settings on your profile and click on Account Settings',
                  ),
                  FAQContainer(
                    question: 'How do I contact customer support?',
                    answer:
                        'Go to settings on your profile and click on Need Help?',
                  ),
                  // Add more FAQContainers as needed
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Ask me anything',
                  ),
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: _handleSubmit,
                icon: const Icon(Icons.send),
                label: const Text('Submit'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return const Color.fromARGB(
                            255, 42, 150, 108); // Green background when hovered
                      }
                      return Colors.white; // Default background color
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.white; // White text color when hovered
                      }
                      return const Color.fromARGB(
                          255, 42, 150, 108); // Default text color
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
