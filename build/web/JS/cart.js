var minus = document.querySelectorAll(".minus");
var plus = document.querySelectorAll(".plus");
let input = document.querySelectorAll(".input");
var productPrice = document.querySelectorAll(".price")
var amount = document.querySelectorAll(".amount");
var total = document.querySelector(".total");
var prices = [];
var quantity = []; //parseInt(input.value);
var amounts = [];
var sum = 0;



var path= "";
var save = document.querySelector("#save");
var productID = document.querySelectorAll("#productID");
var string = "";



for (var i = 0; i < input.length; i++) {
    prices[i] = parseFloat(productPrice[i].textContent);
    quantity[i] = parseInt(input[i].value);
    amounts[i] = prices[i] * quantity[i];
    amount[i].textContent = amounts[i].toFixed(2);
    sum += amounts[i];
    total.textContent = sum.toFixed(2);

}
setHref();



function dodaj(i) {
    var ilosc = parseInt(input[i].value);
    ilosc += 1;
    input[i].value = ilosc;

    sum += parseFloat(productPrice[i].textContent);
    total.textContent = sum.toFixed(2);

   quantity[i] = parseInt(input[i].value);
   amount[i].textContent = (prices[i]*quantity[i]).toFixed(2);

    setHref();


}

function odejmij(i) {

    var ilosc = parseInt(input[i].value);
    ilosc -= 1;
    input[i].value = ilosc;

    if (!ilosc) {
        input[i].value = 1;
    } else {
        sum -= parseFloat(productPrice[i].textContent);
        total.textContent = sum.toFixed(2);
    }
       quantity[i] = parseInt(input[i].value);
   amount[i].textContent = (prices[i]*quantity[i]).toFixed(2);
    
    setHref();
}


function setHref(){
    string = "";
    for(var j =0; j<input.length;j++)
    {
        string+="productID="+productID[j].value+"&quantity="+input[j].value+"&";
    }
    
    path = string.slice(0, string.length-1);
    save.setAttribute("href", "/KluczEX/ReloadServlet?" + path);
}



 


























// for (var i = 0; i < input.length; i++) {

//     prices[i] = parseFloat(productPrice[i].textContent);
//     quantity[i] = parseFloat(input[i].value);
//     am[i] = prices[i] * quantity[i];
//     sum += prices[i] * quantity[i];
//     total.textContent = sum.toFixed(2);
//     amount[i].textContent = am[i].toFixed(2);
// }

// function dodaj(i) {
//     var ilosc = parseInt(input[i].value);
//     ilosc += 1;
//     input[i].value = ilosc;

//     prices[i] = parseFloat(productPrice[i].textContent);
//     quantity[i] = parseFloat(input[i].value);


//     am[i] = prices[i] * quantity[i];
//     sum += prices[i] * quantity[i];
//     total.textContent = sum.toFixed(2);
//     amount[i].textContent = am[i].toFixed(2);
// }

// function odejmij(i) {

//     var ilosc = parseInt(input[i].value);
//     ilosc -= 1;
//     input[i].value = ilosc;
//     if (!ilosc)
//         input[i].value = 1;

//     else {
//         sum=0;
//         prices[i] = parseFloat(productPrice[i].textContent);
//         quantity[i] = parseFloat(input[i].value);


//         am[i] = prices[i] * quantity[i];
//         sum += prices[i] * quantity[i];
//         total.textContent = sum.toFixed(2);
//         amount[i].textContent = am[i].toFixed(2);
//     }
// }
































// function tak(){
//     sum=0;
//     for(j=0;j<amount.length;j++)
//     {
//          prices[j] = parseFloat(productPrice[j].textContent);
//          quantity[j] = parseFloat(input[j].value);


//          am[j] = prices[j] * quantity[j];
//          sum += prices[j] * quantity[j];
//          total.textContent = sum.round(2);
//          amount[j].textContent= am[j].round(2);
//     }

// }

// setInterval(function(){
//     sum=0;
//     for(j=0;j<amount.length;j++)
//     {
//          prices[j] = parseInt(productPrice[j].textContent);
//          quantity[j] = parseInt(input[j].value);

//          sum += prices[j] * quantity[j];
//          total.textContent = sum;
//     }

// }, 1000);