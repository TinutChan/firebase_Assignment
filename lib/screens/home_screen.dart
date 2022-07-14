import 'package:firebase_assignment/models/people_model.dart';
import 'package:firebase_assignment/pages/create_people_page.dart';
import 'package:firebase_assignment/pages/detail_people_page.dart';
import 'package:firebase_assignment/services/people_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.shade900,
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey,
        child: Container(
          color: Colors.grey.shade200,
          child: RefreshIndicator(
            onRefresh: () {
              return Future.value();
            },
            child: StreamBuilder<List<PeopleModel>>(
              stream: PeopleService().getPeople(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.all(4.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.grey,
                                offset: Offset(0.3, 0.3),
                                spreadRadius: 10)
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '${snapshot.data!.length}',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          var data = snapshot.data![index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        DetailPeoplePage(people: data),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  data.photo ??
                                      'https://3znvnpy5ek52a26m01me9p1t-wpengine.netdna-ssl.com/wp-content/uploads/2017/07/noimage_person.png',
                                ),
                              ),
                              title: Text(data.name!),
                              subtitle: Text(data.numphone!),
                              trailing: Text(data.gender!),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Container(),
                        itemCount: snapshot.data!.length,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePeoplePage(),
            ),
          );
        },
      ),
    );
  }
}
