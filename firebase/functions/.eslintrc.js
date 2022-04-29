module.exports = {
  "root": true,
  "env": {
    "es6": true,
    "node": true,
  },
  "parserOptions": {
    "ecmaVersion": 8,
  },
  "extends": [
    "eslint:recommended",
    "google",
  ],
  "rules": {
    "require-jsdoc": 0,
    "linebreak-style": 0,
    "quotes": ["error", "double"],
  },
};

