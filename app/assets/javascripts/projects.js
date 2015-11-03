// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('.projects.show').ready(function(){
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

    ////////////////////////////////////////

    $(".project-thumbnail").click(function(e){
        var el = $(e.target);
        $("#large_image img").attr('src', el.attr('data-url'));
        $("#image_caption").text(el.attr('title'));
        $("#link_image_id").text(el.attr('data-id'));
        $("#image_delete_link").attr('href', '/images/' + el.attr('data-id'));
        return e.preventDefault();
    });

    ////////////////////////////////////////

    var pending = false;
    var indicator = $("#indicator");

    $("#blog_post_text").keypress(function(e){
        if(!pending){
            pending = true;
            window.setTimeout(saveProgress, 3000);
            indicator.text("");
        }
    });

    var saveProgress = function(){
        var text = $("#blog_post_text").val();
        var id = $("#project_id").val();
        var token = $("input[name=authenticity_token]").val();
        indicator.text("Saving...");
        $.post("/projects/"+id,
               { project: { unfinished_post: text }, _method: 'PUT', authenticity_token: token },
               function(){ pending = false; indicator.text("Saved"); });
    };
});
