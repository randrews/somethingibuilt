// Make the formatting help links work
$(document).ready(function(){
    $(".formatting-help-link").click(function(e){
        $(".formatting-help").toggle();
        return e.preventDefault();
    });

    $(".big-editor-link").click(function(e){
        var editor = $('.blog-post-editor');
        if(editor.attr('rows') == 5)
            editor.attr('rows', 20);
        else
            editor.attr('rows', 5);

        return e.preventDefault();
    });
});
