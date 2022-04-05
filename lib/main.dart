import 'package:complex_data/model/job_post.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<JobPost> listData = [];
  int? editIndex;
  TextEditingController titleFieldController = TextEditingController();
  TextEditingController descpFieldController = TextEditingController();
  //ScrollController _scrollController = ScrollController();
  bool scroll = false;

  @override
  void initState() {
    super.initState();
    /*_scrollController.addListener(() {
      print(_scrollController.offset);
      if (_scrollController.offset > 100) {
        setState(() {
          scroll = true;
        });
      }else{
        setState(() {
          scroll = false;
        });
        
        
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Listing ${scroll ? 'Enough' : ''}'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    TextField(
                        decoration: const InputDecoration(hintText: 'Title'),
                        controller: titleFieldController),
                    TextField(
                      decoration:
                          const InputDecoration(hintText: 'Description'),
                      controller: descpFieldController,
                    )
                  ],
                )),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (editIndex == null) {
                          listData.add(JobPost(titleFieldController.text,
                              descpFieldController.text));
                        } else {
                          var existingJobPost = listData[editIndex!];
                          existingJobPost.title = titleFieldController.text;
                          existingJobPost.desc = descpFieldController.text;
                          setState(() {
                            listData[editIndex!] = existingJobPost;
                            editIndex = null;
                          });
                        }
                        // [descpFieldController, titleFieldController]
                        //     .forEach((element) {
                        //   element.clear();
                        // });
                        descpFieldController.clear();
                        titleFieldController.clear();
                      });
                    },
                    child: Text(
                        '${editIndex != null ? "Update" : "Add"}Data'))
              ],
            ),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(microseconds: 250),
                color: scroll ? Colors.amberAccent : Colors.white,
                child: ListView.builder(
                    //controller: _scrollController,
                    itemCount: listData.length,
                    itemBuilder: (itemContext, index) {
                      return ListTile(
                        tileColor: Colors.red,
                        title: Text(listData[index].title),
                        subtitle: Text(listData[index].desc),
                        trailing: Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    listData.removeAt(index);
                                  });
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                )),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    titleFieldController.text =
                                        listData[index].title;
                                    descpFieldController.text =
                                        listData[index].desc;
                                    editIndex = index;
                                  });
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}
