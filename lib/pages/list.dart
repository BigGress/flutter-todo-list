// 实现过滤功能, 已完成未完成

// 尝试共享数据

import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/pages/editor.dart';
import 'package:todo_list/service/localFile.dart';

import '../models/Todo.dart';

class TodoListWidget extends StatefulWidget {
  TodoListWidget({Key key, this.list}): super(key: key);

  List<Todo> list;

  @override
  TodoListState createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoListWidget> {

  Widget renderItem(Todo todo) {
    // List<Widget> actions = [
    //   Finish
    // ];
    bool isFinish = todo.finish == FinishStatus.done;
    TextStyle textStyle = TextStyle(
      decoration: isFinish ? TextDecoration.lineThrough : null,
    );

    // Widget popMenuButton = PopupMenuButton(child: Text('data'), on)
    return PopupMenuButton(
      child: Card(
        child:  ListTile(
          title: Text('${todo.title}', style: textStyle),
        ),
      ),
      itemBuilder: (BuildContext context) {
        return <PopupMenuItem>[
          PopupMenuItem(
            value: isFinish ? FinishStatus.doing : FinishStatus.done,
            child: Text(isFinish ? '重新开始' : '结束'),
          ),
          !isFinish ? PopupMenuItem(
            value: 'edit',
            child: Text('编辑'),
          ) : null,
        ];
      },
      onSelected: (dynamic status) async {
        
        if (status == FinishStatus.doing) {
          this.setState(() {
            todo.finish = FinishStatus.doing;
            writeTodo(this.widget.list);
          });
        } else if (status == FinishStatus.done) {
          this.setState(() {
            todo.finish = FinishStatus.done;
            writeTodo(this.widget.list);
          });
        } else {
          final text = await Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => EditorPage(todoText: todo.title,),
          ));

          this.setState(() {
            todo.title = text;
            writeTodo(this.widget.list);
          });
        }
      },
    );

    // return GestureDetector(
    //   child: Card(
    //     child:  ListTile(
    //       title: Text('${todo.title}', style: textStyle),
    //     ),
    //   ),
    //   onLongPress: () {
    //     double left = this.context.size.width;
    //     // double right = this.context.size.width;

    //     showMenu(
    //       context: this.context,
    //       position: RelativeRect.fromLTRB(0, 0, 0, 0),
    //       // position: RelativeRect.fill,
    //       items: <PopupMenuEntry>[
    //         PopupMenuItem(
    //           value: '123',
    //           child: Text('123'),
    //         )
    //       ]
    //     );
    //     // print('hahah');
    //   },
    //   // padding: EdgeInsets.all(0),
    //   // onPressed: () {
    //   //   this.setState(() {
    //   //     if (isFinish) {
    //   //       todo.finish = FinishStatus.doing;
    //   //     } else {
    //   //       todo.finish = FinishStatus.done;
    //   //     }
    //   //   });
    //   // },
    // );
  }

  Widget renderList() {
    List<Widget> items = this.widget.list.map((e) {
      return this.renderItem(e);
    }).toList();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return items[index];
      },
    );

    // return ListView(
    //   shrinkWrap: true,
    //   children: items,
    // );
  }

  @override
  Widget build(BuildContext context) {
    print(this.widget.list); 
    // TODO: implement build
    return Container(
      child: this.renderList()
    );
    // return Text('我是测试${this.widget.list.}');
  }
}