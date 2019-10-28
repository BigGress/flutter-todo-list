import 'package:flutter/material.dart';

class EditorPage extends StatelessWidget {
  String todoText;

  EditorPage({Key key, this.todoText}): super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('新增'),
      ),
      body: _EditorPage(todoText: this.todoText,),
    );
  }
}

class _EditorPage extends StatefulWidget {
  String todoText;

  _EditorPage({Key key, this.todoText}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditorState();
  }
}

class EditorState extends State<_EditorPage> {
  String text = '';
  TextEditingController textController;
  
  @override
  void initState() { 
    super.initState();
    print(this.widget.todoText);
    this.textController = new TextEditingController(
      text: this.widget.todoText,
    );
  }

  @override
  void dispose() {
    super.dispose();
    this.textController.dispose();
  }

  Widget renderEditor() {
    return Container(
      height: 100,
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      margin: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      child: TextField(
        maxLines: 4,
        controller: this.textController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '请输入...'
        ),
        // onChanged: (value) {
        //   print(value);
        //   this.text = value;
        // },
      ),
    );
  }

  Widget renderButton() {
    const paddingLeft = 3.0;
    const buttonPaddingLeft = 8.0;
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth - paddingLeft - buttonPaddingLeft) / 2 - 2.5;

    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: paddingLeft),
          child: new SizedBox(
            width: buttonWidth,
            child: new RaisedButton(
              textColor: Colors.white,
              color: Colors.blueAccent,
              // padding: EdgeInsets.only(right: 8.0),
              child: new Text('保存'),
              onPressed: () {
                print(this.textController.text);
                Navigator.pop(context, this.textController.text);
              },
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: buttonPaddingLeft),
          child: new SizedBox(
            width: buttonWidth,
            child: new RaisedButton(
              child: new Text('取消'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        this.renderEditor(),
        this.renderButton()
      ],
    );
  }
}