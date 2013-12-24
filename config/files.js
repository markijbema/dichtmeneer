/* Exports a function which returns an object that overrides the default &
 *   plugin file patterns (used widely through the app configuration)
 *
 * To see the default definitions for Lineman's file paths and globs, see:
 *
 *   - https://github.com/testdouble/lineman/blob/master/config/files.coffee
 */
module.exports = function(lineman) {
  //Override file patterns here
  return {

    js: {
      vendor: [
        "vendor/bower/jquery/jquery.js",
        "vendor/bower/underscore/underscore.js",
        "vendor/bower/underscore.string/lib/underscore.string.js",
        "vendor/bower/reactive-coffee/reactive-coffee.js"
      ]
    }

  };
};
