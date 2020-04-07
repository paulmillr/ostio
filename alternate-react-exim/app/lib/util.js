const unescape = {
  "&amp;": "&",
  "&lt;": "<",
  "&gt;": ">",
  "&quot;": '"',
  "&#x27;": "'",
  "&#x60;": "`"
};

const unBadChars = /&(?:amp|lt|gt|quot|#x27|x60);/g
const unPossible = /&(?:amp|lt|gt|quot|#x27|x60);/
const unescapeChar = chr => unescape[chr] ? unescape[chr] : '&';

const escape = {
  "&": "&amp;",
  "<": "&lt;",
  ">": "&gt;",
  '"': "&quot;",
  "'": "&#x27;",
  "`": "&#x60;"
};

const badChars = /[&<>"'`]/g;
const possible = /[&<>"'`]/;
const escapeChar = chr => escape[chr] ? escape[chr] : '&';

const escapeExpression = string => {
  if (!string) {
    return '';
  } else if (!possible.test(string)) {
    return string;
  } else {
    return string.replace(badChars, escapeChar);
  }
};

const unescapeExpression = string => {
  if (!string) {
    return '';
  } else if (!unPossible.test(string)) {
    return string;
  } else {
    return string.replace(unBadChars, unescapeChar);
  }
};

export {escapeExpression, unescapeExpression};
