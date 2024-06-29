import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _accNoController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _branchNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Details'),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.green));
          }

          final List<DocumentSnapshot> users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, userIndex) {
              final userAccountsCollection = _firestore
                  .collection('users')
                  .doc(users[userIndex].id)
                  .collection('accounts');

              return StreamBuilder<QuerySnapshot>(
                stream: userAccountsCollection.snapshots(),
                builder:
                    (context, AsyncSnapshot<QuerySnapshot> accountsSnapshot) {
                  if (accountsSnapshot.hasError) {
                    return const Center(child: Text('Error fetching accounts'));
                  }

                  if (accountsSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.green));
                  }

                  final List<DocumentSnapshot> accounts =
                      accountsSnapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: accounts.length,
                    itemBuilder: (context, accountIndex) {
                      final account = accounts[accountIndex];
                      return ListTile(
                        title: Text('Account ${accountIndex + 1}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Account Number: ${account['acc_no']}'),
                            Text('Bank Name: ${account['bank_name']}'),
                            Text('Branch Name: ${account['branch_name']}'),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          itemBuilder: (context) => [
                            const PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit Account'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'delete',
                              child: Text('Delete Account'),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'edit') {
                              _showEditForm(account);
                            } else if (value == 'delete') {
                              _deleteAccount(
                                  account.id, userAccountsCollection);
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddForm();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showEditForm(DocumentSnapshot account) {
    // Navigate to edit form with account details
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Edit Account'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _accNoController..text = account['acc_no'],
                  decoration:
                      const InputDecoration(labelText: 'Account Number'),
                ),
                TextFormField(
                  controller: _bankNameController..text = account['bank_name'],
                  decoration: const InputDecoration(labelText: 'Bank Name'),
                ),
                TextFormField(
                  controller: _branchNameController
                    ..text = account['branch_name'],
                  decoration: const InputDecoration(labelText: 'Branch Name'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement update logic here
                    _updateAccount(account.id, account.reference.parent);
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _deleteAccount(
      String accountId, CollectionReference userAccountsCollection) async {
    try {
      await userAccountsCollection.doc(accountId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account deleted successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete account: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showAddForm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _accNoController,
              decoration: const InputDecoration(labelText: 'Account Number'),
            ),
            TextFormField(
              controller: _bankNameController,
              decoration: const InputDecoration(labelText: 'Bank Name'),
            ),
            TextFormField(
              controller: _branchNameController,
              decoration: const InputDecoration(labelText: 'Branch Name'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              _addAccount();
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addAccount() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      // Reference to the user's specific 'accounts' collection
      CollectionReference userAccountsCollection =
          _firestore.collection('users').doc(user.uid).collection('accounts');

      // Add account data to the user's 'accounts' collection
      await userAccountsCollection.add({
        'acc_no': _accNoController.text,
        'bank_name': _bankNameController.text,
        'branch_name': _branchNameController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account added successfully'),
        ),
      );

      // Clear input fields after adding
      _accNoController.clear();
      _bankNameController.clear();
      _branchNameController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add account: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _updateAccount(
      String accountId, CollectionReference userAccountsCollection) async {
    try {
      await userAccountsCollection.doc(accountId).update({
        'acc_no': _accNoController.text,
        'bank_name': _bankNameController.text,
        'branch_name': _branchNameController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account updated successfully'),
        ),
      );
      Navigator.of(context).pop(); // Close edit form after update
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update account: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _accNoController.dispose();
    _bankNameController.dispose();
    _branchNameController.dispose();
    super.dispose();
  }
}
