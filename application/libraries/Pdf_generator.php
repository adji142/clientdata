<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once APPPATH . 'libraries/fpdf/fpdf.php';

class Pdf_generator extends FPDF {

    public function __construct() {
        parent::__construct();
        // Your FPDF customization here
    }

    // Additional functions to generate PDF content
}
?>
