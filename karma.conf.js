module.exports = function (config) {
  config.set({
    browsers: ['ChromeHeadless'],
    basePath: 'resources/assets',
    files: ['js/ci.js'],
    frameworks: ['cljs-test'],
    plugins: ['karma-cljs-test', 'karma-chrome-launcher'],
    colors: true,
    logLevel: config.LOG_INFO,
    failOnEmptyTestSuite: false,
    client: {
      args: ["shadow.test.karma.init"]
    }
  })
};
