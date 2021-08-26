class UserModel{
  const UserModel({
    required this.name,
    required this.id,
    required this.email,
    this.imgUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTv7Qrvj5xHRuCCDSoqi9U-IqESntWh4bMG5w&usqp=CAU',
  });

  final name;
  final id;
  final email;
  final imgUrl;
}