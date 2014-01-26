$(function(){
    $(".question .comment-new").hide();
    $(".comments-list .comment-new").hide();
    $(".question .comments-list").hide();
    
    $("body").on("click", ".responses-botton", function(event) {
        event.preventDefault();
        $thisQuestion = $(this).parent().parent();
        $(".comments-list").hide()
        
        $thisQuestion.children(".comments-list").toggle();
    });
    
    
    $("body").on("click", ".comment-botton", function(event) {
        event.preventDefault();
        
        $thisQuestion = $(this).parent().parent();
        $thisQuestion.children(".comment-new").toggle();
    });
    
    
    
    $("body").on("click", ".comment-exit", function(event) {
        event.preventDefault();
        
        $thisQuestion = $(this).parent().parent();
        $thisQuestion.children(".comment-new").hide();
    });
})