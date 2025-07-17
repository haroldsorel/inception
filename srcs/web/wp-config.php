<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wpuser' );

/** Database password */
define( 'DB_PASSWORD', 'wppassword' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          's8sU=nR44)~bjy_?/8~;cMMY#kd**aWY7RfG1>wOOr71/Y!Z&BGj3sCS@vh&m1=~' );
define( 'SECURE_AUTH_KEY',   'Z+IV7W4mUBGA./mtxLuyyg|mC>n<E*#;j?JNSc&B_6b<?e!+28dl=Oee`p^~%ar$' );
define( 'LOGGED_IN_KEY',     '(/{2U^BE&IZ7Eh8C;1TdwMSx=Ky2TNM^I7[_`C^&O~r7m?{~xI-61D@j3-?[D08Z' );
define( 'NONCE_KEY',         '];LD4 a07Yi.KTw0$WDS@5/mI,hQq|1X?&:A8CVwSJ*c+B6+:xL~@aD]:/t1+*TI' );
define( 'AUTH_SALT',         'z0<|,xsRv@:y&;cTMz5t1pf13~@I-=TzZr;fo3vxXCfhqW1or,76)v44)95-3ymN' );
define( 'SECURE_AUTH_SALT',  'y;EE[}K=^wyZc0/tG+p|w_lwl2^b^h]i@/9*O#4pz.o<!iLLn~R*Z=>bqhCO}Z16' );
define( 'LOGGED_IN_SALT',    'U-nB$%$(@9l9dq~>aG;T2elGy8d;Gejo/<=MvoD-VgxJ..,-k@bRPV~L|)0kbH r' );
define( 'NONCE_SALT',        '0@R|,64g@nG(DU:pu4/TM^)Qk@|R>?c##V;|oP`E3PiLMwb4A_oo[yaG>^BqS&[9' );
define( 'WP_CACHE_KEY_SALT', '~i3QL#QYwFR33^|#[H<un%gBO]V;XqimjN=Tc#^898DC@L%?^{fbD!7r0ln>VICf' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
