import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";

  final List<Map<String, dynamic>> _influencers = [
    {
      'name': 'Elsa',
      'age': '24',
      'category': 'Fashion',
      'followers': '1.2M',
      'engagement': '5%',
      'gender': 'Female',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
    {
      'name': 'Jane',
      'age': '24',
      'category': 'Fashion',
      'followers': '1.2M',
      'engagement': '5%',
      'gender': 'Female',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
    {
      'name': 'Alan',
      'age': '24',
      'category': 'Food & Drink',
      'followers': '1.2M',
      'engagement': '5%',
      'gender': 'Male',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
    {
      'name': 'ilean',
      'age': '24',
      'category': 'Fashion',
      'followers': '1.2M',
      'engagement': '5%',
      'gender': 'Male',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
    {
      'name': 'Julian',
      'age': '28',
      'category': 'Food & Drink',
      'followers': '1.2M',
      'engagement': '5%',
      'gender': 'Male',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
    {
      'name': 'Bella',
      'age': '21',
      'category': 'Travel',
      'followers': '1.2M',
      'engagement': '5%',
      'gender': 'Female',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
    {
      'name': 'Vdant',
      'age': '24',
      'category': 'Gym influencer',
      'followers': '1.2M',
      'engagement': '5%',
      'gender': 'Male',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
    {
      'name': 'Sneha',
      'age': '24',
      'category': 'Fashion',
      'followers': '1.2M',
      'engagement': '5%',
      'gender': '10%',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
    {
      'name': 'Shreya',
      'age': '24',
      'category': 'Business',
      'followers': '1.2M',
      'engagement': '50%',
      'gender': 'Female',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
    {
      'name': 'Parth',
      'age': '24',
      'category': 'Forbes25Under25',
      'followers': '1.2M',
      'engagement': '38%%',
      'gender': 'Male',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
    {
      'name': 'Giya',
      'age': '24',
      'category': 'Business',
      'followers': '1.2M',
      'engagement': '24%',
      'gender': 'Female',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
    {
      'name': 'Elsa',
      'age': '24',
      'category': 'Fashion',
      'followers': '1.2M',
      'engagement': '5%',
      'gender': '10%',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
    {
      'name': 'Gooober',
      'age': '24',
      'category': 'Artist',
      'followers': '1.2M',
      'engagement': '20%',
      'gender': 'Male',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
    {
      'name': 'Chaitanya',
      'age': '24',
      'category': '25Under25',
      'followers': '1.2M',
      'engagement': '37%',
      'gender': 'Male',
      'image':
          'https://images.unsplash.com/photo-1610737234961-9fce52860989?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80'
    },
  ];

  void addToFirebase() async {
    for (var data in _influencers) {
      FirebaseFirestore.instance.collection("Search").add(data);
    }
  }

  @override
  void initState() {
    super.initState();
    addToFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Card(
            child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search...'),
              onChanged: (value) => {
                setState(
                  () {
                    searchQuery = value;
                  },
                ),
              },
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Search").snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.toString().length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;
                      if (searchQuery.isEmpty) {
                        return ListTile(
                          title: Text(data['name']),
                          subtitle: Text(data['category']),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['image']),
                          ),
                        );
                      }
                      if (data['name']
                          .toString()
                          .toLowerCase()
                          .contains(searchQuery.toLowerCase())) {
                        return ListTile(
                          title: Text(data['name']),
                          subtitle: Text(data['category']),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(data['image']),
                          ),
                        );
                      }
                      return Container();
                    },
                  );
          },
        ));
  }
}
