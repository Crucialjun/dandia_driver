class AddNewUserToDbParams {
  final String email;
  final String name;
  final String phone;
  final bool blockStatus;
  final String id;

  AddNewUserToDbParams(
      {required this.email,
      required this.name,
      required this.phone,
      required this.blockStatus,
      required this.id});
}
