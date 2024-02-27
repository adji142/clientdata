<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Gentelella Alela! | </title>

    <!-- Bootstrap -->
    <link href="<?php echo base_url();?>Assets/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="<?php echo base_url();?>Assets/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="<?php echo base_url();?>Assets/vendors/nprogress/nprogress.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="<?php echo base_url();?>Assets/build/css/custom.min.css" rel="stylesheet">

    <script src="<?php echo base_url();?>Assets/sweetalert2-8.8.0/package/dist/sweetalert2.min.js"></script>
    <link rel="stylesheet" href="<?php echo base_url();?>Assets/sweetalert2-8.8.0/package/dist/sweetalert2.min.css">

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/webcamjs/1.0.25/webcam.js"></script>

    <style type="text/css">
      body{
        background-color: white!important;
      }
      .circular--portrait { position: relative; width: 200px; height: 200px; overflow: hidden; border-radius: 50%; display: block; margin-right: auto; margin-left: auto; } 
      .circular--portrait img { width: 100%; height: auto; }
      .custom-rounded {
        background-color: #04AA6D;
        border: none;
        color: white;
        padding: 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        /*border-radius: 5%;*/
        width: 500px;
      }
    </style>
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <!-- page content -->
        <div class="row">
          <div class="col-md-12">
            <div class="col-middle">
              <div class="text-center text-center">
                <h1 class="error-number">SELAMAT DATANG</h1>
                <h2><div id="NamaPerusahaan">Analytics Information System _</div></h2>
                
                <div class="mid_center">
                  <div class="circular--portrait">
                    <img id="LogoPerusahaan"> src="<?php echo base_url() ?>LocalData/SettingImage/DefaultCompanyLogo.png">
                  </div>
                  <br>
                </div>
              </div>
            </div>
          </div>
          <div class="mid_center">
            <button id="btCheckin" class="rounded btn btn-success btn-lg btn-block">CHECK IN</button>
            <button id="btCheckout" class="rounded btn btn-danger btn-lg btn-block">CHECK OUT</button>
            --- Admin ---
            <button id="btLogin" class="rounded btn btn-lg btn-block">Login</button>
          </div>
          <!-- /page content -->
        </div>
      </div>
    </div>


    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true" id="modal_">
      <div class="modal-dialog modal-lg">
        <div class="modal-content">

          <div class="modal-header">
            <h4 class="modal-title" id="myModalLabel"></h4>
            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">
            <!-- <form id="post_" data-parsley-validate class="form-horizontal form-label-left"> -->
            <div class="item form-group">
              <div class="col-md-12">
                <center>
                  <video id="preview" width="50%"></video>
                </center>
              </div>
            </div>

            <div class="item form-group">
              <!-- <label class="col-form-label col-md-3 col-sm-3 label-align" for="first-name">Nama Device <span class="required">*</span>
              </label> -->
              <div class="col-md-8">
                <center>
                  <input type="text" name="NomerInduk" id="NomerInduk" required="" placeholder="Nomer Induk" class="form-control ">
                  <input type="hidden" name="DeviceID" id="DeviceID">
                  <input type="hidden" name="LogType" id="LogType">
                </center>
              </div>
              <div class="col-md-4">
                <button class="rounded btn btn-danger btn-md btn-block" id="btSubmit">Submit</button>
              </div>
            </div>

            <div class="item form-group">
              <table class="table">
                <tr>
                  <th>Nomer Induk</th>
                  <td>:</td>
                  <td><div id="ResultNik"></div></td>
                </tr>
                <tr>
                  <th>Nama Karyawan</th>
                  <td>:</td>
                  <td><div id="NamaKaryawan"></div></td>
                </tr>
                <tr>
                  <th>Jabatan, Departement</th>
                  <td>:</td>
                  <td><div id="Posisi"></div></td>
                </tr>
              </table>
            </div>
            <div id="camera" style="height:auto;width:auto; text-align:left; display: none;"></div>
            <textarea id="picture_base64" name="picture_base64" style="display: none; "></textarea>
            <!-- </form> -->
          </div>
          <!-- <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            
          </div> -->

        </div>
      </div>
    </div>
        
    <!-- jQuery -->
    <script src="<?php echo base_url();?>Assets/vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
   <script src="<?php echo base_url();?>Assets/vendors/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <!-- FastClick -->
    <script src="<?php echo base_url();?>Assets/vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="<?php echo base_url();?>Assets/vendors/nprogress/nprogress.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="<?php echo base_url();?>Assets/build/js/custom.min.js"></script>

    <script src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
  </body>
  <footer>
    <div class="pull-right">
      AIS System - Software developer <a href="http://aistrick.com">aistrick</a>
    </div>
    <div class="clearfix"></div>
  </footer>
</html>

<script type="text/javascript">
  $(function () {
    Webcam.set({
        width: 220,
        height: 190,
        image_format: 'jpeg',
        jpeg_quality: 100
    });
    Webcam.attach('#camera');
    $(document).ready(function () {
      $('#NomerInduk').focus();

      let scanner = new Instascan.Scanner({ video: document.getElementById('preview') });
      scanner.addListener('scan', function (content) {
        // alert(content);
        $('#NomerInduk').val(content);

        $.ajax({
          type: "post",
          url: "<?=base_url()?>C_MasterKaryawan/Read",
          data: {'Nik':content},
          dataType: "json",
          async: false,
          success: function (response) {
            // bindGrid(response.data);
            if (response.data.length > 0) {
              // $('#UniqKey').val(response.DeviceID);
              $('#ResultNik').text(response.data[0].Nik);
              $('#NamaKaryawan').text(response.data[0].NamaKaryawan);
              $('#Posisi').text(response.data[0].NamaJabtan + ' , ' + response.data[0].NamaDepartement);
              takeSnapShot();

              $('#btSubmit').click();
            }
            else{
              Swal.fire({
                type: 'error',
                title: 'Woops Error',
                text: 'Karyawan Tidak ditemukan',
                // footer: '<a href>Why do I have this issue?</a>'
              }).then((result)=>{
                location.reload();
              });
            }
          }
        });
      });
      Instascan.Camera.getCameras().then(function (cameras) {
        if (cameras.length > 0) {
          scanner.start(cameras[0]);
        } else {
          console.error('No cameras found.');
        }
      }).catch(function (e) {
        console.error(e);
      });

      var where_field = '';
      var where_value = '';
      var table = 'users';

      $.ajax({
        type: "post",
        url: "<?=base_url()?>C_Device/GetUniqID",
        data: {'KodeDepartment':''},
        dataType: "json",
        async: false,
        success: function (response) {
          // bindGrid(response.data);
          if (response.success == true) {
            // $('#UniqKey').val(response.DeviceID);
            $('#DeviceID').val(response.DeviceID);
            ValidateDevice(response.DeviceID);
            GetPerusahaan();
          }
        }
      });
    });
    // Check Device ID
    function ValidateDevice(DeviceID) {
      $.ajax({
        type: "post",
        url: "<?=base_url()?>C_Device/FindByDeviceID",
        data: {'UniqKey':DeviceID},
        dataType: "json",
        async: false,
        success: function (response) {
          // bindGrid(response.data);
          if (response.data.length == 0) {
            // alert("UnKnown Device")
            Swal.fire({
              type: 'error',
              title: 'Woops Error',
              text: 'Device Belum Terdaftar, Silahkan login untuk mendaftarkan device ini',
              // footer: '<a href>Why do I have this issue?</a>'
            }).then((result)=>{
              window.location.replace("<?php echo base_url() ?>Home/login");
            });
          }
        }
      });
    }
    // Get Data Perusahaan
    function GetPerusahaan() {
      $.ajax({
        type: "post",
        url: "<?=base_url()?>C_Setting/Read",
        data: {'id':''},
        dataType: "json",
        async: false,
        success: function (response) {
          // bindGrid(response.data);
          if (response.data.length > 0) {
            $('#NamaPerusahaan').text(response.data[0].NamaPerusahaan);
            $('#LogoPerusahaan').attr('src',response.data[0].ImageBase64);
          }
        }
      });
    }

    $('#btCheckin').click(function() {
      // location.reload();
      // $('input[name=NomerInduk]').focus();
      $('#LogType').val('1')
      $('#myModalLabel').text('CHECK IN');
      $('#modal_').modal('show');
    });
    $('#btCheckout').click(function() {
      // location.reload();
      // $('input[name=NomerInduk]').focus();
      $('#LogType').val('0')
      $('#myModalLabel').text('CHECK OUT');
      $('#modal_').modal('show');
    });
    $('#btLogin').click(function () {
      window.location.replace("<?php echo base_url() ?>Home/login");
    })
    $('#modal_').on('shown.bs.modal', function () {
        // $('#textareaID').focus();
        // alert('')
        $('#NomerInduk').focus();
    })

    $('.close').click(function() {
      location.reload();
    });

    takeSnapShot = function () {
        Webcam.snap(function (data_uri) {
            // console.log(data_uri)
            $('#picture_base64').val(data_uri);
        });
    }

    $('#NomerInduk').on('keyup', function (e) {
      if (e.Key === 'enter' || e.keyCode === 13) {
        $('#btSubmit').click();
      }
    })

    $('#btSubmit').click(function () {

      $.ajax({
        type    :'post',
        url     : '<?=base_url()?>C_AttLog/AddLog',
        data    : {'id':0,'NikKaryawan':$('#NomerInduk').val(),'LogType':$('#LogType').val(),'DeviceID':$('#DeviceID').val(),'picture_base64':$('#picture_base64').val()},
        dataType: 'json',
        async: false,
        beforeSend: function(){
          Swal.fire({
            title: 'Loading',
            html: 'Loading ....',
            allowOutsideClick: false,
                onBeforeOpen: () => {
                    Swal.showLoading()
                },
          });
        },
        success : function (response) {
          if(response.success == true){
            $('#modal_').modal('toggle');
            if ($('#LogType').val() == 1) {
              Swal.fire({
                type: 'success',
                title: 'Horay..',
                html: '<center><b>SELAMAT DATANG</b><br>'+response.Nama+'<br>'+response.Posisi+' </center>',
                // footer: '<a href>Why do I have this issue?</a>'
              }).then((result)=>{
                location.reload();
              });
            }
            else{
              Swal.fire({
                type: 'success',
                html: '<center><b>HATI HATI DIJALAN</b><br>'+response.Nama+'<br>'+response.Posisi+' </center>',
                title: 'Horay..',
                // footer: '<a href>Why do I have this issue?</a>'
              }).then((result)=>{
                location.reload();
              });
            }
          }
          else{
            $('#modal_').modal('toggle');
            Swal.fire({
              type: 'error',
              title: 'Woops...',
              html: '<center> Karyawan : ' + response.Nama+ '<br>' + response.message + '</center>',
              // footer: '<a href>Why do I have this issue?</a>'
            }).then((result)=>{
              location.reload();
            });
          }
        }
      });
    })
  });
</script>