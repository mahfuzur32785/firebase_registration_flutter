import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width*0.7,
        height: MediaQuery.of(context).size.height*1,
        child: Drawer(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color(0xFF312E52),
                        image: DecorationImage(
                            image: AssetImage("assets/images/splash_img/sahjahan_info.png",),
                            fit: BoxFit.cover,
                        ),
                    ),
                    child: Text("Header"),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView(children: [
                  Card(
                    child: ListTile(
                      title: Text("Share",style: TextStyle(color: Colors.grey.shade700),),
                      leading: Icon(Icons.share,color: Colors.grey.shade600,),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text("Rating & Review",style: TextStyle(color: Colors.grey.shade700),),
                      leading: Icon(Icons.rate_review,color: Colors.grey.shade600,),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text("About",style: TextStyle(color: Colors.grey.shade700),),
                      leading: Icon(Icons.info_outline,color: Colors.grey.shade600,),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
