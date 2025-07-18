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
define( 'AUTH_KEY',          'Zh+rLp-@nhx1Pw)@4Zz]>ds8^*@so`yWZ#z>)V=@p_ydM7C.I}jfSB8 }kM;CDHy' );
define( 'SECURE_AUTH_KEY',   'i!m0Dr{pC,N 2oyS qPga5J:tO&XWE&jrVagS~K(@BO0 ,-I~*TC.>/bfQ9djolw' );
define( 'LOGGED_IN_KEY',     '0xD:_UDnpDq|-[|QGS5ErQ.MM=-b^ND`CR+(zJ`wS^3gm{<IlZ(Pb^W{%zS.=gMu' );
define( 'NONCE_KEY',         '1C&O&/4R(Yz@F8X@)?rL.Md!gH;+2iqVNNtZE8y jJ:>w}X/Gr69[l`T%Um+{y#b' );
define( 'AUTH_SALT',         'KJ8`Pt:Q.;f-~c/{,_3T#?M:Ow_oD&Q+3CftcJwUWV5en$mk6i?%t4+g70pBV#;H' );
define( 'SECURE_AUTH_SALT',  'v|m!pg$.,+W3}ad9h;vEL+ns1ubZ&:&Z516al.y^U&?6v;;`Xy0KJi0HVDrIfW<@' );
define( 'LOGGED_IN_SALT',    'l*=V1:=LV5n,B#~+Syx#wiRyi(4rc.[5xn5~Qe#<l.tgWUF54stnHQj!u8[#aN^t' );
define( 'NONCE_SALT',        'BuB3T9/89<1Dv-|Do0wqJNX$$]!4T[F17Z~W6)d$tmMA8JX>9KFb3{2*CYcMoF~c' );
define( 'WP_CACHE_KEY_SALT', 'h=VC2ne ]d8c|~ _:,t717Ml~eLL>CMvqVSdED*A<+em{;zAg{u3D]bG$E< Y?2L' );


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
