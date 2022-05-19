

import 'package:flutter/material.dart';
class editPlaylist extends StatefulWidget {
  const editPlaylist({ Key? key }) : super(key: key);

  @override
  State<editPlaylist> createState() => _editPlaylistState();
}

class _editPlaylistState extends State<editPlaylist> {

    final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
                 context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  child: Text("Submitß"),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Text("Open Popup"),
        ),
      );
    
  }
}

