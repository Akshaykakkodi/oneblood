import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oneblood/screens/user_profile_screen.dart';
import 'package:oneblood/service/api.dart';

class Search_screen extends StatefulWidget {
  const Search_screen({Key? key}) : super(key: key);

  @override
  State<Search_screen> createState() => _Search_screenState();
}

class _Search_screenState extends State<Search_screen> {
  var data;
  TextEditingController blood = TextEditingController();
  Future getData() async {
    data = await SearchUsers.search(blood.text);

    return data;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: TextFormField(
              controller: blood,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey[50],
                  contentPadding: const EdgeInsets.all(10),
                  label: const Text('search blood group'),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: InkWell(
                  onTap: () {
                    getData();
                    setState(() {});
                  },
                  child: Icon(Icons.search)),
            )
          ],
        ),
        body: blood.text==null?
             Center(child: Lottie.asset('Assets/images/128040-searching.json'))
            : FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => User_profile_screen(
                                      id: snapshot.data[index]['login_id'],
                                    ),
                                  ));
                            },
                            child: ListTile(
                              tileColor: Colors.teal,
                              leading: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              title: Text(
                                snapshot.data[index]['name'],
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Text(
                                snapshot.data[index]['location'],
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    snapshot.data[index]['blood_group'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.water_drop,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }else{
                    return Center(child: Lottie.asset('Assets/images/128040-searching.json'));

                  }
                }));
  }
}
