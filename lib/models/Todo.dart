enum FinishStatus {
  done,
  doing,
}


class Todo {
  String title;
  FinishStatus finish;

  Todo({ String title, FinishStatus finish }) {
    this.title = title;
    this.finish = finish;
  }
}