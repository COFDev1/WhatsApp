class Autenticacao {
  static const urlBase = "http://192.168.2.12:8083/rest/";
  static const usuario = 'jesse';
  static const senha = 'Oft3870515';
  static const urlLogin = urlBase +
      "api/oauth2/v1/token?grant_type=password&password=${senha}&username=${usuario}";
}
