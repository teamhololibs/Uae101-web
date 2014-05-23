<?php

class Config {

    protected $config_id;
    protected $config_info = array();
    protected $type;

    public function GetConfig($name, $default = null, $type = 'text') {
        $name = TextToDB($name);
        $this->config_info = GetRowById('configs', 'name', $name);
        if ($this->config_info == null) {
            return $default;
        }
        switch ($type) {
            case 'text':
                return $this->config_info['value'];
        }
    }

}

?>
