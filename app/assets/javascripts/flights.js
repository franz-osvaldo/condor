$(document).on('turbolinks:load', function() {
    $('.add_passenger').click(function () {
        // $('.passenger:hidden:first').css('display', 'block');
        $('.passenger:hidden:first').slideDown(500);
    });
    $('.remove_passenger').click(function () {
        // $(this).parent().parent().css('display', 'none');
        $(this).parent().parent().slideUp(500, function () {
            $(this).find('input').val('');
        });
        $(this).parent().parent().appendTo($('#passengers_container'));
    });
    $('.passenger_name input[type=text]').each(function(){
        var text_value=$(this).val();
        if(text_value!='')
        {
            $(this).parent().parent().slideDown(500);
        }
    })
});