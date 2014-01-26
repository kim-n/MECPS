// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(function (){
    // on document ready hide sign in section
    $("div#session-section").hide()
    
    // whem sign-in-botton is clicked session-section is toggled
    $("body").on("click", "#sign-in-botton", function (event){
        event.preventDefault();
        
        $signInSection = $("div#session-section")
        $signInSection.toggle(); 
    });    

    
    function autfill(className, maxWidth){
        $.each( $('.' + className), function(){
            $(this).height()
            
            
            if ($(this).width() > maxWidth){
                fontSize = parseInt($(this).css("font-size"), 10),
                multiplier = maxWidth/$(this).width(),
                newSize = (fontSize*(multiplier-0.1));
                $(this).css("font-size", newSize )
                
            }
        })
    };
    
    autfill("fill-sq-title", 200);
    autfill("fill-book-title", 770);
    
})

