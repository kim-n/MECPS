$(function(){
    $(".comment-new").hide();
    $(".comments-list").hide();
    // 
    //if url is that of a question show page
    if (window.location.pathname.indexOf("questions") != -1){
        $(".comments-list").show();
        $(".question > .comment-new").show();
        $(".responses-botton").hide();
    }
    
    $("body").on("click", ".responses-botton", function(event) {
        event.preventDefault();
        $thisQuestion = $(this).parent().parent();
        
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