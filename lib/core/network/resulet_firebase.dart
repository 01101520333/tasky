sealed class ResuletFirebase<T> {}

class Success<T> extends ResuletFirebase<T> {
  T data;
  Success(this.data);
}

class Error<T> extends ResuletFirebase<T> {
  String error;
  Error(this.error);
}
