class Autenticacao{

  // static const urlBase = "http://192.168.2.12:8080/rest/api/oauth2/v1/token?grant_type=password&password=Oft3870515&username=jesse";
  static const urlBase = "http://192.168.2.12:8080/rest/api/oauth2/v1/token?grant_type=password&";
  static const usuario = 'jesse';
  static const senha   = 'Oft3870515';
  static const url     = urlBase + "password=${senha}&username=${usuario}";
}