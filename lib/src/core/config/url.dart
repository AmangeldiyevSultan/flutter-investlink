/// Server url.
enum Url {
  /// Dev url.
  dev('https://app1-eu-sw1.ivlk.io'),

  /// Prod url.
  prod('https://app1-eu-sw1.ivlk.io');

  const Url(this.value);

  /// Url value.
  final String value;
}

/// Server socket url.
enum SocketUrl {
  /// Dev url.
  dev('wss://ws-alp-sb1.investlink.io'),

  /// Prod url.
  prod('wss://ws-alp-sb1.investlink.io');

  const SocketUrl(this.value);

  /// Url value.
  final String value;
}
