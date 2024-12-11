import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:virtualclassroomhub/ui/TeacherScreens/VideoLectures/create_access_class.dart';
import 'package:virtualclassroomhub/widgets/heading_container.dart';
import 'package:virtualclassroomhub/widgets/module_card.dart';

import '../auth/login_screen.dart';

class TeacherDashboard extends StatelessWidget {
  final List<Map<String, String>> modules = [
    {'name': 'Live Class', 'image': 'images/liveclass.jpeg'},
    {'name': 'Upload Lectures', 'image': 'images/videolecture.jpeg'},
    {'name': 'Generate Quiz', 'image': 'images/quiz.jpeg'},
    {'name': 'Discussion Forum', 'image': 'images/discussionform.jpeg'},
  ];

  final _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            _auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            }).onError((error,stackTrace){
              print(error);
            });
          },
              icon: Icon(Icons.logout_outlined)),
          SizedBox(width: 10,)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            // Welcome text
            HeadingContainer(title: 'Welcome To Teachers Dashboard'),
            SizedBox(height: 60), // Space between the text and the grid
            // Expanded widget to contain the GridView
            Expanded(
              child: GridView.builder(
                itemCount: modules.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 40,
                  childAspectRatio: 2 /2.7 ,
                ),
                itemBuilder: (context, index) {
                  return ModuleCard(
                    moduleName: modules[index]['name']!,
                    imagePath: modules[index]['image']!,
                    onTap: () {
                      // Use switch statement to navigate based on module clicked
                      switch (modules[index]['name']) {
                        case 'Live Class':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeacherDashboard(), // Replace with the actual Live Class screen
                            ),
                          );
                          break;
                        case 'Upload Lectures':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateAccessClass(), // Replace with your Upload Lectures screen
                            ),
                          );
                          break;
                        case 'Generate Quiz':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeacherDashboard(), // Replace with your Generate Quiz screen
                            ),
                          );
                          break;
                        case 'Discussion Forum':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeacherDashboard(), // Replace with your Discussion Forum screen
                            ),
                          );
                          break;
                        default:
                        // Handle any unexpected cases
                          break;
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
