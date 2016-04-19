<?php

if (!isset($drush_major_version)) {
  $drush_version_components = explode('.', DRUSH_VERSION);
  $drush_major_version = $drush_version_components[0];
}

$aliases['local'] = array(
  'parent' => '@parent',
  'site' => 'drupal',
  'env' => 'local',
  'root' => '/home/vagrant/www/elx-learning-module',
  'remote-host' => '127.0.0.1',
  '%files' => 'sites/drupal/files',
  'remote-user' => 'root',
  'uri' => 'drupal',
);




// Site lyssellc, environment dev
$aliases['stage'] = array(
  'root' => '/var/www/html',
  'site' => 'drupal',
  'env' => 'stage',
  'uri' => 'stagemyelx.cloudapp.net',
  'remote-host' => 'stagemyelx.cloudapp.net',
  'remote-user' => 'myelxadmin',
  'path-aliases' => array(
    '%drush-script' => 'drush' . $drush_major_version,
  )
);
