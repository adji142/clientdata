<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
|
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|
|	example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
|	https://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There are three reserved routes:
|
|	$route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
|	$route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router which controller/method to use if those
| provided in the URL cannot be matched to a valid route.
|
|	$route['translate_uri_dashes'] = FALSE;
|
| This is not exactly a route, but allows you to automatically route
| controller and method names that contain dashes. '-' isn't a valid
| class or method name character, so it requires translation.
| When you set this option to TRUE, it will replace ALL dashes in the
| controller and method URI segments.
|
| Examples:	my-controller/index	-> my_controller/index
|		my-controller/my-method	-> my_controller/my_method
*/
$route['default_controller'] = 'Home/login';
$route['404_override'] = '';
$route['translate_uri_dashes'] = FALSE;

// Auth
$route['register'] = 'Home/register';
$route['generate'] = 'Home/generatePascode';
// Auth

// API TEST
$route['APITestNumber'] = 'API/API_Test/testNumber';
$route['APITest'] = 'API/API_Test/testGlobal';
// API TEST

// API TOKEN
$route['APILogin'] = 'Auth/loginprocessing';
$route['APIUpdateToken'] = 'Auth/updateToken';
$route['APIReadLocation'] = 'C_LokasiPatroli/Read';
$route['APIReadPatroli'] = 'C_Patroli/Read';
$route['APIAddPatroli'] = 'C_Patroli/CRUD';
$route['APIShiftRead'] = 'C_Shift/Read';
$route['APISOSCreate'] = 'C_SOS/Create';
$route['APISOSRead'] = 'C_SOS/Read';
$route['APIAttRead'] = 'C_Absensi/Read';
$route['APIAttCRUD'] = 'C_Absensi/CRUD';
$route['APIGetJadwal'] = 'C_Jadwal/Read';
$route['APIGetPayment'] = 'Auth/getMetodePembayaran';
$route['APIGetLookupPayment'] = 'Auth/lookupMetodePembayaran';
$route['APIPricingTable'] = 'C_Pricing/ReadPricingTable';
$route['APIPricingTerm'] = 'C_Pricing/ReadPricingTerm';
$route['APIGuestLog'] = 'C_GuestLog/Read';
$route['APIFindGuestLog'] = 'C_GuestLog/Find';
$route['APICRUDGuestLog'] = 'C_GuestLog/CRUD';

$route['APIDailyActivity'] = 'C_DailyActivity/Read';
$route['APIFindDailyActivity'] = 'C_DailyActivity/Find';
$route['APICRUDDailyActivity'] = 'C_DailyActivity/CRUD';
// API TOKEN

$route['permissionread'] = 'Auth/C_Permission/permission';

$route['permission'] = 'Home/permission';
$route['role'] = 'Home/role';
$route['permissionrole/(:num)'] = 'Home/permissionrole/$1';
$route['user'] = 'Home/user';
$route['profile'] = 'Home/profile';

// Master Data
$route['lokasi'] = 'Home/lokasipatroli';
$route['checkpoint'] = 'Home/checkpoint';
$route['security'] = 'Home/security';
$route['shift/(:num)'] = 'Home/shift/$1';
$route['jadwal/(:any)'] = 'Home/jadwal/$1';
// Report
$route['review'] = 'Home/readReview';
$route['map/(:num)'] = 'Home/loadmap/$1';

$route['reviewabsen'] = 'Home/readReviewabsen';
$route['reviewbukutamu'] = 'Home/readBukuTamu';
$route['reviewdailyactivity'] = 'Home/readDailyActivity';
// Tools
$route['backup'] = 'C_SD/bk';
$route['selftdest'] = 'C_SD/selfDestruct';