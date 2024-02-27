<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * 
 */
class Notification extends CI_Model
{
	
	function __construct()
	{
		parent::__construct();
	}
	
    public function BroadcastTopic($Topic, $msg)
    {
        define('API_ACCESS_KEY', 'AAAAx1wTEfo:APA91bH1gQ0oWm64IZryw8h3am40NXjkpiF3ukHJ3gelHHNwBS3aLQcfZGURhA1h_KIG6ByZUWDhSE7zAYm4p21gQyz4429BYmJtI_IjytzJQsifeh8L4OAXavuGkrwze4_74zSNJXGn' );
        $msg = array
        (
            'message'   => 'SOS', //
            'title'     => 'SOS !!! Ada Kondisi Darurat',
            'subtitle'  => 'This is a subtitle. subtitle',
            'tickerText'    => 'Ticker text here...Ticker text here...Ticker text here',
            'vibrate'   => 1,
            'sound'     => 1,
            'largeIcon' => 'large_icon',
            'smallIcon' => 'small_icon'
        );
        $fields = array
        (
            // 'registration_ids'  => array(1234),
            'data'              => $msg,
            'notification'      => $msg,
            'to'                => '/topics/'.$Topic
        );

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
        curl_setopt( $ch,CURLOPT_POSTFIELDS, json_encode( $fields ) );
        $result = curl_exec($ch );

        echo json_encode($result);
        curl_close( $ch );
    }

    public function BroadcastPerUser($Token, $msg)
    {
        define('API_ACCESS_KEY', 'AAAAx1wTEfo:APA91bH1gQ0oWm64IZryw8h3am40NXjkpiF3ukHJ3gelHHNwBS3aLQcfZGURhA1h_KIG6ByZUWDhSE7zAYm4p21gQyz4429BYmJtI_IjytzJQsifeh8L4OAXavuGkrwze4_74zSNJXGn' );
        $msg = array
        (
            'message'   => 'SOS', //
            'title'     => 'SOS !!! Ada Kondisi Darurat',
            'subtitle'  => 'This is a subtitle. subtitle',
            'tickerText'    => 'Ticker text here...Ticker text here...Ticker text here',
            'vibrate'   => 1,
            'sound'     => 1,
            'largeIcon' => 'large_icon',
            'smallIcon' => 'small_icon'
        );
        $fields = array
        (
            'registration_ids'  => $Token,
            'data'              => $msg,
            'notification'      => $msg
        );

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
        curl_setopt( $ch,CURLOPT_POSTFIELDS, json_encode( $fields ) );
        $result = curl_exec($ch );

        echo json_encode($result);
        curl_close( $ch );
    }
}