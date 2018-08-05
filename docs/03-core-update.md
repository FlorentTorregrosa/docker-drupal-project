# Minor core update

When making a minor core update (8.4.x -> 8.5.x), there are some manual steps to
do:
* files to check for, if there has been changes in Drupal core:
  * scripts/tests/phpunit.xml | core/phpunit.xml.dist
  * scripts/quality/.csslintrc | .csslintrc
  * scripts/quality/.eslintignore | .eslintignore
  * scripts/quality/.eslintrc.legacy.json | core/.eslintrc.legacy.json
  * www/sites/default/default.settings.php
  * www/sites/default/default.services.yml
  * www/sites/development.settings.php | sites/example.settings.local.php
  * www/sites/development.services.yml
