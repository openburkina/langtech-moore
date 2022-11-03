class Urls {
  // static const String API_BASE_URL = 'http://178.128.248.138:8081/api';
  static const String API_BASE_URL = 'http://localhost:8080/api';
  static const String LOGIN_URL = API_BASE_URL + '/authenticate';
  static const String REGISTER_URL = API_BASE_URL + '/register';
  static const String SOURCES_DATA_URL = API_BASE_URL + '/source-donnees';
  static const String GET_ALL_TRADUCTIONS =
      API_BASE_URL + '/traductions/criteria';
  static const String DEFAULT_TRADUCTION_URL = API_BASE_URL + '/traductions';
  static const String LANGUES = API_BASE_URL + '/langues';
}
