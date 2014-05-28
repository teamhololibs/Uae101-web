$(document).ready(function() {
    // category = 1 for TagAuto 
    // author = 2 for TagAuto 

//    tinymce.init({
//        selector: "#description",
////        width: '100%',
////        theme: "advanced",
////        force_br_newlines: false,
////        force_p_newlines: false,
//        mode: "textareas",
//        forced_root_block: '',
//        plugins: ["advlist autolink lists link image charmap print preview anchor", "searchreplace visualblocks code fullscreen", "insertdatetime media table contextmenu paste"],
//        toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
//        paste_auto_cleanup_on_paste: true,
//        paste_postprocess: function(pl, o) {
//            // remove &nbsp
//            o.node.innerHTML = o.node.innerHTML.replace(/&nbsp;/ig, " ");
//        },
//        cleanup_callback: 'my_cleanup_callback'
//    });

    function my_cleanup_callback(type, value) {
        switch (type) {
            case 'get_from_editor':
                // Remove &nbsp; characters
                value = value.replace(/&nbsp;/ig, ' ');
                break;
            case 'insert_to_editor':
            case 'submit_content':
            case 'get_from_editor_dom':
            case 'insert_to_editor_dom':
            case 'setup_content_dom':
            case 'submit_content_dom':
            default:
                break;
        }
        return value;
    }

    $("#slider").slider({
        //value: 5,
        min: 1,
        max: 3,
        step: 1,
        slide: function(event, ui) {
            $("#rating").val(ui.value);
        }
    });
    $("#slider").slider("value", $("#rating").val());
    $(document).on("blur", "#rating", function(event) {
        var new_val = $(this).val();
        $("#slider").slider("value", new_val);
    });

    $('.author_autocomplete').bind('paste', function(e) {
        //setTimeout(function() {$('.author_autocomplete').trigger(TagAutocomplete($('.author_autocomplete'), 2));}, 0);
        TagAutocomplete($('.author_autocomplete'), 2);
    });
    $('.cat_autocomplete').bind('paste', function(e) {
        //setTimeout(function() {$('.author_autocomplete').trigger(TagAutocomplete($('.author_autocomplete'), 2));}, 0);
        TagAutocomplete($('.cat_autocomplete'), 1);
    });

    $(document).on("keyup", ".cat_autocomplete", function(event) {
        //console.log($(this).val().length);
        TagAutocomplete($(this), 1);
        if ($(this).val().length == 0) {
            $("#id_" + $(this).attr('id')).val('');
        }
    });

    $(document).on("keyup", ".author_autocomplete", function(event) {
        //console.log($(this).val().length);
        TagAutocomplete($(this), 2);
        if ($(this).val().length == 0) {
            $("#author_id").val('');
        }
    });

    $(document).on("click", "#add_cat", function(event) {
        //console.log($('#res_cat_table tr').length);
        var rows = $('#res_cat_table tr').length + 1;
        $.ajax({
            url: "resources_tr_cat.php",
            type: 'post',
            data: {
                rows: rows,
            },
            success: function(data) {
                //console.log(data);
                $('#res_cat_table tr:last').after(data);
            }
        });

    });

    function TagAutocomplete(element, type) {
        var id = $(element).attr('id');
        var autocomplete_value = $(element).val();
        //console.log(id);
        //Category
        if (type == 1) {
            var url = "categories_ajax.php?operation=get_categories";
            var auto_id = '#id_' + id;
            var auto_label = '#' + id;
        }
        //Author
        else if (type == 2) {
            var url = 'authors_ajax.php?operation=get_authors';
            var auto_id = '#author_id';
            var auto_label = '#author_name';
        }
        $(element).autocomplete({
            minLength: 0,
            source: function(request, response) {
                $.ajax({
                    url: url,
                    type: 'post',
                    dataType: "json",
                    data: {
                        auto_str: autocomplete_value,
                    },
                    success: function(data) {
                        response($.map(data, function(item) {
                            if (type == 1) {
                                return {
                                    label: item.full_name,
                                    value: item.cat_id
                                }
                            }
                            if (type == 2) {
                                return {
                                    label: item.name,
                                    value: item.author_id
                                }
                            }
                        }));
                    },
                    error: function() {
                        $(element).autocomplete("close");
                    }
                });
            },
            select: function(event, ui) {
                //console.log(ui);
                $(auto_id).val(ui.item.value);
                $(auto_label).val(ui.item.label);
                return false;
            }
        });
    }
});