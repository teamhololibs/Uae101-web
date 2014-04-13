$(document).ready(function() {
    $(document).on("change", "input.form_radio", function(event) {
        var parent = event.currentTarget.value;
        if(parent == 0){
            $("#parent").prop( "disabled", false);
        } else {
            $("#parent").prop( "disabled", true);
        }
    });
});