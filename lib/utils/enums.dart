enum LoadMoreStatus { none, fetching, failed }

enum BlocConnectionStatus {
  initialized,
  loading,
  success,
  failed,
  empty;

  bool isInitialized() {
    return this == BlocConnectionStatus.initialized;
  }

  bool isLoading() {
    return this == BlocConnectionStatus.loading;
  }

  bool isSuccess() {
    return this == BlocConnectionStatus.success;
  }

  bool isFailed() {
    return this == BlocConnectionStatus.failed;
  }

  bool isEmpty() {
    return this == BlocConnectionStatus.empty;
  }

  bool isInitializedOrLoading() {
    return isInitialized() || isLoading();
  }

  bool isEmptyOrLoading() {
    return isEmpty() || isLoading();
  }
}
