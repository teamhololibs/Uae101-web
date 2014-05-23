$(document).ready(function() {
    var current_href = window.location.href.split('.com').pop();
    windowResize();
    $(window).resize(function() {
        windowResize();
    });
    $('.left_category_menu a').click(function() {
//console.log('a');
//return false;
    });
    $('.textbox_android').after("<span class='textbox_android_after'></span>");
    $('.dropdown').click(function() {
        var parent_id = $(this).attr('alt');
        //console.log('parent' + $(this).attr('alt'));
        $('.children_' + parent_id).toggle('fast');
        $('.expand_parent_' + parent_id).toggle();
        $('.minimize_parent_' + parent_id).toggle();
        $(".nano").nanoScroller();
    });
//    $(document).on("click", ".expand_resource", function(event) {
//        var res_url = $(this).attr('href');
//        var res_id = $(this).attr('alt');
//        $.ajax({
//            //url: "",
//            type: 'get',
//            data: {
//                res_id: res_id,
//                ajax: 1,
//            },
//            success: function(data) {
//                $('.content_holder').html(data);
//            }
//        });
//        window.history.pushState({res_id: res_id}, "", res_url);
//        return false;
//    });
    $('.resource_name').ellipsis({
        row: 2,
        char: '...', //$('a.readmore'),
        callback: function() {
            //console.log('el');
        }
    });
//    $('.resource_desc').dotdotdot({
//        ellipsis: ' ',
//        height: 170,
//        watch: window,
//        after: "a.readmore",
//    });
    $('.input_resource_search').keyup(function() {
        var resource_search = $(this).val();
        var historystate, historyurl;
        console.log(current_href);
        if (resource_search.length == 0) {
            resource_search = '';
            historystate = {search: ''};
            historyurl = current_href;
            $('.input_resource_search').val('');
            //return;
        } else {
            historystate = {search: resource_search};
            historyurl = '?search=' + resource_search;
        }
        resourceSearch(resource_search);
        window.history.pushState(historystate, "", historyurl);
    });
    var QueryString = function() {
        // This function is anonymous, is executed immediately and 
        // the return value is assigned to QueryString!
        var query_string = {};
        var query = window.location.search.substring(1);
        var vars = query.split("&");
        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split("=");
            // If first entry with this name
            if (typeof query_string[pair[0]] === "undefined") {
                query_string[pair[0]] = pair[1];
                // If second entry with this name
            } else if (typeof query_string[pair[0]] === "string") {
                var arr = [query_string[pair[0]], pair[1]];
                query_string[pair[0]] = arr;
                // If third or later entry with this name
            } else {
                query_string[pair[0]].push(pair[1]);
            }
        }

        // Now the parameters before ?
        var urlpathname = window.location.pathname;
        vars = urlpathname.split("/");
        var i = 0;
        for (var i = 0; i < vars.length; i++) {
            //console.log(vars[i]);
        }
        return query_string;
    }();
    //console.log(QueryString);
    $('.left_menu').css('top', $('.header').outerHeight());
    $(".nano").nanoScroller();
    //console.log($('.header').position().top + $('.header').outerHeight(true));
    $(window).scroll(function() {
        var winTop = $(this).scrollTop();
        var headerHeight = $('.header').outerHeight();
        if (winTop > headerHeight) {
            $('.left_menu').css('top', 0);
        } else {
            $('.left_menu').css('top', headerHeight - winTop);

        }
        $(".nano").nanoScroller();
    });
});
window.onpopstate = function(event) {
    console.log("location: " + document.location + ", state: " + JSON.stringify(event.state));
    //console.log(event);
    var search;
    if (event.state == null) {
        console.log('fds');
        search = '';
    } else {
        search = event.state.search;
    }
    resourceSearch(search);
    $('.input_resource_search').val(search);
};
function resourceSearch(resource_search) {
    //console.log(resource_search);
    $.ajax({
        //url: "",
        type: 'get',
        data: {
            search: resource_search,
            ajax: 1,
        },
        success: function(data) {
            $('.content_holder').html(data);
        }
    });
}
function windowResize() {
    var content_holder_width = $(document).width() - $('.left_menu').width();
    $('.content_holder').width(content_holder_width);
//    console.log($(document).height());
//    console.log(window.innerHeight);
//
//    var content_holder_height = $('.content_holder').height();
//    if ($(document).height() == window.innerHeight) {
//        content_holder_height = window.innerHeight - $('.header').height() - 15;
//        $('.content_holder').height(content_holder_height);
//    }
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