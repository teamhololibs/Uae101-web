$(document).ready(function() {
    var current_href = window.location.href.split('.com').pop();

    windowResize();
    $(window).resize(function() {
        windowResize();
    });
    $(document).on('keyup', ".submit_library textarea[maxlength]", function() {
        textAreaLength($(this));
    });
    $('.textbox_android').before("<div class='textbox_android_before'></div>").after("<div class='textbox_android_after'></div>");
    $('.dropdown').click(function() {
        var parent_id = $(this).attr('alt');
        $('.children_' + parent_id).toggle('fast');
        $('.expand_parent_' + parent_id).toggle();
        $('.minimize_parent_' + parent_id).toggle();
        $(".nano").nanoScroller();
    });
    $('.left_menu').css('top', $('.header').outerHeight());
    $(".nano").nanoScroller();
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
    var inResource = 0;
    $('.cat_search_img').hover(function() {
        $('.cat_search').show('fast');
        $('#cat_search').focus();
    });

    $(document).click(function(evt) {
        var s = evt.target.firstElementChild.className;
        if (s.indexOf("left_menu_click_capture") > -1)
            return;
//        console.log(evt.target.firstElementChild.className);
        $('.categories_dropdown').slideUp('fast');
    });
    $('#top_menu .left_category_menu').click(function() {
        $('.categories_dropdown').slideDown('fast');
    });

    $('#cat_search').keyup(function() {
        if ($('#cat_search').val().length == 0) {
            return;
        }
        categorySearchAjax($('#cat_search').val());
    });
    $('.input_resource_search').keyup(function() {
        resourceSearch($('.input_resource_search').val());
    });
    function categorySearchAjax(category_search) {
        $.ajax({
            url: '/category_search',
            type: 'get',
            data: {
                category_name: category_search,
            },
            success: function(data) {
                $('.left_category_menu').html(data);
                $(".nano").nanoScroller();
            }
        });
    }
    function resourceSearch(resource_search) {
        $('.left_category_menu li a').removeClass('selected');
        var historystate, historyurl;
        if (resource_search.length == 0) {
            resource_search = '';
            historystate = {search: ''};
            historyurl = window.location.pathname;
            $('.input_resource_search').val('');
            //return;
        } else {
            historystate = {search: resource_search};
            historyurl = '/?search=' + resource_search;
        }
        resourceSearchAjax(resource_search);
        window.history.pushState(historystate, "", historyurl);
    }
    function resourceSearchAjax(resource_search) {
        $('.loading_animation').show();
        $.ajax({
            //url: '',
            type: 'get',
            dataType: "json",
            data: {
                search: resource_search,
                ajax: 1,
            },
            success: function(data) {
                $('.content_holder').html(data.data);
                document.title = data.title;
                setTimeout("jQuery('.loading_animation').hide();", 2000);
                windowResize();
            }
        });
    }
    window.onpopstate = function(event) {
        //console.log("location: " + document.location + ", state: " + JSON.stringify(event.state));
        var search;
        if (event.state == null) {
            search = '';
        } else {
            search = event.state.search;
        }
        resourceSearchAjax(search);
        $('.input_resource_search').val(search);
    };
    function updateQueryString() {
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
                /*
                 } else if (typeof query_string[pair[0]] === "string") {
                 var arr = [query_string[pair[0]], pair[1]];
                 query_string[pair[0]] = arr;
                 // If third or later entry with this name
                 } else {
                 query_string[pair[0]].push(pair[1]);
                 */
            }
        }

        // Now the parameters before ?
        var urlpathname = window.location.pathname;
        vars = urlpathname.split("/");
        var i = 0;
        for (var i = 0; i < vars.length; i++) {
            query_string[i] = vars[i];
        }
        return query_string;
    }
});

function windowResize() {
    if ($(document).height() == window.innerHeight) {
        $('.footer').addClass('footer_absolute');
    } else {
        $('.footer').removeClass('footer_absolute');
    }

    var content_holder_width;
    var cat_width = 0;
    var emirates_width = 0;

    if ($(document).width() > 800) {
        $('#left_menu').show();
        $('#top_menu').hide();
        $('.categories_dropdown').show();
        $('.content_holder').css('float', 'right');
        content_holder_width = $(document).width() - $('.left_menu').width();
        $('.content_holder').width(content_holder_width);
        if (content_holder_width > 1000) {
            content_holder_width -= 80;
            cat_width = (content_holder_width) / 2;
            cat_width -= 20;
            emirates_width = content_holder_width + 12;
        } else {
            content_holder_width -= 70;
            cat_width = content_holder_width;
            emirates_width = content_holder_width;
        }
        $('.category_box').width(cat_width);
        $('.emirates_row').width(emirates_width);
    } else {
        $('#left_menu').hide();
        $('#top_menu').show();
        $('.categories_dropdown').hide();
        var doc_width = $(document).width() - 80;
        console.log($(document).width());
        console.log(doc_width);
        $('.content_holder').css('float', 'none');
        $('.content_holder').width(doc_width);
        $('.category_box').width(doc_width);
        $('.emirates_row').width(doc_width);
    }
}
function textAreaLength(element) {
// Store the maxlength and value of the field.
    var maxlength = $(element).attr('maxlength');
    var val = $(element).val();
    var char_left = maxlength - $(element).val().length;
    //$(element).parent().find('#char_left').html(char_left);
    $('#char_left').html(char_left);
    // Trim the field if it has content over the maxlength.
    if (val.length > maxlength) {
        $(element).val(val.slice(0, maxlength));
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