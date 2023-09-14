import 'package:creator_connect/features/auth/screens/signIn/screens/signin_screen.dart';
import 'package:creator_connect/features/auth/services/auth%20bloc/auth_bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:creator_connect/features/auth/services/auth%20bloc/auth_event.dart';
import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/services/auth bloc/auth_state.dart';

class BusinessHome extends StatefulWidget {
  static const String routeName = '/business-home-screen';
  const BusinessHome({super.key});

  @override
  State<BusinessHome> createState() => _BusinessHomeState();
}

class _BusinessHomeState extends State<BusinessHome> {
  final PageController controller = PageController(initialPage: 0);

  // ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  void _showMarkedAsDoneSnackbar(bool? isMarkedAsDone, String text) {
    if (isMarkedAsDone ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Marked as done! $text"),
      ));
    }
  }

  void _addProductToFirestore(
      String name, double price, String imageUrl) async {
    final db = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;

    final obj = <String, String>{
      'name': name,
      'price': price.toString(),
      'imageUrl': imageUrl,
    };
    await db
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection('Products')
        .doc()
        .set(obj)
        .then((value) {
      _showMarkedAsDoneSnackbar(true, "done");
    }).catchError((error) {
      print(error);
      _showMarkedAsDoneSnackbar(true, "failed");
    });
  }

  Future<void> _showAddProductDialog(BuildContext context) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Product Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                // Add the product to Firestore here
                // Use nameController.text and priceController.text to get the product details
                // Call a function to add the product to Firestore
                _addProductToFirestore(
                    nameController.text,
                    double.parse(priceController.text),
                    "https://images.unsplash.com/photo-1628076674561-6e9a0b56f2c3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2787&q=80");

                Navigator.of(context).pop();
              },
              child: Text('Add', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProductDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            // Navigate to the sign in screen when the user Signs Out
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (route) => false,
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome 👋🏻',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const Text(
                  'John Doe',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 26,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                const Text(
                  'Your Analytics',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.023,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnalyticsCard(
                      title: 'Total Sales',
                      value: '2.5M',
                    ),
                    AnalyticsCard(
                      title: 'Total Revenue',
                      value: '2.5M',
                    ),
                    AnalyticsCard(
                      title: 'Unique Users',
                      value: '2.5M',
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.033,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(auth.currentUser!.uid)
                        .collection('Products')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }

                      final products = snapshot.data!.docs;

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final productData =
                              products[index].data() as Map<String, dynamic>;

                          final name = productData['name'] as String;
                          final price =
                              double.parse(productData['price'].toString());
                          final imageUrl = productData['imageUrl'] as String;

                          return ProductCard(
                            name: name,
                            price: price,
                            imageUrl: imageUrl,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnalyticsCard extends StatelessWidget {
  final String title;
  final String value;
  const AnalyticsCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.022),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//function to delete from firebase
void _deleteProductFromFirestore(String name) async {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  db
      .collection("users")
      .doc(auth.currentUser!.uid)
      .collection('Products')
      .where('name', isEqualTo: name)
      .get()
      .then((value) {
    value.docs.forEach((element) {
      element.reference.delete();
    });
  });
}

class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final String imageUrl;

  ProductCard(
      {required this.name, required this.price, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        //alert dialog to delete from firebase
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete Product'),
              content:
                  const Text('Are you sure you want to delete this product?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {
                    _deleteProductFromFirestore(name);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Delete',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  imageUrl,
                  height: 140.0,
                  width: 140.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // SizedBox(height: 8.0),
            Text(name),
            Text('\$${price.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
