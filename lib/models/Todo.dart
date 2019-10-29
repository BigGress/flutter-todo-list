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

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "finish": this.finish == FinishStatus.doing ? 1 : 0
    };
  }
}