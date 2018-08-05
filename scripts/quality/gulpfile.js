'use strict';

// Load Gulp and tools we will use.
var $        = require('gulp-load-plugins')(),
  gulp       = require('gulp');

var projectRootDir = '../..';
var sourceDir = projectRootDir + '/www';

// CSS.
var cssFiles = [
  sourceDir + '/**/*.css',
  '!' + sourceDir + '/**/*.min.css',
  '!' + sourceDir + '/**/node_modules/**/*',
  '!' + sourceDir + '/**/bower_components/**/*',
  '!' + sourceDir + '/core/**/*',
  '!' + sourceDir + '/libraries/**/*',
  '!' + sourceDir + '/modules/contrib/**/*',
  '!' + sourceDir + '/profiles/contrib/**/*',
  '!' + sourceDir + '/themes/contrib/**/*',
  '!' + sourceDir + '/sites/**/*',
];

var csslintOptions = '.csslintrc';

// SASS.
var scssFiles = [
  sourceDir + '/**/*.s+(a|c)ss',
  // Do not open scss partials as they will be included as needed.
  '!' + sourceDir + '/**/_*.scss',
  '!' + sourceDir + '/**/node_modules/**/*',
  '!' + sourceDir + '/**/bower_components/**/*',
  '!' + sourceDir + '/core/**/*',
  '!' + sourceDir + '/libraries/**/*',
  '!' + sourceDir + '/modules/contrib/**/*',
  '!' + sourceDir + '/profiles/contrib/**/*',
  '!' + sourceDir + '/themes/contrib/**/*',
  '!' + sourceDir + '/sites/**/*',
];

var scsslintOptions = {
  options: {
    configFile: '.sass-lint.yml',
  },
  files: {
    include: $.cached('scsslint'),
    ignore: sourceDir + '/**/_settings.scss'
  }
};

// ESLINT.
var jsFiles = [
  sourceDir + '/**/*.js',
  '!' + sourceDir + '/**/*.min.js',
  '!' + sourceDir + '/**/node_modules/**/*',
  '!' + sourceDir + '/**/bower_components/**/*',
  '!' + sourceDir + '/core/**/*',
  '!' + sourceDir + '/libraries/**/*',
  '!' + sourceDir + '/modules/contrib/**/*',
  '!' + sourceDir + '/profiles/contrib/**/*',
  '!' + sourceDir + '/themes/contrib/**/*',
  '!' + sourceDir + '/sites/**/*',
];

var eslintOptions = {
  configFile: '.eslintrc.legacy.json',
  // TODO: Need to find a way to make the autofix work.
  // fix: true,
  useEslintrc: false,
};

// PHP.
var phpFiles = [
  sourceDir + '/**/*.php',
  sourceDir + '/**/*.module',
  sourceDir + '/**/*.inc',
  sourceDir + '/**/*.install',
  sourceDir + '/**/*.test',
  sourceDir + '/**/*.profile',
  sourceDir + '/**/*.theme',
  sourceDir + '/**/*.css',
  sourceDir + '/**/*.info',
  sourceDir + '/**/*.txt',
  sourceDir + '/**/*.md',
  sourceDir + '/**/*.yml',
  '!' + sourceDir + '/autoload.php',
  '!' + sourceDir + '/index.php',
  '!' + sourceDir + '/robots.txt',
  '!' + sourceDir + '/core/**/*',
  '!' + sourceDir + '/libraries/**/*',
  '!' + sourceDir + '/modules/contrib/**/*',
  '!' + sourceDir + '/profiles/contrib/**/*',
  '!' + sourceDir + '/themes/contrib/**/*',
  '!' + sourceDir + '/sites/**/*',
];

var phpcbfOptions = {
  bin: '../../vendor/bin/phpcbf',
  standard: 'Drupal,DrupalPractice',
  warningSeverity: 0
};

var phpcsOptions = {
  bin: '../../vendor/bin/phpcs',
  colors: true,
  // TODO: Check why DrupalPractice does not work with gulp and work with
  // check-fix-standards script.
  standard: 'Drupal,DrupalPractice',
  warningSeverity: 0
};

var phpmdOptions = {
  bin: '../../vendor/bin/phpmd',
  format: 'text',
  ruleset: 'cleancode,codesize,controversial,design,naming,unusedcode',
};

// The default task.
gulp.task('default', ['lint']);

// Lint CSS, Sass, JS and PHP.
// TODO: Check why phpcs + phpmd + phpcbf are slow.
// Maybe it's due to tasks running simultaneously.
gulp.task('lint', ['lint:css', 'lint:sass', 'lint:js', 'phpcs', 'phpmd']);

// Lint CSS.
gulp.task('lint:css', function() {
  gulp.src(cssFiles)
    .pipe($.csslint(csslintOptions))
    .pipe($.csslint.formatter());
});

// Lint Sass.
gulp.task('lint:sass', function () {
  return gulp.src(scssFiles)
    .pipe($.sassLint(scsslintOptions))
    .pipe($.sassLint.format())
    .pipe($.sassLint.failOnError());
});

// Lint JS.
gulp.task('lint:js', function () {
  return gulp.src(jsFiles)
    .pipe($.eslint(eslintOptions))
    .pipe($.eslint.format());
});

// PHPCBF.
gulp.task('phpcbf', function () {
  return gulp.src(phpFiles)
    .pipe($.phpcbf(phpcbfOptions))
    .pipe(gulp.dest(sourceDir));
});

// PHPCS.
gulp.task('phpcs', function () {
  return gulp.src(phpFiles)
    .pipe($.phpcs(phpcsOptions))
    .pipe($.phpcs.reporter('log'));
});

// PHPMD.
gulp.task('phpmd', function () {
  return gulp.src(phpFiles)
    .pipe($.phpmd(phpmdOptions));
});
