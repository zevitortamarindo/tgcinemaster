class UserData {
  UserData({
    this.name,
    this.email,
    this.filmesEscolhidos,
    this.servicosStreaming,
  });

  final String? name;
  final String? email;
  final List<String>? filmesEscolhidos;
  final List<String>? servicosStreaming;
}
