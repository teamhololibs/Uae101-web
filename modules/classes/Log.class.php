<?php

class Log {

    private $type;
    private $file_name;
    private $message;
    private $folder_path;
    private $file_pointer = NULL;
    private static $instance = null;

    /**
     * Writes the message to corresponding log type 
     * @param string Type of log
     * @param string Message to be logged
     */
    public static function Write($type, $message) {
        $log = new Log;
        $log->LogWrite($type, $message);
    }

    public function LogWrite($type, $message) {

        $this->message = $message;
        switch ($type) {
            case 'database':
                $this->folder_path = SERVER_PATH . "/logs/databases/";
                break;
            case 'article':
                $this->folder_path = SERVER_PATH . "/logs/articles/";
                break;
            case 'user':
                $this->folder_path = SERVER_PATH . "/logs/users/";
                break;
            default:
                die("Unkown Log Type $type");
        }

        $this->file_name = "$type-";
        if (!$this->file_pointer)
            $this->FileOpen();

        $this->FileWrite();
    }

    private function FileWrite() {
        $time = date('H:i:s');
        $message = $this->message;
        fwrite($this->file_pointer, "$time - $message \r\n");
    }

    private function FileOpen() {
        $date = date('Y-m-d');
        $file_complete_path = $this->folder_path . $this->file_name . $date . ".txt";

        // File name changes per day
        // If file exists, uses the same file else creates a file
        $this->file_pointer = fopen($file_complete_path, 'a') or exit("Can't open log file : $lfile!");
    }

}

?>