/* eslint-disable max-statements */

export default {
  log<T>(message: T): T {
    console.log(message);
    return message;
  },
  error<T>(message: T): T {
    console.error(message);
    return message;
  }
};
