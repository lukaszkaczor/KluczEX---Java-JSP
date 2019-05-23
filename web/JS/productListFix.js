var count = $(".productList > .product").length;
if (count % 3 == 2) {
    $(".productList > .product").last().attr('id', 'drugi');

    $("#drugi").css("position", "absolute");
    $("#drugi").css("bottom", "0px");
    $("#drugi").css("left", "34.5%");
    $("#drugi").css("width", "31%");
}