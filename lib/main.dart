//import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:device_apps/device_apps.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BouncingScrollPhysics _bouncingScrollPhysics = BouncingScrollPhysics();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(221, 39, 39, 39),
        child: PageView(
          children: <Widget>[
            Container(
              child: Center(
                child: Text(
                  "Synasthesia",
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
              ),
            ),
            FutureBuilder(
              future: DeviceApps.getInstalledApplications(
                  includeAppIcons: true,
                  includeSystemApps: true,
                  onlyAppsWithLaunchIntent: true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final List<Application> allApps = snapshot.data!;
                  return ListView(
                     scrollDirection: Axis.vertical,
                    physics: _bouncingScrollPhysics,
                    // itemCount: allApps.length,
                    // itemBuilder: (context, index) {
                    // return  ListTile(
                    //     //leading: Image.memory(allApps[index].icon, width: 50, height: 50,),
                    //     title: Text(allApps[index].appName,
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 30,
                    //         )
                    //         ),
                    //   );
                    // },
                    // separatorBuilder: (context, index) {
                    //   return Divider(
                    //     color: Color.fromARGB(0, 255, 255, 255),
                    //   );
                    // },
                   
                    children: List.generate(allApps.length, (index){
                      return GestureDetector(
                        onTap: (){
                          DeviceApps.openApp(allApps[index].packageName);
                        },
                        child: Row(
                          children: <Widget>[
                           //Image.memory(allApps[index].icon, width: 50, height: 50,),
                            Text(
                            allApps[index].appName,
                            style: TextStyle(color: Colors.white , fontSize: 30,)
                            ),
                          ],
                        ),
                      );
                    }),
                  );
                }
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
