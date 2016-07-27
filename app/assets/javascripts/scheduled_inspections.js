$(document).on('turbolinks:load', function() {

    $('.selectpicker').selectpicker();
    $('.tarea-mantenimiento').on('click', '#add-task',function () {
        $(this).parent().parent().next().slideDown(1000);
    });
    $('.scheduled_inspections.edit .tarea-mantenimiento').on('click', '#add-task',function () {
        $(this).parent().parent().next().next().slideDown(1000);
    });
    $('.tarea-mantenimiento').on('click','#remove-task', function () {
        $(this).parent().parent().slideUp(1000, function () {
            $(this).find('input, textarea').val('');
        });
    });
    $('.administrar-tiempo').on('click', '#add-time-limit', function () {
        $(this).parent().parent().next().fadeIn();
    });

    $('.scheduled_inspections.edit .administrar-tiempo').on('click', '#add-time-limit', function () {
        $(this).parent().parent().next().next().fadeIn();
    });

    $('.administrar-tiempo').on('click', '#remove-time-limit', function () {
        $(this).parent().parent().fadeOut();
    });

    function my_func() {
        if(document.getElementsByClassName('edit').length > 0 ){
            var cont = 0;
            var list = document.getElementsByClassName('edit')[0].getElementsByTagName('textarea');
            for(var i = 0; i< list.length; i++){
                if(list[i].value != ""){
                    document.getElementsByTagName('textarea')[i].parentNode.parentNode.parentNode.style.display = "block";
                }
            }
            if( cont == 0){
                console.log('son iguales');
                document.getElementsByClassName('edit')[0].getElementsByTagName('textarea')[0].parentNode.parentNode.parentNode.style.display = "block"
            }
        }
    }
    my_func();

    // jQuery.each($('.scheduled_inspections.edit textarea'), function (i, val) {
    //     if($(val).text().length > 0){
    //         $(this).parent().parent().parent().css('display', 'block');
    //         cont += 1;
    //     }
    //     console.log(cont);
    // });
});