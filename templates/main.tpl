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
{*        <link rel="stylesheet" type="text/css" href="/css/jquery.fancybox.css"/>*}
        <link rel='stylesheet' type='text/css' href='//fonts.googleapis.com/css?family=Quintessential|Arimo|Asap|Fauna+One' />
        <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
        <script type="text/javascript" src="/js/jquery.ellipsis.min.js"></script>
        <script type="text/javascript" src="/js/jquery.dotdotdot.min.js"></script>
        <script type="text/javascript" src="/js/jquery.nanoscroller.min.js"></script>
{*        <script type="text/javascript" src="/js/fancybox/source/jquery.fancybox.js"></script>*}
        <script type="text/javascript">
            if (typeof jQuery == 'undefined') {
                document.write("<script type='text/javascript' src='js/jquery-1.9.1.js'><\/script>");
                document.write("<script type = 'text/javascript' src = '/js/js.functions.js' ><\/script>");
                //console.log('Server copy of jQuery Loaded');
            }
        </script>
        <script type="text/javascript" src="/js/js.functions.js"></script>
        {*<script type="text/javascript">
            (function() {
                var po = document.createElement('script');
                po.type = 'text/javascript';
                po.async = true;
                po.src = 'https://plus.google.com/js/client:plusone.js?onload=start';
                var s = document.getElementsByTagName('script')[0];
                s.parentNode.insertBefore(po, s);
            })();
        </script>*}
        <title>{$META_TITLE}</title>
        <link rel="stylesheet" type="text/css" href="/css/blockmoving.css"/>
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
                <div class="loading_animation">
                    <div id="blok1" class="blokje"></div>
                    <div id="blok2" class="blokje"></div>
                    <div id="blok3" class="blokje"></div>
                    <div id="blok4" class="blokje"></div>
                    <div id="blok5" class="blokje"></div>
                </div>
                {*<div id="loadingProgressG">
                <div id="loadingProgressG_1" class="loadingProgressG">
                </div>
                </div>*}
                {*<div id="movingBallG">
                <div class="movingBallLineG">
                </div>
                <div id="movingBallG_1" class="movingBallG">
                </div>
                </div>*}
                {$MAIN_CONTENT}
            </div>
            {include file="common/footer.tpl"}
            <div style='clear: both'></div>
        </div>
        <script type="text/javascript">
            // Google+ Sign in
            function signInCallback(authResult) {
                console.log(authResult);
                if (authResult['code']) {

                    // Hide the sign-in button now that the user is authorized, for example:
                    $('#signinButton').attr('style', 'display: none');

                    // Send the code to the server
                    $.ajax({
                        type: 'POST',
                        url: 'gplus?storeToken',
                        contentType: 'application/octet-stream; charset=utf-8',
                        success: function(result) {
                            // Handle or verify the server response if necessary.

                            // Prints the list of people that the user has allowed the app to know
                            // to the console.
                            console.log(result);
                            if (result['profile'] && result['people']) {
                                $('#results').html('Hello ' + result['profile']['displayName'] + '. You successfully made a server side call to people.get and people.list');
                            } else {
                                $('#results').html('Failed to make a server-side call. Check your configuration and console.');
                            }
                        },
                        processData: false,
                        data: authResult['code']
                    });
                } else if (authResult['error']) {
                    // There was an error.
                    // Possible error codes:
                    //   "access_denied" - User denied access to your app
                    //   "immediate_failed" - Could not automatially log in the user
                    console.log('There was an error: ' + authResult['error']);
                }
            }
            //po.src = 'https://apis.google.com/js/client:plusone.js?lang=en-US&';
        </script>
    </body>
</html>