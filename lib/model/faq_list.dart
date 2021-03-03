class FaqList{
  int id;
  String question;
  String answer;

  FaqList({this.id, this.question, this.answer});

  FaqList.fromJson(Map<String, dynamic> json) :
      id = json["id"],
      question = json["question"],
      answer = json["answer"];

  Map<String, dynamic> toJson() => {
    "id" : id,
  "question" : question,
  "answer" : answer
  };
}