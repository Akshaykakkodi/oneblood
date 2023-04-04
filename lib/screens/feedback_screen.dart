import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oneblood/service/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Feedback_screen extends StatefulWidget {
  const Feedback_screen({Key? key}) : super(key: key);

  @override
  State<Feedback_screen> createState() => _Feedback_screenState();
}

class _Feedback_screenState extends State<Feedback_screen> {
  TextEditingController feedBack = TextEditingController();
  var id;
  var data;
Future  getData() async {
    SharedPreferences spref =await SharedPreferences.getInstance();
    id= spref.getString('id');
    data= await GetNotification.getData();
    return data;

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Feedback',style: TextStyle(color: Colors.red),),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 350,
            child: FutureBuilder(
              future: getData(),
              builder: (context,snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }
                if(snapshot.hasData && snapshot.data!=null){
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          color: Colors.redAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ExtendedImage.network(
                                      Service.baseUrl+snapshot.data[index]['image'],
                                      height: 150,
                                      shape: BoxShape.rectangle,
                                      fit: BoxFit.fill,

                                      cache: true,
                                      border: Border.all(color: Colors.red, width: 1.0),

                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                      //cancelToken: cancellationToken,
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                    snapshot.data[index]['feedback'],maxLines: 7,style: TextStyle(fontStyle: FontStyle.italic,color: Colors.white,fontSize: 18),),
                                  )
                                ],
                              ),
                              // height: 300,
                              width: 200,
                            ),
                          ),
                        ),
                      );
                    },);
                }else{
                  return Text("No data");
                }

              }
            ),

          ),
          SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: feedBack,
                maxLines: 10,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () async {
                     var dat=  await FeedBack.insertFeedback(id, feedBack.text);
                     if(dat=true){
                       feedBack.clear();
                       Fluttertoast.showToast(msg: 'Send');
                     }else{
                       Fluttertoast.showToast(msg: 'Something went wrong');
                     }

                      },
                        child: Icon(Icons.send)),
                    hintText:"Enter your feed back",
                    contentPadding: EdgeInsets.all(30),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
