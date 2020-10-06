import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:red_button/providers/authorization.dart';
import 'package:provider/provider.dart';
import 'package:red_button/providers/emergency_contacts.dart';
import 'package:red_button/sign_in.dart';


List<Icon> iconList=[Icon(Icons.message),Icon(Icons.exit_to_app)];
List<String> titles=['DEFAULT MESSAGE','Logout'];
List<Function> functionList=[];
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800],
        title: Text('SETTINGS'),
        centerTitle: true,
      ),
      body: ListView.builder(itemBuilder: (ctx,i){
        return Column(
          children: [
            ListTile(
              onTap: (){
                if(i==1){
                  final box = Hive.box('cart');
              final keyList = box.keys.toList();
              for (int j = 0; j < keyList.length; j++) {
                Provider.of<Emergency>(context, listen: false)
                    .removeEmergencyContact(keyList[j]);
              }

              context.read<AuthenticationService>().signOut();
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (_) {
                return SignInPage();
              }));
                }
              } ,
              leading: iconList[i],
              title: Text(titles[i]),
            ),
            Divider()

          ],
        );

      },
      itemCount: titles.length,)
    );
  }
}
