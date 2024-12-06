class PaginationHelper {
  bool isLoading = false;
  String? nextUrl;

  bool shouldLoadMore() {
    return !isLoading && nextUrl != null;
  }

  void setLoading(bool loading) {
    isLoading = loading;
  }

  void setNextUrl(String? url) {
    nextUrl = url;
  }
}
