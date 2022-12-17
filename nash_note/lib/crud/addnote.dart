import 'package:flutter/material.dart';

class Addnote extends StatefulWidget {
  const Addnote({Key? key}) : super(key: key);

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Note"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                maxLength: 30,
                decoration: InputDecoration(
                  // hintText: "Title",
                  labelText: "Title",
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    // borderSide: BorderSide(width: 2.0, color: Colors.red),
                  ),
                ),
              ),
              TextFormField(
                maxLines: 3,
                maxLength: 100,
                decoration: InputDecoration(
                  // hintText: "Title",
                  labelText: "Note",
                  prefixIcon: Icon(Icons.note),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    // borderSide: BorderSide(width: 2.0, color: Colors.red),
                  ),
                ),
              ),
              ElevatedButton(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Add Image",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                onPressed: () {
                  showBottomSheet();
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Save",
                      style: TextStyle(
                        fontSize: 22.0,
                        // fontWeight: FontWeight.w100,
                      )),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, 'homepage');
                },
              ),
            ],
          ),
        ),
      ),
    );
  } // end of build ();

  showBottomSheet() {
    double _mdqrWdth = MediaQuery.of(context).size.height;
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: _mdqrWdth / 4,
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Please Choose Image",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("gallery inkweel");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_album_outlined,
                          size: 30.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "From Gallery",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("camera inkweel");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_outlined,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "From Camera",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
