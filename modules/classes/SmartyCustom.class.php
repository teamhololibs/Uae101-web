<?php

require_once SERVER_PATH . "/modules/plugins/smarty/libs/Smarty.class.php";

class SmartyCustom extends Smarty {

    private $to_address;
    private $subject;
    private $mail_body;
    private $email_text_id;

    public function __construct() {
        parent::__construct();
        //$smarty->force_compile = true;
        //$smarty->cache_lifetime = 120;
        $this->debugging = SMARTY_DEBUGGING;
        $this->debugging_ctrl = SMARTY_DEBUGGING_CTRL;
        $this->caching = SMARTY_CACHING;

        $this->setTemplateDir(SMARTY_TEMPLATES_DIR)
                ->setCompileDir(SMARTY_TEMPLATES_C_DIR)
                ->setConfigDir(SMARTY_CONFIG_DIR);
    }

}
