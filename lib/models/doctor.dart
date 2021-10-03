
class Doctor{
  final String uid;
  final String name;
  final String email;
  final String? specialization;
  final String? description;

  Doctor({
    required this.uid,
    required this.name, 
    required this.email, 
    this.specialization, 
    this.description
  });

  static Doctor  formJson(json)=>Doctor(
    uid: json['uid'],
    name: json['name'], 
    email: json['email'],
    specialization:  json['specialization']?? 'none',
    description:  json['description']?? 'No description.'
  );

  Map<String,Object> toJson()=>{
    'uid' : uid,
    'name' : name,
    'email' : email,
    'specialization' : specialization?? 'none',
    'description' : description?? 'No description.',
  };

  

  
}