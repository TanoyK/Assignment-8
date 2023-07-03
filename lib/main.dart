import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{

  @override
  State<MyApp> createState() => AppState();

}

class AppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Management',
      home: MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}


class _MyHomeScreenState extends State<MyHomeScreen> {

  List<Task> assignTasks =[];


  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        title: Text("Task Management"),
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.white
        ),
        backgroundColor: Colors.blueGrey,
        elevation: 5,

      ),
      body:  ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10),
        itemCount: assignTasks.length,
        itemBuilder: (context,index){
    return ListTile(
      onLongPress: (){
        showTasksItemBottomSheet(
            assignTasks[index].title,
            assignTasks[index].description,
            assignTasks[index].deadline,index);
      },
      title: Text(assignTasks[index].title,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Text(
          assignTasks[index].description
        ),
      );

        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.add),
        onPressed: (){
          if(mounted) {
            showDialog(context: context, builder: (context) {
              return SingleChildScrollView(
                child: AlertDialog(
                  title: Text('Add Task'),
                  content: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TextField(
                          controller: _titleController,
                          onChanged: (value) {
                            setState(() {
                            });
                          },
                          decoration: InputDecoration(
                              labelText: "Title",
                              border: OutlineInputBorder()
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                            });
                          },
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: "Description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.blue,width:0.5 )

                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 40, horizontal: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                            });
                          },
                          controller: _deadlineController,
                          decoration: InputDecoration(
                              labelText: "Deadline",
                              border: OutlineInputBorder()
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: (){
                          if(_titleController.text.trim().isNotEmpty &&
                              _descriptionController.text.trim().isNotEmpty &&
                              _deadlineController.text.trim().isNotEmpty) {
                            assignTasks.add(Task(_titleController.text.trim(),
                                _descriptionController.text.trim(),
                                _deadlineController.text.trim()));

                            if (mounted) {
                              setState(() {});
                            }
                            _titleController.clear();
                            _descriptionController.clear();
                            _deadlineController.clear();
                            Navigator.pop(context);
                          }
                        }, child: const Text("Save")
                    ),
                  ],

                ),
              );
            },);

          }
        },
      ),

    );
  }

  void showTasksItemBottomSheet(String title, String description, String deadline, int index){
    showModalBottomSheet(context: context, builder: (context){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child:  Text("Task Details",style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Text("Title:$title"),
            Text("Description:$description"),
            Text("Deadline:$deadline"),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                  onPressed: (){
                    if(mounted){
                      assignTasks.removeAt(index);
                      Navigator.pop(context);
                      setState(() {

                      });
                    }

                  }, child: const Text("Delete")),
            )

          ],
        ),

    );
    }
    );

  }
}


class Task{
  String title, description, deadline;

  Task(this.title, this.description, this.deadline);
}
