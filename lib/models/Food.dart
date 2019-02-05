import 'package:intl/intl.dart';

class Food {

  String description, addedDate, limitDate, userUid, id;

  Food(this.id, this.description, this.limitDate, this.userUid){
    this.addedDate = new DateFormat('dd/MM/yyyy').format(new DateTime.now());
  }

  Food.fromJson(Map<String, dynamic> json){
    this.id = json["id"];
    this.description = json["description"];
    this.addedDate = json["added_date"];
    this.limitDate = json["limit_date"];
    this.userUid = json["user_uid"];
  }

  Map<String, dynamic> toJSON() => {
      "id": id,
      "description": description,
      "added_date": addedDate,
      "limit_date": limitDate,
      "user_uid": userUid,
    };

}