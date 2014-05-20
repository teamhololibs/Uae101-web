<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8" />
        <meta http-equiv="content-language" content="en" />
        <meta name="description" content="{$META_NAME_DESCRIPTION}" />
        <meta name="keywords" content="{$META_NAME_KEYWORDS}" />
        <link rel="shortcut icon" href="/favicon.ico" />
        <link rel="stylesheet" type="text/css" href="/css/main.css"/>
        <link rel="stylesheet" type="text/css" href="/css/nanoscroller.css"/>
        <link rel='stylesheet' type='text/css' href='//fonts.googleapis.com/css?family=Quintessential|Arimo|Asap|Fauna+One' />
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
        <script type="text/javascript" src="/js/jquery.ellipsis.min.js"></script>
        <script type="text/javascript" src="/js/jquery.dotdotdot.min.js"></script>
        <script type="text/javascript" src="/js/jquery.nanoscroller.min.js"></script>
        <script type="text/javascript">
            if (typeof jQuery == 'undefined') {
                document.write("<script type='text/javascript' src='js/jquery-1.9.1.js'><\/script>");
                document.write("<script type = 'text/javascript' src = '/js/js.functions.js' ><\/script>");
                //console.log('Server copy of jQuery Loaded');
            }
        </script>
        <script type="text/javascript" src="/js/js.functions.js"></script>
        <title>{$META_TITLE}</title>
    </head>
    <body>
        <div id="wrapper" class="wrapper">
            {include file="common/header.tpl" var_name=$HEADER_VARS}
            <div id="left_menu" class="left_menu nano">
                <div id="" class="nano-content">
                    {$LEFT_MENU}
                </div>
            </div>
            <div class='content_holder'>
                {$MAIN_CONTENT}
            </div>
            {include file="common/footer.tpl"}
            <div style='clear: both'></div>
        </div>
    </body>
</html>