class Barkodlar{

  int? _id;
  String? b_name;
  String? date;


  Barkodlar(this.b_name, this.date);

  Barkodlar.WithID(this._id, this.b_name, this.date);


  Map<String,dynamic> dbYazmak(){
    var map=Map<String,dynamic>();
    map['id']=_id;
    map['b_name']=b_name;
    map['date']=date;
    return map;
  }

  Barkodlar.dbdenOkumak(Map<String,dynamic> map){
    this._id=map['id'];
    this.b_name=map['b_name'];
    this.date=map['date'];
  }

  @override
  String toString() {
    return 'Barkodlar{_id: $_id, _b_name: $b_name, _date: $date}';
  }
}
