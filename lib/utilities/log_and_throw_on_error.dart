import 'dart:developer';

logAndThrowOnError(error) {
  log("Something went wrong: $error");
  throw error;
}
