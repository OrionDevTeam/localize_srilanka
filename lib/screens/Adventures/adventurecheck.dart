import 'package:flutter/material.dart';

class AdventureHomePage extends StatelessWidget {
  final Map<String, dynamic> provider;

  AdventureHomePage({required this.provider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
                SizedBox(width: 25),
                Text(
                  'Surf with ${provider['name']} !',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                provider['titleImageUrl'],
                fit: BoxFit.cover,
                height: 161,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 161,
                    color: Colors.grey,
                    child: Center(
                      child: Icon(Icons.error),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Row(
                    children: [
                      Text(
                        'LKR ',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      Text(
                        provider['rate'].toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        ' / hour',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    // Implement booking functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[400],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              '${provider['about']}',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
