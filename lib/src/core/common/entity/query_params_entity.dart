class QueryParamsEntity {
  const QueryParamsEntity({
    this.ticker,
    this.timePeriod,
  });
  final String? ticker;
  final String? timePeriod;

  Map<String, dynamic> toQuery() {
    final params = <String, dynamic>{};

    if (ticker != null) {
      params['ticker'] = ticker.toString();
    }
    if (timePeriod != null) {
      params['timePeriod'] = timePeriod.toString();
    }
    return params;
  }
}
