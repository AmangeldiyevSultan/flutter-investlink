class ApiPath {
  const ApiPath._();

  ///* Auth
  static const String login = '/auth_db/login/';

  ///* Stock Search
  static const String stockSearch = '/proxy_api/v1/polygon/tickers_currency';
}

class DatabasePath {
  const DatabasePath._();

  ///* Favorites
  static const String favoriteTickers = 'favorite-tickers';
}
