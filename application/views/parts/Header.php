<?php
  $user_id = $this->session->userdata('userid');
  $NamaUser = $this->session->userdata('NamaUser');
  // var_dump($user_id);
  if($user_id == ''){
    echo "<script>location.replace('".base_url()."home');</script>";
  }
//test
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" href="images/favicon.ico" type="image/ico" />

    <title>Patroli Sistem</title>

    <!-- Bootstrap -->
    <link href="<?php echo base_url();?>Assets/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="<?php echo base_url();?>Assets/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="<?php echo base_url();?>Assets/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="<?php echo base_url();?>Assets/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
	
    <!-- bootstrap-progressbar -->
    <link href="<?php echo base_url();?>Assets/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
    <!-- JQVMap -->
    <link href="<?php echo base_url();?>Assets/vendors/jqvmap/dist/jqvmap.min.css" rel="stylesheet"/>
    <!-- bootstrap-daterangepicker -->
    <link href="<?php echo base_url();?>Assets/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="<?php echo base_url();?>Assets/build/css/custom.min.css" rel="stylesheet">

    <!-- Sweet alert -->
<script src="<?php echo base_url();?>Assets/sweetalert2-8.8.0/package/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="<?php echo base_url();?>Assets/sweetalert2-8.8.0/package/dist/sweetalert2.min.css">

<link rel="stylesheet" href="<?php echo base_url();?>Assets/devexpress/bootstrap-select.min.css" />
<!-- dev express -->

    <script src="<?php echo base_url();?>Assets/devexpress/jquery.min.js"></script>
    <script>window.jQuery || document.write(decodeURIComponent('%3Cscript src="js/jquery.min.js"%3E%3C/script%3E'))</script>
    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>Assets/devexpress/dx.common.css" />
    <link rel="stylesheet" type="text/css" href="<?php echo base_url();?>Assets/devexpress/dx.light.css" />
    <script src="<?php echo base_url();?>Assets/devexpress/jszip.min.js"></script>
    <script src="<?php echo base_url();?>Assets/devexpress/dx.all.js"></script>
    <!-- <script src="https://cdn3.devexpress.com/jslib/20.1.8/js/dx.all.js"></script> -->
    
    <!-- Select 2 -->
    <!-- <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script> -->
    <!-- datatable -->

    <script src="<?php echo base_url();?>Assets/vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="<?php echo base_url();?>Assets/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <link rel="stylesheet" href="<?php echo base_url();?>Assets/css/bootstrap-wysihtml5.css" />
  </head>
  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="index.html" class="site_title"><i class="fa fa-paw"></i> <span>AIS System</span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_info">
                <span>Welcome,</span>
                <h2><?php echo $NamaUser ?></h2>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />