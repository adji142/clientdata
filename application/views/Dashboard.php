<?php
    require_once(APPPATH."views/parts/Header.php");
    require_once(APPPATH."views/parts/Sidebar.php");
    $active = 'dashboard';
?>
<!-- page content -->
<div class="right_col" role="main">
  <div class="row">
    <div class="col-md-12">
      <div class="">
        <div class="x_content">
          <div class="row">
            <div class="col-md-12 col-sm-12  ">
              <div class="x_panel">
                <div class="x_title">
                  <h2>Realisasi Patroli</h2>
                  <div class="clearfix"></div>
                </div>
                <div class="x_content">
                  <div class="row">
                    <div class="col-md-3 col-sm-12  form-group">
                    Tgl Awal
                    <input type="date" id="TglAwal" name="TglAwal" class="form-control">
                  </div>
                  <div class="col-md-3 col-sm-12  form-group">
                    Tgl Akhir
                    <input type="date" id="TglAkhir" name="TglAkhir" class="form-control">
                  </div>

                  <div class="col-md-3 col-sm-12  form-group">
                    Lokasi Patroli
                    <select id="LocationID" name="LocationID" class="form-control">

                      <?php
                        $oParam = array();

                        if ($this->session->userdata('AreaUser') != "") {
                          $oParam = array(
                            'RecordOwnerID' => $this->session->userdata('RecordOwnerID'),
                            'id' => $this->session->userdata('AreaUser'),
                          );
                        }
                        else{
                          echo "<option value=''>Pilih Lokasi</option>";
                          $oParam = array(
                            'RecordOwnerID' => $this->session->userdata('RecordOwnerID')
                          );
                        }
                        // var_dump($oParam);
                        $rs = $this->ModelsExecuteMaster->FindData($oParam,'tlokasipatroli')->result();

                        foreach ($rs as $key) {
                          echo "<option value = '".$key->id."'>".$key->NamaArea."</option>";
                        }
                      ?>
                    </select>
                  </div>
                  <div class="col-md-3 col-sm-12  form-group">
                    <br>
                    <button class="btn btn-success" id="btSearch">Refresh</button>
                  </div>
                  <div class="col-md-12 col-sm-12">
                      <div id="pencapaianpatrol" style="height: 350px;"></div>
                    </div>
                  </div>

                  <!-- <div id="mainb" style="height:350px;"></div> -->

                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- /page content -->
<?php
  require_once(APPPATH."views/parts/Footer.php");
?>
<!-- ECharts -->
<!-- <script src="<?php echo base_url();?>Assets/vendors/echarts/dist/echarts.min.js"></script>
<script src="<?php echo base_url();?>Assets/vendors/echarts/map/js/world.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.4.3/echarts.min.js" integrity="sha512-EmNxF3E6bM0Xg1zvmkeYD3HDBeGxtsG92IxFt1myNZhXdCav9MzvuH/zNMBU1DmIPN6njrhX1VTbqdJxQ2wHDg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script type="text/javascript">
  $(function () {
    var RecordOwnerID = "<?php echo $this->session->userdata('RecordOwnerID') ?>";
    $(document).ready(function () {
      var now = new Date();

      var day = ("0" + now.getDate()).slice(-2);
      var month = ("0" + (now.getMonth() + 1)).slice(-2);

      var today = now.getFullYear()+"-01-01";
      var lastDayofYear = now.getFullYear()+"-"+month+"-"+day;

      $('#TglAwal').val(today);
      $('#TglAkhir').val(lastDayofYear);
      $("#TglAwal").prop("readOnly", true);
      $("#TglAkhir").prop("readOnly", true);

      var button = document.getElementById("btSearch");
      button.click();
      // loadperformapatroli();
    });

    $('#btSearch').click(function () {
      $.ajax({
        type: "post",
        url: "<?=base_url()?>Home/LoadPerformaPatroli",
        data: {
          'TglAwal'       :$('#TglAwal').val(),
          'TglAkhir'      :$('#TglAkhir').val(),
          'RecordOwnerID' :RecordOwnerID,
          'LocationID'    :$('#LocationID').val(),
        },
        dataType: "json",
        success: function (response) {
          // bindGrid(response.data);
          // console.log(response);
          loadperformapatroli(response.data.target, response.data.realisasi);
        }
      });
    })

    function loadperformapatroli(target, realisasi) {
      var myChart = echarts.init(document.getElementById('pencapaianpatrol'));

      const colors = ['#5470C6', '#91CC75', '#EE6666'];
      option = {
        color: colors,
        tooltip: {
          trigger: 'axis',
          axisPointer: {
            type: 'cross'
          }
        },
        grid: {
          right: '20%'
        },
        toolbox: {
          feature: {
            dataView: { show: true, readOnly: false },
            restore: { show: true },
            saveAsImage: { show: true }
          }
        },
        legend: {
          // data: ['Evaporation', 'Precipitation', 'Temperature']
          data: ['Realisasi', 'Target']
        },
        xAxis: [
          {
            type: 'category',
            axisTick: {
              alignWithLabel: true
            },
            // prettier-ignore
            data: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
          }
        ],
        yAxis: [
          {
            type: 'value',
            name: 'Realisasi',
            position: 'right',
            alignTicks: true,
            axisLine: {
              show: true,
              lineStyle: {
                color: colors[0]
              }
            },
            axisLabel: {
              formatter: '{value} x'
            }
          },
          {
            type: 'value',
            name: 'Target',
            position: 'left',
            alignTicks: true,
            axisLine: {
              show: true,
              lineStyle: {
                color: colors[2]
              }
            },
            axisLabel: {
              formatter: '{value} x'
            }
          }
        ],
        series: [
          {
            name: 'Realisasi',
            type: 'bar',
            data: realisasi
          },
          {
            name: 'Target',
            type: 'line',
            data: target
          }
        ]
      };
      myChart.setOption(option);
    }
  });
</script>