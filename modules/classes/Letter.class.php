<?php

require_once SERVER_PATH . "/modules/plugins/phpmailer/class.phpmailer.php";
/*
$mail = new PHPMailer();
$mail->IsSMTP();  // telling the class to use SMTP
$mail->Host = "smtp.gmail.com"; // SMTP server
$mail->From = "forgetmenot@gmail.com";
$mail->AddAddress("prstsn@gmail.com",'asda');
$mail->Subject = "First PHPMailer Message";
$mail->Body = "Hi! \n\n This is my first e-mail sent through PHPMailer.";
$mail->WordWrap = 50;
if (!$mail->Send()) {
    echo 'Message was not sent.';
    echo 'Mailer error: ' . $mail->ErrorInfo;
} else {
    echo 'Message has been sent.';
}
*/

class Letter {

    private $to_address;
    private $subject;
    private $mail_body;
    private $email_text_id;

    public function __construc($email_text_id) {
        
    }

    public function AddParameter($key, $value) {
        
    }

    public function SentMail() {
        
    }

}