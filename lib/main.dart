import 'package:flutter/material.dart';
import 'package:todo_list/pages/editor.dart';

import './pages/list.dart';
import './models/Todo.dart';

void main() => runApp(MyApp());

List<Todo> mockData = [
  new Todo(title: '测试1', finish:  FinishStatus.doing),
  new Todo(title: '测试2', finish:  FinishStatus.done),
  new Todo(title: '测试3'),
  new Todo(title: '测试4', finish:  FinishStatus.done),
];

createButton(String text,Function() fn, {Color color}) {
  // return Expanded(child: RaisedButton(
  //   child: Text(text),
  //   onPressed: fn,
  // ),);
  Widget child = RaisedButton(
    child: Text(text),
    color: color,
    onPressed: fn,
  );
  return Expanded(
    child: Container(
      height: 44,
      child: child,
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  FinishStatus activeStatus;

  List<Todo> list = [
    new Todo(title: '测试1', finish:  FinishStatus.doing),
    new Todo(title: '测试2', finish:  FinishStatus.done),
    new Todo(title: '测试3'),
    new Todo(title: '测试4', finish:  FinishStatus.done),
  ];

  void _incrementCounter() async {
    String todoData = await Navigator.push(context, MaterialPageRoute(
      builder: (context) => EditorPage(),
    ));

    print('newTodoData: $todoData');
    if (todoData != null) {
      this.addItem(todoData);
    }
  }

  void addItem(String title) {
    Todo todo = new Todo(title: title, finish: FinishStatus.doing);
    Iterable<Todo> hasTodo = this.list.where((e) => e.title == todo.title);
    if (hasTodo.length == 0) {
      this.setState(() {
        // List newList = this.list.toList();
        this.list.add(todo);
        // this.list = newList;
        print(this.list);
      });
    }

    // TODO: 添加已经存在的toast
  }

  void removeItem(Todo item) {
    if (item != null) {
      this.list.remove(item);
    }
  }

  void toggleItemStatus(Todo item) {
    if (item != null) {
      if (item.finish == FinishStatus.doing) {
        item.finish = FinishStatus.done;
      } else {
        item.finish = FinishStatus.doing;
      }
    }
  }

  List<Todo> getList([FinishStatus status]) {
    // TODO: 这里是测试, 记得放开
    var list = this.list;
    if (status == FinishStatus.doing) {
      return list.where((e) => e.finish == FinishStatus.doing).toList();
    } else if (status == FinishStatus.done) {
      return list.where((e) => e.finish == FinishStatus.done).toList();
    }

    return list;
  }

  // 按钮列表
  Widget renderButtonList() {
    List<Widget> buttons = [
      // 5eb7b7
      createButton('全部', () {
        this.setState(() {
          this.activeStatus = null;
        });
      }),
      createButton('正在进行', () {
        this.setState(() {
          this.activeStatus = FinishStatus.doing;
        });
      }),
      createButton('结束', () {
        this.setState(() {
          this.activeStatus = FinishStatus.done;
        });
      }),
    ];
    // List<Widget> buttons = FinishStatus.values.map((status) {
    //   final text = Text(status == FinishStatus.doing ? '正在进行' : '结束');
    //   return RaisedButton(
    //     child: text,
    //     onPressed: () {
    //       this.activeStatus = status;
    //     },
    //   );
    // }).toList();
    // buttons.insert(0, RaisedButton(
    //   child: Text('全部'),
    //   onPressed: () {
    //     this.activeStatus = null;
    //   },
    // ));
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: buttons
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> renderList = this.getList(this.activeStatus);
    print(renderList);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            this.renderButtonList(),
            // Text(
            //   'Test: ${this.list.length}',
            // ),
            TodoListWidget(list: renderList,),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.display1,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
