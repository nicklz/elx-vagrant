<?php

if (!isset($drush_major_version)) {
  $drush_version_components = explode('.', DRUSH_VERSION);
  $drush_major_version = $drush_version_components[0];
}

$aliases['local'] = array(
  'parent' => '@parent',
  'site' => 'myelx',
  'env' => 'local',
  'root' => '/home/vagrant/www',
  'remote-host' => '127.0.0.1',
  '%files' => 'sites/local.myelx.com/files',
  'remote-user' => 'root',
  'uri' => 'local.myelx.org',
);

