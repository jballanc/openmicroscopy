$(document).ready(function() {
    
    // All the links to eman-processed images - simply display the image in the page
    $(".eman").click(function() {
        
        var href = $(this).attr('href');
        var $image = $("#processed");
        $image.attr('src', href);
        
        return false;
    });
    
    
    // when the form is displayed, we bind the runScript function to the form submission. 
    var displayForm = function() {
        var href = $(this).attr('href');
        var $scriptForm = $("#scriptForm");
        $.get(href, function(data) {
          $(data).appendTo($scriptForm);
          $('#scriptForm form').submit(runScript);
        });
        return false;
    };
    
    // function to handle submission of the form and opening results window...
    var runScript = function() {
        var scriptName = $("#scriptForm .scriptName").text();
        var newWindow=window.open('','','height=250,width=700,left=50');
          newWindow.document.write('<html><title>Results</title>');
          newWindow.document.write('<h3>Running ' + scriptName + '</h3>');
          newWindow.document.write('<p>Waiting for results...</p>');
          newWindow.document.write('</html>');
          newWindow.document.close();
          if (window.focus) {newWindow.focus()}
          

          
        var postData = $(this).serialize() + '&op=Save';
        var actionUrl = $(this).attr('action');
        $.post(actionUrl, postData, function(data) {
            // replace the form with a "script running" page
          $('#scriptForm form').remove();
          $(data).appendTo('#scriptForm');
          // 
          var resultsUrl = $('#resultsLink').attr('href');
          newWindow.location = resultsUrl;
        });
        return false;
    };
      
    // The links to scripts get the form and put it in the page...
    $(".script").click(displayForm);
});