<?php
defined('BASEPATH') OR exit('No direct script access allowed');
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;
/**
 * 
 */
class ModelsExecuteMaster extends CI_Model
{
	
	function __construct()
	{
		parent::__construct();
		require APPPATH.'libraries/phpmailer/src/Exception.php';
        require APPPATH.'libraries/phpmailer/src/PHPMailer.php';
        require APPPATH.'libraries/phpmailer/src/SMTP.php';
	}
	function WriteLog($RecordOwnerID,$Event,$retValue)
	{
		$ip = '';
		if (!empty($_SERVER['HTTP_CLIENT_IP'])) {   //check ip from share internet
            $ip = $_SERVER['HTTP_CLIENT_IP'];
        } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {   //to check ip is pass from proxy
            $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
        } else {
            $ip = $_SERVER['REMOTE_ADDR'];
        }

        $data = array(
        	'LogDate' => date("Y-m-d h:i:sa"),
			'Event' => $Event,
			'IPAddress' => $ip,
			'RecordOwnerID' => $RecordOwnerID,
			'retValue' => $retValue
        );

        return $this->db->insert('logdata',$data);
	}
	function GetToken($token)
	{
		$this->db->where(array('Token'=>$token));
		$data = $this->db->get('tokenpools');
		if ($data->num_rows() > 0) {
			return true;
		}
		else{
			return false;
		}
	}
	function ExecUpdate($data,$where,$table)
	{
        $this->db->where($where);
        return $this->db->update($table,$data);
	}
	function ExecInsert($data,$table)
	{
		return $this->db->insert($table,$data);
	}
	function ExecInsertBatch($data,$table)
	{
		return $this->db->insert_batch($table,$data);
	}
	function FindData($where,$table){
		$this->db->where($where);
		return $this->db->get($table);
	}
	function FindDataWithLike($where,$table){
		$this->db->like($where,'both');
		return $this->db->get($table);
	}
	function GetData($table)
	{
		return $this->db->get($table);
	}
	function GetDataFromSP($DataSource, $Parameter)
	{
		$SQL = "CALL ".$DataSource."(".$Parameter.")";
		// var_dump($SQL);
		return $this->db->query($SQL);
	}
	function GetMax($table,$field)
	{
		// 1 : alredy, 0 : first input
		$this->db->select_max($field);
		return $this->db->get($table);
	}
	function DeleteData($where,$table)
	{
		return $this->db->delete($table,$where);
	}
	function GetSaldoStock($kodestock){
		$data = '
				SELECT a.kodestok,SUM(COALESCE(msd.qty,0)) - SUM(COALESCE(pp.qty,0)) - SUM(COALESCE(pj.qty,0)) saldo FROM masterstok a
				LEFT JOIN mutasistokdetail msd on a.id = msd.stokid
				LEFT JOIN post_product pp on a.id = pp.stockid
				LEFT JOIN penjualan pj on pp.id = pj.productid AND pj.statustransaksi = 1
				WHERE msd.canceleddate is null AND a.id = '.$kodestock.'
				GROUP BY a.kodestok
			';
		return $this->db->query($data);
	}
	function ClearImage()
	{
		$data = '
				DELETE FROM imagetable
				where used = 0
			';
		return $this->db->query($data);
	}
	public function CallSP($namasp,$param1)
	{
		$data = 'CALL '.$namasp.'('.$param1.')';
		return $this->db->query($data);
	}
	public function midTransServerKey()
	{
		// return "SB-Mid-server-1ZKaHFofItuDXKUri3so2Is1"; // SandBox AIS
		// return "Mid-server-Jm-OdHpu70LoN0jCl2GPQ4Mv"; // Production AIS

		// return "SB-Mid-server-eHFznPfC9PBbpGe56Rnq8evS"; // SandBox Spirit
		return "Mid-server-4ZQdd2NheT79YY8ULAAppvTW"; // Production Spirit
	}
	public function midTransProduction()
	{
		return true;
	}
	public function SendSpesificEmail($reciept,$subject,$body)
	{
		$this->load->library('email');
		$data = array('success' => false ,'message'=>array());
		// Get Setting
		$this->db->where(array('id'=>2));
		$rs = $this->db->get('temailsetting');
		// End Get Setting
		$config = array(
		    'protocol' 		=> $rs->row()->protocol, // 'mail', 'sendmail', or 'smtp'
		    'smtp_host' 	=> $rs->row()->smtp_host, 
		    'smtp_port' 	=> $rs->row()->smtp_port,
		    'smtp_user' 	=> $rs->row()->smtp_user,
		    'smtp_pass' 	=> $rs->row()->smtp_pass,
		    'smtp_crypto' 	=> $rs->row()->smtp_crypto, //can be 'ssl' or 'tls' for example
		    'mailtype' 		=> $rs->row()->mailtype, //plaintext 'text' mails or 'html'
		    'smtp_timeout' 	=> $rs->row()->smtp_timeout, //in seconds
		    'charset' 		=> $rs->row()->charset,
		    'wordwrap' 		=> $rs->row()->wordwrap,
		    'crlf'    		=> "\r\n",
            'newline' 		=> "\r\n"
		);
        $this->email->initialize($config);

        $from = $rs->row()->smtp_user;
        $to = $reciept;
        $subject = '[No-Replay]'.$subject.'[No-Replay]';
        $message = $body;

        $this->email->set_newline("\r\n");
        $this->email->from($from,'AIS System Information');
        $this->email->to($to);
        $this->email->subject($subject);
        $this->email->message($message);

        if($this->email->send()){
        	$data['success'] = true;
        }
        else{
        	$data['success'] = false;
        	$data['message']=show_error($this->email->print_debugger());
        }
        return $data;
	}
	public function PushEmail($NotificationType,$BaseRef,$ReceipedEmail)
	{
		$param = array(
			'id' =>0,
			'reqTime' =>date("Y-m-d h:i:sa"),
			'NotificationType' => $NotificationType,
			'BaseRef' =>$BaseRef,
			'ReceipedEmail' =>$ReceipedEmail,
			'CreatedOn' =>date("Y-m-d h:i:sa"),
			'Status' =>0
		);
		return $this->db->insert('tpushemail',$param);
	}
	public function DefaultBody()
	{
		$body = '
	    	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
			<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
			  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			  <meta name="viewport" content="width=320, initial-scale=1" />
			  <title>Airmail Confirm</title>
			  <style type="text/css">

			    /* ----- Client Fixes ----- */

			    /* Force Outlook to provide a "view in browser" message */
			    #outlook a {
			      padding: 0;
			    }

			    /* Force Hotmail to display emails at full width */
			    .ReadMsgBody {
			      width: 100%;
			    }

			    .ExternalClass {
			      width: 100%;
			    }

			    /* Force Hotmail to display normal line spacing */
			    .ExternalClass,
			    .ExternalClass p,
			    .ExternalClass span,
			    .ExternalClass font,
			    .ExternalClass td,
			    .ExternalClass div {
			      line-height: 100%;
			    }


			     /* Prevent WebKit and Windows mobile changing default text sizes */
			    body, table, td, p, a, li, blockquote {
			      -webkit-text-size-adjust: 100%;
			      -ms-text-size-adjust: 100%;
			    }

			    /* Remove spacing between tables in Outlook 2007 and up */
			    table, td {
			      mso-table-lspace: 0pt;
			      mso-table-rspace: 0pt;
			    }

			    /* Allow smoother rendering of resized image in Internet Explorer */
			    img {
			      -ms-interpolation-mode: bicubic;
			    }

			     /* ----- Reset ----- */

			    html,
			    body,
			    .body-wrap,
			    .body-wrap-cell {
			      margin: 0;
			      padding: 0;
			      background: #ffffff;
			      font-family: Arial, Helvetica, sans-serif;
			      font-size: 14px;
			      color: #464646;
			      text-align: left;
			    }

			    img {
			      border: 0;
			      line-height: 100%;
			      outline: none;
			      text-decoration: none;
			    }

			    table {
			      border-collapse: collapse !important;
			    }

			    td, th {
			      text-align: left;
			      font-family: Arial, Helvetica, sans-serif;
			      font-size: 14px;
			      color: #464646;
			      line-height:1.5em;
			    }

			    b a,
			    .footer a {
			      text-decoration: none;
			      color: #464646;
			    }

			    a.blue-link {
			      color: blue;
			      text-decoration: underline;
			    }

			    /* ----- General ----- */

			    td.center {
			      text-align: center;
			    }

			    .left {
			      text-align: left;
			    }

			    .body-padding {
			      padding: 24px 40px 40px;
			    }

			    .border-bottom {
			      border-bottom: 1px solid #D8D8D8;
			    }

			    table.full-width-gmail-android {
			      width: 100% !important;
			    }


			    /* ----- Header ----- */
			    .header {
			      font-weight: bold;
			      font-size: 16px;
			      line-height: 16px;
			      height: 16px;
			      padding-top: 19px;
			      padding-bottom: 7px;
			    }

			    .header a {
			      color: #464646;
			      text-decoration: none;
			    }

			    /* ----- Footer ----- */

			    .footer a {
			      font-size: 12px;
			    }
			  </style>

			  <style type="text/css" media="only screen and (max-width: 650px)">
			    @media only screen and (max-width: 650px) {
			      * {
			        font-size: 16px !important;
			      }

			      table[class*="w320"] {
			        width: 320px !important;
			      }

			      td[class="mobile-center"],
			      div[class="mobile-center"] {
			        text-align: center !important;
			      }

			      td[class*="body-padding"] {
			        padding: 20px !important;
			      }

			      td[class="mobile"] {
			        text-align: right;
			        vertical-align: top;
			      }
			    }
			  </style>

			</head>
			<body style="padding:0; margin:0; display:block; background:#ffffff; -webkit-text-size-adjust:none">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
			 <td valign="top" align="left" width="100%" style="background:repeat-x url(https://www.filepicker.io/api/file/al80sTOMSEi5bKdmCgp2) #f9f8f8;">
			 <center>

			   <table class="w320 full-width-gmail-android" bgcolor="#f9f8f8" background="https://www.filepicker.io/api/file/al80sTOMSEi5bKdmCgp2" style="background-color:transparent" cellpadding="0" cellspacing="0" border="0" width="100%">
			      <tr>
			        <td width="100%" height="48" valign="top">
			              <table class="full-width-gmail-android" cellspacing="0" cellpadding="0" border="0" width="100%">
			                <tr>
			                  <td class="header center" width="100%">
			                    <a href="#">
			                      Spirit Books
			                    </a>
			                  </td>
			                </tr>
			              </table>
			        </td>
			      </tr>
			    </table>
	    ';
    	return $body;
	}

	public function Email_payment($Notransaksi)
	{
		$SQL  = "SELECT * FROM topuppayment a
				where a.NoTransaksi='".$Notransaksi."' ";
		$rs = $this->db->query($SQL)->row();

		// var_dump($rs);
		$body = '
			<table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff">
		      <tr>
		        <td align="center">
		          <center>
		            <table class="w320" cellspacing="0" cellpadding="0" width="500">
		              <tr>
		                <td class="body-padding mobile-padding">

		                <table cellpadding="0" cellspacing="0" width="100%">
		                  <tr>
		                    <td style="text-align:center; font-size:30px; padding-bottom:20px;">
		                      Reciept
		                    </td>
		                  </tr>
		                  <tr>
		                    <td style="padding-bottom:20px;">
		                      '.$rs->UserID.'<br>
		                      <br>
		                        Permintaan Top Up anda kami terima Silahkan Melakukan Pembayaran.
		                        Detail Informasi silahkan menuju Menu <b> Riwayat Transaksi </b>
		                      <br>
		                      <br>
		                    </td>
		                  </tr>
		                </table>

		                <table cellspacing="0" cellpadding="0" width="100%">
		                  <tr>
		                    <td class="left" style="padding-bottom:20px; text-align:left;">
		                      Date: '.$rs->TglTransaksi.'<br>
		                      <b>Order Number:</b> '.$rs->NoTransaksi.'
		                    </td>
		                  </tr>
		                </table>

		                <table cellspacing="0" cellpadding="0" width="100%">
		                  <tr>
		                    <td>
		                      <b>Deskripsi</b>
		                    </td>
		                    <td>
		                      <b>Jumlah</b>
		                    </td>
		                  </tr>
		                  <tr>
		                    <td class="border-bottom" height="5"></td>
		                    <td class="border-bottom" height="5"></td>
		                  </tr>
		                  <tr>
		                    <td style="padding-top:5px; vertical-align:top;">
		                      Top Up SpiritPay
		                    </td>
		                    <td style="padding-top:5px;" class="mobile">
		                      Rp. '.number_format($rs->GrossAmt).'
		                    </td>
		                  </tr>
		                </table>
		                <br>
		                <table cellspacing="0" cellpadding="0" width="100%">
		                  <tr>
		                    <td class="left" style="text-align:left;">
		                      Thanks so much,
		                    </td>
		                  </tr>
		                </table>
		                </td>
		              </tr>
		            </table>
		          </center>
		        </td>
		      </tr>
		    </table>

		    <table class="w320" bgcolor="#E5E5E5" cellpadding="0" cellspacing="0" border="0" width="100%">
		      <tr>
		        <td style="border-top:1px solid #B3B3B3;" align="center">
		          <center>
		            <table class="w320" cellspacing="0" cellpadding="0" width="500" bgcolor="#E5E5E5">
		              <tr>
		                <td>
		                  <table cellpadding="0" cellspacing="0" width="100%" bgcolor="#E5E5E5">
		                    <tr>
		                      <td class="center" style="padding:25px; text-align:center;">
		                        <b><a href="#">Get in touch</a></b> if you have any questions or feedback
		                      </td>
		                    </tr>
		                  </table>
		                </td>
		              </tr>
		            </table>
		          </center>
		        </td>
		      </tr>
		      <tr>
		        <td style="border-top:1px solid #B3B3B3; border-bottom:1px solid #B3B3B3;" align="center">
		          <center>
		            <table class="w320" cellspacing="0" cellpadding="0" width="500" bgcolor="#E5E5E5">
		              <tr>
		                <td align="center" style="padding:25px; text-align:center">
		                  <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#E5E5E5">
		                    <tr>
		                      <td class="center footer" style="font-size:12px;">
		                        <a href="#">Contact Us</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		                        <span class="footer-group">
		                          <a href="#">Facebook</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		                          <a href="#">Twitter</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		                          <a href="#">Support</a>
		                        </span>
		                      </td>
		                    </tr>
		                  </table>
		                </td>
		              </tr>
		            </table>
		          </center>
		        </td>
		      </tr>
		    </table>

		  </center>
		  </td>
		</tr>
		</table>
		</body>
		</html>
		';
		return $body;
	}

	public function Email_payment_done($NoTransaksi)
	{
		$SQL  = "SELECT * FROM topuppayment a
				where a.NoTransaksi='".$NoTransaksi."' ";
		
		$rs = $this->db->query($SQL)->row();

		// var_dump($tglOrder);
			$body = '
			<table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff">
		      <tr>
		        <td align="center">
		          <center>
		            <table class="w320" cellspacing="0" cellpadding="0" width="500">
		              <tr>
		                <td class="body-padding mobile-padding">

		                <table cellpadding="0" cellspacing="0" width="100%">
		                  <tr>
		                    <td style="text-align:center; font-size:30px; padding-bottom:20px;">
		                      Reciept
		                    </td>
		                  </tr>
		                  <tr>
		                    <td style="padding-bottom:20px;">
		                      '.$rs->UserID.'<br>
		                      <br>
		                        Pembayran Anda sudah kami terima, Saldo SpiritPay anda bertambah sebesar <b> Rp. '.number_format($rs->GrossAmt).' </b>
		                      <br>
		                      <br>
		                    </td>
		                  </tr>
		                </table>

		                <table cellspacing="0" cellpadding="0" width="100%">
		                  <tr>
		                    <td class="left" style="padding-bottom:20px; text-align:left;">
		                      Date: 12/30/2013<br>
		                      <b>Order Number:</b> '.$rs->NoTransaksi.'
		                    </td>
		                  </tr>
		                </table>
		                <br>
		                <table cellspacing="0" cellpadding="0" width="100%">
		                  <tr>
		                    <td class="left" style="text-align:left;">
		                      Thanks so much,
		                    </td>
		                  </tr>
		                </table>
		                </td>
		              </tr>
		            </table>
		          </center>
		        </td>
		      </tr>
		    </table>

		    <table class="w320" bgcolor="#E5E5E5" cellpadding="0" cellspacing="0" border="0" width="100%">
		      <tr>
		        <td style="border-top:1px solid #B3B3B3;" align="center">
		          <center>
		            <table class="w320" cellspacing="0" cellpadding="0" width="500" bgcolor="#E5E5E5">
		              <tr>
		                <td>
		                  <table cellpadding="0" cellspacing="0" width="100%" bgcolor="#E5E5E5">
		                    <tr>
		                      <td class="center" style="padding:25px; text-align:center;">
		                        <b><a href="#">Get in touch</a></b> if you have any questions or feedback
		                      </td>
		                    </tr>
		                  </table>
		                </td>
		              </tr>
		            </table>
		          </center>
		        </td>
		      </tr>
		      <tr>
		        <td style="border-top:1px solid #B3B3B3; border-bottom:1px solid #B3B3B3;" align="center">
		          <center>
		            <table class="w320" cellspacing="0" cellpadding="0" width="500" bgcolor="#E5E5E5">
		              <tr>
		                <td align="center" style="padding:25px; text-align:center">
		                  <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#E5E5E5">
		                    <tr>
		                      <td class="center footer" style="font-size:12px;">
		                        <a href="#">Contact Us</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		                        <span class="footer-group">
		                          <a href="#">Facebook</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		                          <a href="#">Twitter</a>&nbsp;&nbsp;|&nbsp;&nbsp;
		                          <a href="#">Support</a>
		                        </span>
		                      </td>
		                    </tr>
		                  </table>
		                </td>
		              </tr>
		            </table>
		          </center>
		        </td>
		      </tr>
		    </table>

		  </center>
		  </td>
		</tr>
		</table>
		</body>
		</html>
			';
		return $body;
	}

	public function PushNotification($message)
	{
		define('API_ACCESS_KEY', 'AAAAx1wTEfo:APA91bH1gQ0oWm64IZryw8h3am40NXjkpiF3ukHJ3gelHHNwBS3aLQcfZGURhA1h_KIG6ByZUWDhSE7zAYm4p21gQyz4429BYmJtI_IjytzJQsifeh8L4OAXavuGkrwze4_74zSNJXGn');
		// prep the bundle
		  
		$headers = array
		(
		    'Authorization: key=' . API_ACCESS_KEY,
		    'Content-Type: application/json'
		);
		
		$ch = curl_init();
		curl_setopt( $ch,CURLOPT_URL, 'https://fcm.googleapis.com/fcm/send' );
		curl_setopt( $ch,CURLOPT_POST, true );
		curl_setopt( $ch,CURLOPT_HTTPHEADER, $headers );
		curl_setopt( $ch,CURLOPT_RETURNTRANSFER, true );
		curl_setopt( $ch,CURLOPT_SSL_VERIFYPEER, false );
		curl_setopt( $ch,CURLOPT_POSTFIELDS, json_encode( $message ) );
		$result = curl_exec($ch );

		if (curl_errno($ch)) {
			$result = curl_error($ch);
		}

		curl_close( $ch );
		// echo $result;
		return $result;
	}
}