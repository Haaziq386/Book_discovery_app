import 'constants.dart';

class PaginationHelper {
  bool isLoading = false;
  String? nextUrl = baseUrl;

  bool shouldLoadMore() {
    return !isLoading && nextUrl != null;
  }

  void setLoading(bool loading) {
    isLoading = loading;
  }

  String? setNextUrl(String? url) {
    return nextUrl = url;
  }
}
