$(document).ready(function() {
    $(document).on("keyup", ".cat_autocomplete", function(event) {
        //console.log($(this).val().length);
        TagAutocomplete($(this));
        if($(this).val().length == 0){
            $("#id_" + $(this).attr('id')).val('');
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

    function TagAutocomplete(element) {
        var id = $(element).attr('id');
        var autocomplete_value = $(element).val();
        //console.log(id);
        $(element).autocomplete({
            minLength: 2,
            source: function(request, response) {
                $.ajax({
                    url: "categories_ajax.php?operation=get_categories",
                    type: 'post',
                    dataType: "json",
                    data: {
                        category_str: autocomplete_value,
                    },
                    success: function(data) {
                        response($.map(data, function(item) {
                            return {
                                label: item.full_name,
                                value: item.category_id
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
                $('#id_' + id).val(ui.item.value);
                $('#' + id).val(ui.item.label);
                return false;
            }
        });
    }
});