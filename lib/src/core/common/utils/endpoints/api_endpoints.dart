class ApiPath {
  const ApiPath._();

  ///* Auth
  static const String login = '/auth_db/login/';

  ///* Stock Search
  static const String stockSearch = '/proxy_api/v1/polygon/tickers_currency';

  ///* Ticker History
  static const String tickerHistory = '/proxy_api/v1/polygon/ticker_history';
}

class DatabasePath {
  const DatabasePath._();

  ///* Favorites
  static const String favoriteTickers = 'favorite-tickers';
}

class WebSocketPath {
  const WebSocketPath._();

  ///* Favorites
  static const String connection = '/ws/stocks/';
}
