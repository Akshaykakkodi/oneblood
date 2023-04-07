import 'package:flutter/material.dart';
import 'package:oneblood/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit_profile_screen extends StatefulWidget {
  const Edit_profile_screen({Key? key}) : super(key: key);

  @override
  State<Edit_profile_screen> createState() => _Edit_profile_screenState();
}

class _Edit_profile_screenState extends State<Edit_profile_screen> {
  var id;
TextEditingController mobile= TextEditingController();

 Future getData() async {
   SharedPreferences spref=await SharedPreferences.getInstance();
   id=spref.getString("id");
    var data=await UserDetails.userData(id);
    mobile.text=data["mobile_no"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit',style: TextStyle(color: Colors.redAccent),),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasData){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(snapshot.data["name"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                )),
                Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(snapshot.data["email_id"],style: TextStyle(fontWeight: FontWeight.w300,fontSize: 18),),
                )),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 40, right: 40),
                  child: TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        contentPadding: const EdgeInsets.all(10),
                        prefixIcon: const Icon(
                          Icons.password_outlined,
                          color: Colors.red,
                        ),
                        label: const Text('password'),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 40, right: 40),
                  child: TextFormField(
                    controller: mobile,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        contentPadding: const EdgeInsets.all(10),
                        prefixIcon: const Icon(
                          Icons.phone_android_outlined,
                          color: Colors.red,
                        ),
                        label: const Text('Mobile number'),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(10)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(onPressed: () {

                  },child: Text("update",style: TextStyle(color: Colors.white),),backgroundColor: Colors.redAccent,),
                )
              ],
            );
          }else{
            return Center(child: Text("something went wrong"));
          }

        }
      ),
    );
  }
}
