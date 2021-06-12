import 'package:flutter/material.dart';

import 'Db.dart';

class ListAppointmentPage extends StatefulWidget {
  int id;
  ListAppointmentPage(this.id);

  @override
  _ListAppointmentPageState createState() => _ListAppointmentPageState();
}

class _ListAppointmentPageState extends State<ListAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Appointments"),
      ),
      body:FutureBuilder(
          future: DatabaseHelper.showAppointmentUser(widget.id),
          builder: (context, AsyncSnapshot snapshot){
            if (snapshot.data == null) {
              print("null");
              return Container();
            } else if (snapshot.hasError) {
              print("haserror");
              return Icon(
                Icons.error,
                size: 110,
              );
            } else{
              return ListView.separated(
                  itemCount: snapshot.data[0].length,
                  separatorBuilder: (BuildContext context, int index) => Divider(height: 2, color: Colors.transparent),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(snapshot.data[1][index][0]["u_name"]),
                        subtitle:Text(snapshot.data[0][index]["a_date"]),
                        isThreeLine: true,
                        trailing: IconButton(onPressed: (){
                            setState(() {
                              DatabaseHelper.cancelAppointment(snapshot.data[0][index]["user_id"], snapshot.data[1][index][0]["user_id"], snapshot.data[0][index]["a_date"]);
                            });



                        }, icon: Icon(Icons.cancel_outlined)),
                      ),
                    );
                      //dieticianCard("Dietitian ${snapshot.data[index]["u_name"]}  ${snapshot.data[index]["u_surname"]} ", 100, "İstanbul", size,  context, 'asset/1.jpg',snapshot.data[index]["dietatian_id"]);
                  }
              );
            }
          }
      ),
    );
  }
}
