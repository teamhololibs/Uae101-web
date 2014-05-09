$(document).ready(function() {
    var current_href = window.location.href.split('.com').pop();
    $('.search_button_text').click(function() {
        var current_page = get_current_page_name();
        var search_visibility = get_current_page_search_cookie();
        toggle_search();
        if (search_visibility == false || search_visibility.localeCompare('close') == 0) {
            CheckCookie('search_visibility_' + current_page, 'open');
            OpenSearchContainer();
        } else {
            CheckCookie('search_visibility_' + current_page, 'close');
            CloseSearchContainer();
        }
    });

    $('.ui-datepicker-enable').datepicker({
        changeMonth: true,
        changeYear: true,
        showOtherMonths: true,
        selectOtherMonths: true,
        dateFormat: "dd-mm-yy"
    });

    $('.loading_gif').css('display', 'none');

    $('.make_dialog').click(function() {
        var $link = $(this);
        var title = $link.attr('title') || 'Options';
        var href = $link.attr('href');
        var classname = $link.attr('alt') || '';
        if (classname.length == 0) {
            classname = ' .main_content';
        } else {
            classname = ' .' + classname;
        }
        var $dialog = $("<div class='jquery-dialog' ></div>")
                .load(href + classname)
                .dialog({
                    draggable: true,
                    modal: true,
                    autoOpen: false,
                    title: title,
                    width: 1000,
                    height: 'auto',
                    position: {
                        at: "center top+20%"
                    },
                    close: function(event, ui) {
                        window.history.pushState("", "previous url", current_href);
                        //window.history.back();
                    }
                });
        window.history.pushState('', "New url", "/" + href);

        $dialog.dialog('open');
        return false;
    });

    check_search_visibility();

    CheckConfirmationMessage();

});

window.onpopstate = function(event) {
    $( ".jquery-dialog" ).dialog( "close" );
    console.log("location: " + document.location + ", state: " + JSON.stringify(event.state));
};

function SetConfirmationMessage(message, type) {
    $('.confirmation_message').attr('class', 'confirmation_message');
    $('.confirmation_message').fadeIn(500);
    $('.confirmation_message').html(message);
    if (type)
        $('.confirmation_message').addClass(type);
    $('.confirmation_message').show();
    CheckConfirmationMessage();
}

function CheckConfirmationMessage() {
    if ($('.confirmation_message').length != 0) {
        setTimeout(function() {
            $(".confirmation_message").fadeOut(500);
        }, 5000);
    }
}
function toggle_search() {
    $('.search_elements').toggle();
    $('.indicator').toggle();
    /*
     $('.search_elements').toggle('fast', function() {
     $('.indicator').toggle();
     });
     */
}
function OpenSearchContainer() {
    $('.data_container').css('width', '84%');
    //        $('.data_top_options').addClass('data_top_options_right');
    $('.search_options').css('width', '');
}
function CloseSearchContainer() {
    $('.data_container').css('width', '99.9%');
    //        $('.data_top_options').removeClass('data_top_options_right');
    $('.search_options').css('width', '10%');
}
function check_search_visibility() {
    var search_visibility = get_current_page_search_cookie();
    var search_permission = true;
    if ($('.search_elements').length == 0)
        search_permission = false;
    if (search_permission == false || search_visibility == false || search_visibility.localeCompare('close') == 0) {
        CloseSearchContainer();
    } else {
        OpenSearchContainer();
        toggle_search();
    }
}
function get_current_page_name() {
    // Get current page name
    var current_path = window.location.pathname;
    var current_page = current_path.substring(current_path.lastIndexOf('/') + 1);
    return current_page;
}
function get_current_page_search_cookie() {
    var current_page = get_current_page_name();
    var search_visibility = CheckCookie('search_visibility_' + current_page);
    return search_visibility;
}

// Checks if the cookie exists and returns the value of that cookie.
// If value is provided and cookie exists: updates the cookie with this value
// If value is provided and cookie does not exist: creates cookie with this value
// If expiry_days is given and cookie exists: ignore time.
// If expiry_days is not given and cookie does not exist: creates cookie with default value of 7 days
function CheckCookie(cookie_name, value, expiry_days) {
    var cookie_exist = GetCookie(cookie_name, value, expiry_days);
    if (cookie_exist == false) {
        if (!value) {
            return false;
        }
        SetCookie(cookie_name, value, expiry_days);
        return unescape(value);
    }
    else if (value && cookie_exist[0] != value) {
        if (cookie_exist[1])
            SetCookie(cookie_name, value, 0, cookie_exist[1]);
        else {
            SetCookie(cookie_name, value);
        }
        return unescape(value);
    }
    else {
        return cookie_exist[0];
    }
}

// Sets 2 cookies
// a) Actual cookie variable with its value
// b) Another cookie with the above cookiename_EXPIRY to save its time of expiry
function SetCookie(cookie_name, value, expiry_days, current_expiry) {
    if (expiry_days && !current_expiry) {
        if (expiry_days > 15)
            expiry_days = 15;
        var cookie_time = new Date();
        cookie_time.setDate(cookie_time.getDate() + expiry_days);
        var c_time = ";expires=" + cookie_time.toUTCString();
        var cookie_set_str = escape(cookie_name) + "=" + value + c_time;
        document.cookie = cookie_set_str;
        document.cookie = escape(cookie_name) + "_EXPIRY=" + cookie_time.toUTCString() + ";expires=" + c_time;
    }
    else if (!expiry_days && current_expiry) {
        document.cookie = escape(cookie_name) + "=" + value + ";expires=" + current_expiry;
    }
    else {
        document.cookie = escape(cookie_name) + "=" + value;
    }
}


function GetCookie(cookie_name) {
    var cookies = document.cookie.split(";");

    for (var i = 0; i < cookies.length; i++) {
        var cookie = cookies[i].substr(0, cookies[i].indexOf("="));
        var value = cookies[i].substr(cookies[i].indexOf("=") + 1);
        while (cookie.charAt(0) == ' ')
            cookie = cookie.substring(1, cookie.length);
        if (cookie_name.localeCompare(cookie) == 0) {
            var cookie_info = new Array();
            cookie_info[0] = unescape(value);
            var cookie_exp = GetCookie(cookie_name + "_EXPIRY");
            cookie_exp = cookie_exp[0];
            if (cookie_exp != false) {
                cookie_info[1] = unescape(cookie_exp);
            }
            return cookie_info;
        }
    }
    return false;
}

// example 3: strstr('name@example.com', '@');
// returns 3: 'example.com'
// example 4: strstr('name@example.com', '@', true);
// returns 4: 'name'
function strstr(haystack, needle, bool) {
    var pos = 0;
    haystack += '';
    pos = haystack.indexOf(needle);
    //console.log(pos);
    if (pos == -1) {
        return false;
    } else {
        if (bool) {
            return haystack.substr(0, pos);
        } else {
            return haystack.slice(pos + 1);
        }
    }
}