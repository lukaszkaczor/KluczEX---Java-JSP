$('.posts .holder').slice(0, 1).show();
var i =0;
var j =0;


$('#btnMore').on('click', function () {
    $('.posts .holder:hidden').slice(0, 1).slideDown();
    if ($('.posts .holder:hidden').length === 0) {
        // $('#btnMore').fadeOut();
        $('#btnMore').text("Pokaż wszystkie");
        // $('#btnRedirect').fadeIn();
    }
    i++;

    switch(i){
        case 1:
        $('#first').removeClass("displayNone");
        $('#first').addClass("holder");
        $("#first").css("display","flex");
        break;

        case 2:
        $('#second').removeClass("displayNone");
        $('#second').addClass("holder");
        $("#second").css("display","flex");
        break;

        case 3:
        $('#third').removeClass("displayNone");
        $('#third').addClass("holder");
        $("#third").css("display","flex");
        break;

    }

    if(i===4){
         $('#btnMore').attr('href', 'HTML/productList.jsp?polecane=50');
    }
});

$('#btnMore2').on('click', function () {
    $('.posts2 .holder:hidden').slice(0, 1).slideDown();
    if ($('.posts2 .holder:hidden').length === 0) {
        // $('#btnMore2').fadeOut();
        // $('#btnRedirect2').fadeIn();
        $('#btnMore2').text("Pokaż wszystkie");
    }
    j++;


    switch(j){
        case 1:
        $('#first2').removeClass("displayNone");
        $('#first2').addClass("holder");
        $("#first2").css("display","flex");
        break;

        case 2:
        $('#second2').removeClass("displayNone");
        $('#second2').addClass("holder");
        $("#second2").css("display","flex");
        break;

        case 3:
        $('#third2').removeClass("displayNone");
        $('#third2').addClass("holder");
        $("#third2").css("display","flex");
        break;
    }

    if(j===4){
        $('#btnMore2').attr('href', 'HTML/productList.jsp?cheaperThan=50');
   }
});



/*
$('#btnMore').on('click', function () {
    $('.posts .holder:hidden').slice(0, 1).slideDown();
    if ($('.posts .holder:hidden').length === 0) {
        // $('#btnMore').fadeOut();
        $('#btnMore').text("Pokaż wszystkie");
        // $('#btnRedirect').fadeIn();
    }
    i++;

    switch(i){
        case 1:
        $('#first').removeClass("displayNone");
        $('#first').addClass("holder");
        $("#first").css("display","flex");
        break;

        case 2:
        $('#second').removeClass("displayNone");
        $('#second').addClass("holder");
        $("#second").css("display","flex");
        break;

        case 3:
        $('#third').removeClass("displayNone");
        $('#third').addClass("holder");
        $("#third").css("display","flex");
        break;

    }

    if(i===4){
         $('#btnMore').attr('href', '');
    }
});




$('#btnMore2').on('click', function () {
    $('.posts2 .holder:hidden').slice(0, 1).slideDown();
    if ($('.posts2 .holder:hidden').length === 0) {
        $('#btnMore2').fadeOut();
        $('#btnRedirect2').fadeIn();
    }
    j++;
    console.log(j);

    switch(j){
        case 1:
        $('#first2').removeClass("displayNone");
        $('#first2').addClass("holder");
        $("#first2").css("display","flex");
        break;

        case 2:
        $('#second2').removeClass("displayNone");
        $('#second2').addClass("holder");
        $("#second2").css("display","flex");
        break;

        case 3:
        $('#third2').removeClass("displayNone");
        $('#third2').addClass("holder");
        $("#third2").css("display","flex");
        break;
    }
});*/