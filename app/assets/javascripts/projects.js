// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
    $("#big_editor_link").click(function(e){
        var editor = $('textarea');
        if(editor.attr('rows') == 5)
            editor.attr('rows', 20);
        else
            editor.attr('rows', 5);

        return e.preventDefault();
    });

    $("#formatting_help_link").click(function(e){
        $("#formatting_help").toggle();
        return e.preventDefault();
    });
});
