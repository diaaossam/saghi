class AudioModel {
  String ? id;
  String ? userId;
  String ? link;
  bool ? isFav;
  String ? text;

  AudioModel(this.id, this.userId, this.link, this.isFav,this.text);


  AudioModel.fromJson({required Map<String, dynamic> map}){
    id = map["id"];
    userId = map["userId"];
    link = map["link"];
    isFav = map["isFav"];
    text = map["text"];
  }

  Map<String,dynamic> toMap(){
    return {
      "id":id,
      "userId":userId,
      "link":link,
      "isFav":isFav,
      "text":text,
    };
  }
}