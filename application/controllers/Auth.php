<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Auth extends CI_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see https://codeigniter.com/user_guide/general/urls.html
	 */
	function __construct()
	{
		parent::__construct();
		$this->load->model('ModelsExecuteMaster');
		$this->load->model('GlobalVar');
		$this->load->model('LoginMod');
	}
	public function index()
	{
		$this->load->view('index');
	}
	function Log_Pro()
	{
		$data = array('success' => false ,'message'=>array(),'username'=>array(),'unique_id'=>array());
        $usr = $this->input->post('username');
		$pwd =$this->input->post('password');
		// var_dump($usr.' '.$pwd);
		$Validate_username = $this->LoginMod->Validate_username($usr);
		if($Validate_username->num_rows()>0){
			// var_dump($Validate_username->result());
			if ($Validate_username->row()->verified == '0') {
				$sess_data['userid']=$Validate_username->row()->id;
				$sess_data['NamaUser'] = $Validate_username->row()->nama;
				$sess_data['username'] = $Validate_username->row()->username;
				$this->session->set_userdata($sess_data);

				$data['success'] = true;
				$data['message'] = "changepass";
			}
			else{
				$userid = $Validate_username->row()->id;
				$pwd_decript =$Validate_username->row()->password;
				// var_dump($this->encryption->decrypt($pwd_decript));
				$pass_valid = $this->encryption->decrypt($Validate_username->row()->password);
				// var_dump($this->encryption->decrypt($Validate_username->row()->password));
				// $get_Validation = $this->LoginMod->Validate_Login($userid,$this->encryption->encrypt($pwd));
				if($pass_valid == $pwd){
					$sess_data['userid']=$userid;
					$sess_data['NamaUser'] = $Validate_username->row()->nama;
					$sess_data['username'] = $Validate_username->row()->username;
					$this->session->set_userdata($sess_data);
					$data['success'] = true;
					$data['username'] = $Validate_username->row()->username;
					$data['unique_id'] = $Validate_username->row()->id;
				}
				else{
					$data['success'] = false;
					$data['message'] = 'L-01'; // User password doesn't match
				}
			}
		}
		else{
			$data['message'] = 'L-02'; // Username not found
		}
		// var_dump($data);
		echo json_encode($data);
	}
	function logout()
	{
		delete_cookie('ci_session');
        $this->session->sess_destroy();
        redirect('Welcome');
	}
	public function RegisterUser()
	{
		$data = array('success' => false ,'message'=>array(),'id' =>'');

		// parameter kode:kode,nama:nama,alamat:alamat,tlp:tlp,mail:mail,pj:pj,tgl:tgl,ket:ket}

		$uname = $this->input->post('uname');
		$nama = $this->input->post('nama');
		$mail = $this->input->post('mail');
		$pass = $this->input->post('pass');
		$role = $this->input->post('roles');
		$LocationID = $this->input->post('LocationID');

		$id = $this->input->post('id');
		$formtype = $this->input->post('formtype');
		$md_pass = $this->encryption->encrypt($pass);

		// 
		$insert = array(
			'username' 	=> $uname,
			'nama'		=> $nama,
			'email'		=> "",
			'password'	=> $md_pass,
			'AreaUser'=> $LocationID,
			'RecordOwnerID' => $this->session->userdata('RecordOwnerID')
		);
		if ($formtype == 'add') {
			$call = $this->ModelsExecuteMaster->ExecInsert($insert,'users');

			if ($call) {
				$xuser = $this->ModelsExecuteMaster->FindData(array('username'=>$uname),'users');
				if ($xuser->num_rows() > 0) {
					$insert = array(
						'userid' 	=> $xuser->row()->id,
						'roleid'	=> $role,
					);
					$call_x = $this->ModelsExecuteMaster->ExecInsert($insert,'userrole');
					if ($call_x) {
						$data['success'] = true;
					}
				}
			}
			else{
				$data['message'] = 'Data Gagal di input';
			}
		}
		elseif ($formtype == 'edit') {
			$rs = $this->ModelsExecuteMaster->ExecUpdate($insert,array('id'=>$id),'users');
			if ($rs) {
				$updaterole = $this->ModelsExecuteMaster->ExecUpdate(array('roleid'=>$role),array('userid'=>$id),'userrole');
				if ($updaterole) {
					$data['success'] = true;
				}
			}
			else{
				$data['success'] = false;
				$data['message'] = 'Gagal Updata Data';
			}
		}
		elseif ($formtype == 'delete') {
			try {
				$oUser = $this->ModelsExecuteMaster->FindData(array('userid'=>$id,'roleid'=>3),'userrole');

				if ($oUser->num_rows() >0) {
					$data['success'] = false;
					$data['message'] = "User Security hanya bisa dihapus dari Menu Master Security";
					goto jump;
				}

				$SQL = "DELETE FROM users WHERE id = ".$id." And RecordOwnerID = '".$this->session->userdata('RecordOwnerID')."'";
				$rs = $this->db->query($SQL);
				if ($rs) {
					$data['success'] = true;
				}
			} catch (Exception $e) {
				$data['success'] = false;
				$data['message'] = "Gagal memproses data ". $e->getMessage();
			}
		}
		jump:
		echo json_encode($data);
	}
	public function changepass()
	{
		$data = array('success' => false ,'message'=>array(),'id' =>'');

		$username = $this->input->post('username');
		$password = $this->input->post('password');
		$repassword = $this->input->post('repassword');

		if ($password != $repassword) {
			$data['success'] = false;
			$data['message'] = "Kombinasi Password berbeda";
			goto jump;
		}
		else{
			$getUser = $this->ModelsExecuteMaster->FindData(array('username'=>$username,'verified'=>0),'users');
			if ($getUser->num_rows() > 0) {
				$call =$this->ModelsExecuteMaster->ExecUpdate(array('password'=>$this->encryption->encrypt($repassword),'verified'=>"1"),array('username'=>$username),'users');
				if ($call) {
					$data['success'] = true;
				}
				else{
					$data['message'] = 'Gagal Update password';
				}
			}
			else{
				$data['success'] = false;
				$data['message'] = "User sudah diverifikasi, Silahkan Login";
				goto jump;
			}
		}
		jump:
		echo json_encode($data);
	}
	public function GetSidebar()
	{
		$data = array('success' => false ,'message'=>array(),'data' =>array());

		$id = $this->input->post('id');
		$call =$this->GlobalVar->GetSideBar($id,1,1);
		if ($call) {
			$data['success'] = true;
			$data['data'] = $call->result();
		}
		else{
			$data['message'] = 'Gagal Update password';
		}
		echo json_encode($data);
	}
	public function Getindex()
	{
		$data = array('success' => false ,'message'=>array(),'Nomor' => '');

		$Kolom = $this->input->post('Kolom');
		$Table = $this->input->post('Table');
		$Prefix = $this->input->post('Prefix');

		$SQL = "SELECT RIGHT(MAX(".$Kolom."),4)  AS Total FROM " . $Table . " WHERE LEFT(" . $Kolom . ", LENGTH('".$Prefix."')) = '".$Prefix."'";

		// var_dump($SQL);
		$rs = $this->db->query($SQL);

		$temp = $rs->row()->Total + 1;

		$nomor = $Prefix.str_pad($temp, 6,"0",STR_PAD_LEFT);
		if ($nomor != '') {
			$data['success'] = true;
			$data['nomor'] = $nomor;
		}
		echo json_encode($data);
	}
	public function ReadUser()
	{
		$data = array('success' => false ,'message'=>array(),'data' => array(),'decript'=>'');

		$id = $this->input->post('id');

		$SQL = "SELECT a.*,c.rolename,b.roleid FROM users a
				LEFT JOIN userrole b on a.id = b.userid
				LEFT JOIN roles c on b.roleid = c.id ";
		if ($id != '') {
			$SQL .= ' WHERE a.id = '.$id;
		}
		// var_dump($SQL);
		$rs = $this->db->query($SQL);
		if ($id != '') {
			$rsx = $this->ModelsExecuteMaster->FindData(array('id'=>$id),'users');
			$data['decript'] = $this->encryption->decrypt($rsx->row()->password);
		}
		if ($rs->num_rows() > 0) {
			$data['success'] = true;
			$data['data'] = $rs->result();
		}
		echo json_encode($data);
	}
	public function read()
	{
		$data = array('success' => false ,'message'=>array(),'data' => array(),'decript'=>'');

		$kriteria = $this->input->post('kriteria');
		$skrip = $this->input->post('skrip');
		$userid = $this->input->post('userid');
		$roleid = $this->input->post('roleid');
		
		$SQL = "";

		try {
			$SQL .= "
				SELECT 
					a.id UserId,
					a.username,
					a.nama,
					a.HakAkses,
					c.id RoleId,
					c.rolename,
					a.email,
					a.phone
				FROM users a
				LEFT JOIN userrole b on a.id = b.userid
				LEFT JOIN roles c on b.roleid = c.id 
				WHERE CONCAT(a.username,' ',a.nama) LIKE '%".$kriteria."%'
			";
			if ($userid != '') {
				$SQL .= " AND a.id =".$userid." ";
			}
			if ($roleid != '') {
				$SQL .= " AND c.id =".$roleid." ";
			}
			if ($skrip != '') {
				$SQL .= " AND ".$skrip." ";
			}

			// $SQL .= ' LIMIT 5';
			$rs = $this->db->query($SQL);

			if ($rs) {
				$data['success'] = true;
				$data['data'] = $rs->result();
			}
			else{
				$undone = $this->db->error();
				$data['success'] = false;
				$data['message'] = $undone['message'];
			}
		} catch (Exception $e) {
			$undone = $this->db->error();
			$data['success'] = false;
			$data['message'] = $undone['message'];
		}

		echo json_encode($data);
	}
	public function GetAccess()
	{
		$data = array('success' => false ,'message'=>array(),'data' => array(),'decript'=>'');

		$userid = $this->input->post('userid');

		$rs = $this->LoginMod->GetUser($userid);

		if ($rs) {
			$data['success'] = true;
			$data['data'] = $rs->result();
		}
		else{
			$undone = $this->db->error();
			$data['success'] = false;
			$data['
			message'] = $undone['message'];
		}
		echo json_encode($data);
	}

	public function RegisterCompany()
	{
		$data = array('success' => false ,'message'=>'','data' => array(),'decript'=>'');

		$KodePartner = $this->input->post('KodePartner');
		$NamaPartner = $this->input->post('NamaPartner');
		$AlamatTagihan = $this->input->post('AlamatTagihan');
		$NoTlp = $this->input->post('NoTlp');
		$NoHP = $this->input->post('NoHP');
		$NIKPIC = $this->input->post('NIKPIC');
		$NamaPIC = $this->input->post('NamaPIC');
		$CreatedOn = date("y-m-d h:i:s");
		$CreatedBy = $this->input->post('NamaPartner');
		$password = $this->input->post('password');
		$retypepassword = $this->input->post('retypepassword');
		$tempStore = '';
		if ($password != $retypepassword) {
			$data['success'] = false;
			$data['message'] = 'Kombinasi Password tidak cocok';
			goto jump;
		}
		else{
			$tempStore= $this->encryption->encrypt($retypepassword);
		}


		$Prefix = 'CL';
		$temp = $this->GlobalVar->GetNoTransaksi($Prefix,'tcompany','KodePartner');
		$KodePartner = $Prefix.str_pad($temp, 4,"0",STR_PAD_LEFT);

		$oParam = array(
			'KodePartner' => $KodePartner,
			'NamaPartner' => $NamaPartner,
			'AlamatTagihan' => $AlamatTagihan,
			'NoTlp' => $NoTlp,
			'NoHP' => $NoHP,
			'NIKPIC' => $NIKPIC,
			'NamaPIC' => $NamaPIC,
			'CreatedOn' => $CreatedOn,
			'CreatedBy' => $CreatedBy,
			'tempStore' => $tempStore,
			'StartSubs' => date("Y-m-d-H-i-s"),
			'AllowMobile' => 0,
			'AllowDashboard' => 0
		);

		$rs = $this->ModelsExecuteMaster->ExecInsert($oParam,'tcompany');

		if ($rs) {
			$data['success'] = true;
			$data['message'] = "Terimakasih telah melakukan registrasi. Silahkan login dengan user 'manager' dan password yang telah anda isikan. ";
			delete_cookie('ci_session');
      		$this->session->sess_destroy();
		}
		else{
			$data['message'] = "Gagal Melakukan Registrasi";
		}
		jump:
		echo json_encode($data);
	}

	public function loginprocessing()
	{
		$data = array(
					'success' 		=> false ,
					'message'		=>'',
					'data' 			=> array(),
					'RecordOwnerID'	=>'',
					'LocationID'	=>'',
					'NamaUser'		=>'',
					'username'		=>'',
					'unique_id'		=>'',
					'Shift'			=>'',
					'isGantiHari'	=> 0,
					'JadwalShift'	=> array(),
					'NamaPartner'	=> '',
					'icon'			=> ''
				);

		$RecordOwnerID = $this->input->post('RecordOwnerID');
		$Username = $this->input->post('username');
		$password = $this->input->post('password');
		$LoginDate = $this->input->post('LoginDate');

		// Verifikasi Partner ID

		$oPartner = $this->ModelsExecuteMaster->FindData(array('KodePartner'=>$RecordOwnerID), 'tcompany');

		if ($oPartner->num_rows() == 0) {
			$data['success'] = false;
			$data['message'] = 'Partner Tidak Ditemukan, Silahkan Hubungi Operator';
			goto jump;
		}

		$oUser = $this->ModelsExecuteMaster->FindData(array('username'=>$Username,'RecordOwnerID'=> $RecordOwnerID), 'users');

		if ($oUser->num_rows() == 0) {
			$data['success'] = false;
			$data['message'] = 'Username Tidak Ditemukan, Silahkan Hubungi Operator';
			goto jump;
		}

		// Check Subscription

		$SqlParam = "
			SELECT * FROM tcompany where KodePartner = '".$RecordOwnerID."'
			AND DATE_ADD(EndSubs,INTERVAL ExtraDays DAY) > now();
		";

		$oPartnerSubs = $this->db->query($SqlParam);

		if ($oPartnerSubs->num_rows() == 0) {
			$data['success'] = false;
			$data['message'] = 'Langganan Telah Habis, Silahkan Melakukan Perpanjangan Langganan';
			goto jump;
		}
		// Check Subscription

		$validPWD = $this->encryption->decrypt($oUser->row()->password);

		if ($validPWD != $password) {
			$data['success'] = false;
			$data['message'] = 'Password Tidak Sesuai, Coba Lagi';
			goto jump;
		}
		else{

			$oSecurity = $this->ModelsExecuteMaster->FindData(array('NIK'=>$Username,'RecordOwnerID'=> $RecordOwnerID), 'tsecurity');

			// var_dump($oSecurity->row());

			$oLokasi = $this->ModelsExecuteMaster->FindData(array('LocationID'=>$oUser->row()->AreaUser,'RecordOwnerID'=> $RecordOwnerID), 'tshift');

			$data['success'] = true;
			$data['username'] = $oUser->row()->username;
			$data['unique_id'] = $oUser->row()->id;
			$data['RecordOwnerID'] = $oUser->row()->RecordOwnerID;
			$data['NamaPartner'] = $oPartner->row()->NamaPartner;
			$data['LocationID'] = $oUser->row()->AreaUser;
			$data['NamaUser'] = $oUser->row()->nama;
			$data['icon'] = $oPartner->row()->icon;
			if ($oSecurity->num_rows() > 0) {
				// Shift

				$xLoginDate = strtotime($LoginDate);
				$Tanggal = date("y-m-d", $xLoginDate);

				$defTime = strtotime('00:00:01');
				$Jam = strtotime(date("h:m:s", $xLoginDate));

				// var_dump($Jam);

				foreach ($oLokasi->result() as $key) {
					if ($key->GantiHari == "1") {
						$mulai = strtotime($key->MulaiBekerja);
						$selesai = strtotime($key->SelesaiBekerja);

						if ($defTime < $Jam && $Jam < $selesai ) {
							// echo "Ganti Hari";
							$data['Shift'] = $key->id;
							$data['isGantiHari'] = $key->GantiHari;

							$Tanggal = date("y-m-d", strtotime($LoginDate.' -1 Days'));
						}
						else{
							$data['Shift'] = $key->id;
							$data['isGantiHari'] = $key->GantiHari;
						}
					}
				}

				$oWhere = array(
					'TglAwal'		=> $Tanggal,
					'TglAkhir'		=> $Tanggal,
					'RecordOwnerID'	=> $oUser->row()->RecordOwnerID,
					'NIK'			=> $oUser->row()->username
				);

				// foreach ($oLokasi->result() as $key) {
				// 	if ($key->id == $oSecurity->row()->Shift) {
				// 		$data['isGantiHari'] = $key->GantiHari;
				// 	}
				// }
			}
			$data['JadwalShift'] = $oLokasi->result();

			$sess_data['userid']=$oUser->row()->id;
			$sess_data['NamaUser'] = $oUser->row()->nama;
			$sess_data['UserName'] = $oUser->row()->username;
			$sess_data['RecordOwnerID'] = $oUser->row()->RecordOwnerID;
			$sess_data['AreaUser'] = $oUser->row()->AreaUser;
			$this->session->set_userdata($sess_data);
		}


		jump:
		$this->ModelsExecuteMaster->WriteLog($RecordOwnerID,'Login', json_encode($data));
		echo json_encode($data);
	}

	public function updateToken()
	{
		$data = array(
			'success' 		=> false ,
			'message'		=>'',
			'data' 			=> array()
		);

		$RecordOwnerID = $this->input->post('RecordOwnerID');
		$Username = $this->input->post('username');
		$FireBaseToken = $this->input->post('FireBaseToken');

		$oUser = $this->ModelsExecuteMaster->FindData(array('username'=>$Username,'RecordOwnerID'=> $RecordOwnerID), 'users');

		if ($oUser->num_rows() == 0) {
			$data['success'] = false;
			$data['message'] = 'Username Tidak Ditemukan, Silahkan Hubungi Operator';
			goto jump;
		}

		$where = array(
			'id' => $oUser->row()->id,
			'RecordOwnerID' => $RecordOwnerID
		);

		$dataUpdated = array(
			'UserToken' => $FireBaseToken
		);

		$rs = $this->ModelsExecuteMaster->ExecUpdate($dataUpdated, $where, 'users');

		if($rs){
			$data['success'] = true;
			$data['message'] = "";
		}

		jump:

		echo json_encode($data);
	}

	public function getMetodePembayaran()
	{
		$data = array(
			'success' 		=> false ,
			'message'		=>'',
			'data' 			=> array()
		);

		$id = $this->input->post('id');

		$rs = false;
		if ($id != "") {
			$rs = $this->ModelsExecuteMaster->FindData(array('id'=>$id),'tpaymentmethod');
		}
		else{
			$rs = $this->ModelsExecuteMaster->GetData('tpaymentmethod');
		}

		if ($rs) {
			$data['success'] = true;
			$data['data'] = $rs->result();
		}
		echo json_encode($data);
	}

	public function lookupMetodePembayaran()
	{
		$data = array(
			'success' 		=> false ,
			'message'		=>'',
			'data' 			=> array()
		);

		$id = $this->input->post('id');

		$rs = false;
		$sql = "SELECT id AS ID, NamaMetode AS Title FROM tpaymentmethod WHERE 1 = 1 ";

		if ($id != "") {
			$sql += " AND id =".$id ;
		}

		$rs = $this->db->query($sql);
		if ($rs) {
			$data['success'] = true;
			$data['data'] = $rs->result();
		}
		echo json_encode($data);
	}
}
