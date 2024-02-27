<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * 
 */
class GlobalVar extends CI_Model
{
	
	function __construct()
	{
		parent::__construct();
	}
	function GetSideBar($userid,$parent,$usemobile)
	{
		$data = "
			select d.* from users a
			inner join userrole b on a.id = b.userid
			inner join permissionrole c on b.roleid = c.roleid
			inner join permission d on c.permissionid = d.id
			where a.id = $userid 
		";
		if ($usemobile == 1) {
			$data .= "AND d.AllowMobile = 1";
		}
		else{
			$data .= "AND d.menusubmenu = $parent";
		}
		$data .= "
			AND `status` = 1
			order by d.order asc
		";
		return $this->db->query($data);
	}
	public function GetNoTransaksi($prefix, $table, $field = "NoTransaksi")
	{
		$SQL = "SELECT COUNT(*) +1 LastRow FROM ".$table." WHERE LEFT(".$field.", LENGTH('".$prefix."')) = '".$prefix."'";

		$data = $this->db->query($SQL)->row();

		return $data->LastRow;
	}

	public function penyebut($nilai) {
		$nilai = abs($nilai);
		$huruf = array("", "satu", "dua", "tiga", "empat", "lima", "enam", "tujuh", "delapan", "sembilan", "sepuluh", "sebelas");
		$temp = "";
		if ($nilai < 12) {
			$temp = " ". $huruf[$nilai];
		} else if ($nilai <20) {
			$temp = $this.penyebut($nilai - 10). " belas";
		} else if ($nilai < 100) {
			$temp = $this.penyebut($nilai/10)." puluh". $this.penyebut($nilai % 10);
		} else if ($nilai < 200) {
			$temp = " seratus" . $this.penyebut($nilai - 100);
		} else if ($nilai < 1000) {
			$temp = $this.penyebut($nilai/100) . " ratus" . $this.penyebut($nilai % 100);
		} else if ($nilai < 2000) {
			$temp = " seribu" . $this.penyebut($nilai - 1000);
		} else if ($nilai < 1000000) {
			$temp = $this.penyebut($nilai/1000) . " ribu" . $this.penyebut($nilai % 1000);
		} else if ($nilai < 1000000000) {
			$temp = $this.penyebut($nilai/1000000) . " juta" . $this.penyebut($nilai % 1000000);
		} else if ($nilai < 1000000000000) {
			$temp = $this.penyebut($nilai/1000000000) . " milyar" . $this.penyebut(fmod($nilai,1000000000));
		} else if ($nilai < 1000000000000000) {
			$temp = $this.penyebut($nilai/1000000000000) . " trilyun" . $this.penyebut(fmod($nilai,1000000000000));
		}     
		return $temp;
	}
	public function systemInfo() {
	    $user_agent = $_SERVER['HTTP_USER_AGENT'];
	    $os_platform    = "Unknown OS Platform";
	    $os_array       = array('/windows phone 8/i'    =>  'Windows Phone 8',
	                            '/windows phone os 7/i' =>  'Windows Phone 7',
	                            '/windows nt 6.3/i'     =>  'Windows 8.1',
	                            '/windows nt 6.2/i'     =>  'Windows 8',
	                            '/windows nt 6.1/i'     =>  'Windows 7',
	                            '/windows nt 6.0/i'     =>  'Windows Vista',
	                            '/windows nt 5.2/i'     =>  'Windows Server 2003/XP x64',
	                            '/windows nt 5.1/i'     =>  'Windows XP',
	                            '/windows xp/i'         =>  'Windows XP',
	                            '/windows nt 5.0/i'     =>  'Windows 2000',
	                            '/windows me/i'         =>  'Windows ME',
	                            '/win98/i'              =>  'Windows 98',
	                            '/win95/i'              =>  'Windows 95',
	                            '/win16/i'              =>  'Windows 3.11',
	                            '/macintosh|mac os x/i' =>  'Mac OS X',
	                            '/mac_powerpc/i'        =>  'Mac OS 9',
	                            '/linux/i'              =>  'Linux',
	                            '/ubuntu/i'             =>  'Ubuntu',
	                            '/iphone/i'             =>  'iPhone',
	                            '/ipod/i'               =>  'iPod',
	                            '/ipad/i'               =>  'iPad',
	                            '/android/i'            =>  'Android',
	                            '/blackberry/i'         =>  'BlackBerry',
	                            '/webos/i'              =>  'Mobile');
	    $found = false;
	    $addr = new RemoteAddress;
	    $device = '';
	    foreach ($os_array as $regex => $value) 
	    { 
	        if($found)
	         break;
	        else if (preg_match($regex, $user_agent)) 
	        {
	            $os_platform    =   $value;
	            $device = !preg_match('/(windows|mac|linux|ubuntu)/i',$os_platform)
	                      ?'MOBILE':(preg_match('/phone/i', $os_platform)?'MOBILE':'SYSTEM');
	        }
	    }
	    $device = !$device? 'SYSTEM':$device;
	    return array('os'=>$os_platform,'device'=>$device);
	 }
}