import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:interviewmodel/apicalls.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<Api>> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: FutureBuilder<List<Api>>(
              future: futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final users = snapshot.data;
                  if (users != null) {
                    return ListView.separated(
                      itemCount: users.length,
                      separatorBuilder: (context, index) =>
                          const Divider(thickness: 3),
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return SizedBox(
                          child: (Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(
                                children: [
                                  SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset('asset/bear.jpg')),
                                  Column(
                                    children: [
                                      Text('${user.ticker}'),
                                      Text('${user.noOfComments}')
                                    ],
                                  ),
                                  Text('${user.sentimentScore}'),
                                ],
                              ),
                            ],
                          )),
                        );
                      },
                    );
                  } else {
                    return const Text('user data not found');
                  }
                } else {
                  return Text('Has no data: ${snapshot.hasError}');
                }
              }),
        ),
      ),
    );
  }

  Future<List<Api>> fetchUser() async {
    final response =
        await http.get(Uri.parse('https://tradestie.com/api/v1/apps/reddit'));
    if (response.statusCode == 200) {
      final List<dynamic> usersData = jsonDecode(response.body);
      final users = usersData.map((user) => Api.fromJson(user)).toList();
      return users;
    } else {
      throw Exception('failed to get user');
    }
  }
}
