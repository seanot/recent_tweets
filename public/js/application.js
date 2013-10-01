$(document).ready(function() {
    $('#get_tweets').submit(function(event) {
        event.preventDefault();

        var url = $(this).attr('action');
        var data = $(this).serialize();

        $.ajax({
            url: url,
            type: 'POST',
            data: data,
        })
        .done(function(response) {
            console.log("success");
            console.log(response);
            var tweets = $(response).find('p');
            $('p').remove();
            $('#get_tweets').after(tweets);      
            $('#input_box').focus();
        })
        .fail(function() {
            console.log("error");
        })
        .always(function() {
            console.log("complete");
        });
        this.reset();
    })
});
