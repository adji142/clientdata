<?php
    $user_id = $this->session->userdata('userid');
    if($user_id != ''){
        echo "<script>location.replace('".base_url()."home');</script>";
    }
    else{
      delete_cookie('ci_session');
      $this->session->sess_destroy();
      // echo "<script>location.replace('".base_url()."');</script>";
    }
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>AIS SYSTEM! | </title>

    <!-- Bootstrap -->
    <link href="<?php echo base_url();?>Assets/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="<?php echo base_url();?>Assets/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="<?php echo base_url();?>Assets/vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Animate.css -->
    <link href="<?php echo base_url();?>Assets/vendors/animate.css/animate.min.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="<?php echo base_url();?>Assets/build/css/custom.min.css" rel="stylesheet">
    <script src="<?php echo base_url();?>Assets/js/jquery.min.js"> </script>

    <script src="<?php echo base_url();?>Assets/sweetalert2-8.8.0/package/dist/sweetalert2.min.js"></script>
  <link rel="stylesheet" href="<?php echo base_url();?>Assets/sweetalert2-8.8.0/package/dist/sweetalert2.min.css">
  </head>

  <body class="login">
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
            <form id="loginform">
              <h1>Verification Form</h1>
              <div>
                <input type="password" class="form-control" placeholder="PassCode" required="" id="passcode" name="passcode"/>
              </div>
              <div>
                <button class="btn btn-success" id="btn_login">Verifikasi</button>
              </div>

              <div class="clearfix"></div>

              <div class="separator">

                <div class="clearfix"></div>
                <br />

                <div>
                  <h1><i class="fa fa-paw"></i> AIS SYSTEM</h1>
                  <p>©2020 All Rights Reserved. AIS SYSTEM!. Privacy and Terms</p>
                </div>
              </div>
            </form>
          </section>
        </div>
      </div>

    </div>
  </body>
</html>
<script type="text/javascript">
    $(function () {
        // Handle CSRF token
        $.ajaxSetup({
            beforeSend:function(jqXHR, Obj){
                var value = "; " + document.cookie;
                var parts = value.split("; csrf_cookie_token=");
                if(parts.length == 2)
                Obj.data += '&csrf_token='+parts.pop().split(";").shift();
            }
        });
        $(document).ready(function () {
            
        });
        // end Handle CSRF token
        $('#loginform').submit(function (e) {
            $('#btn_login').text('Tunggu Sebentar...');
            $('#btn_login').attr('disabled',true);

            e.preventDefault();
            var me = $(this);
            // alert(me.serialize());
            $.ajax({
                type: "post",
                url: "<?=base_url()?>Home/verifikasiPascode",
                data: me.serialize(),
                dataType: "json",
                success:function (response) {
                  if (response.success == true) {
                    location.replace("<?=base_url()?>Home/complateregister");
                  }
                  else{
                    Swal.fire({
                      type: 'error',
                      title: 'Oops...',
                      text: response.message,
                      // footer: '<a href>Why do I have this issue?</a>'
                    }).then((result)=>{
                        $('#btn_login').text('Login');
                        $('#btn_login').attr('disabled',false);
                    });
                  }
                }
            });
        });
    });
</script>