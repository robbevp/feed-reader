export function throttle(callback, wait) {
  let timeout, context, args;
  let previous = 0;

  const later = () => {
    previous = Date.now();
    timeout = null;
    callback.apply(context, args);
    context = null;
    args = null;
  };

  const throttled = () => {
    const now = Date.now();
    const remaining = wait - (now - previous);
    context = this;
    args = arguments;
    if (remaining <= 0 || remaining > wait) {
      if (timeout) {
        clearTimeout(timeout);
        timeout = null;
      }
      previous = now;
      callback.apply(context, args);
    } else if (!timeout) {
      timeout = setTimeout(later, remaining);
    }
  };

  throttled.cancel = () => {
    clearTimeout(timeout);
    previous = 0;
    timeout = null;
    context = null;
    args = null;
  };

  return throttled;
}
