$(document).ready(function(){
    console.log('2');
    $(".data_container #value").on("blur", function(event){
        var val = $(this).val();
            
        console.log('1');
        if(val == 'true' || val == 'false'){
            $('#type option[value=boolean]').attr('selected', 'selected');
        }
                    
    });
});
