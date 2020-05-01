<?php

/**
 * @file
 * Contains hook implementations for fake_profile profile.
 *
 * This should trigger PHP CS error.
 */



/**
 * Implements hook_theme().
 */
function fake_profile_theme($existing, $type, $theme, $path) {
  // Use deprecated constant. This should trigger drupal-check error.
  FILE_CREATE_DIRECTORY;
  return [];
}
