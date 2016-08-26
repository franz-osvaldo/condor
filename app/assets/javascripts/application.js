// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap-select
//= require turbolinks
//= require twitter/typeahead
//= require bootstrap-datepicker
//= require highcharts
//= require chartkick
//= require_tree .




$(document).on('turbolinks:load', function() {
    $(".nano").nanoScroller({ scroll: 'bottom' });

    function setCookie(c_name, value){
        document.cookie  =  c_name + " = " + value + "; path=/";
    }
    function deleteCookie(c_name) {
        document.cookie = c_name + '=; path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
    }
    function wasCookieSet(cookie_name) {
        var array_of_cookies = document.cookie.split(';');
        for (var i = 0; i < array_of_cookies.length; i++){
            if (array_of_cookies[i].indexOf(cookie_name) > -1) {
                return true
            }
        }
        return false
    }
    function setInitialState() {
        if (wasCookieSet('sidebar_state')){
            $('.side_navbar').css('marginLeft', '-250px');
            $('.main_container').css('marginLeft', '0');
        }
    }
    setInitialState();

    $('.sidebar_button').click(function (event) {
        event.preventDefault();
        if (wasCookieSet('sidebar_state')){
            deleteCookie('sidebar_state');
            $('.side_navbar').animate({marginLeft: "0"},500);
            $('.main_container').animate({marginLeft: "250px"},500);
        }
        else{
            setCookie('sidebar_state', 'toggled');
            $('.side_navbar').animate({marginLeft: "-250px"},500);
            $('.main_container').animate({marginLeft: "0"},500);
        }
    });
});