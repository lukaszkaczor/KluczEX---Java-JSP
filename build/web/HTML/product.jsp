<%@page import="java.sql.ResultSet"%>
<%@page import="kluczex.DBConnection"%>
<!DOCTYPE html>
<%@ page errorPage="error.jsp" %>  
<html lang="en">
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    response.setCharacterEncoding("UTF-8");
    request.setCharacterEncoding("UTF-8");
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link href="https://fonts.googleapis.com/css?family=Roboto&amp;subset=latin-ext" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="../CSS/navbar.css">
    <link rel="stylesheet" href="../CSS/style.css">
    <link rel="stylesheet" href="../CSS/productList.css">
    <link rel="stylesheet" href="../CSS/product.css">

</head>

<body>
    <div class="navbar">
        <div class="nav">
            <div class="logo">
                <a href="html/productList.html" class="logoText">KluczEx</a>
            </div>

            <form action="<%=request.getContextPath()%>/HTML/productList.jsp" class="search">
                <input class="searchInput" type="text" name="textInput" placeholder="Szukaj...">
                <button type="submit" class="searchButton"><i class="fas fa-search"></i></button>
            </form>

            <div class="navigation">
                <a href="HTML/login.html" class="link"><i class="fas fa-user-alt"></i></i>&nbsp Zaloguj</a>
                <a href="" class="link"><i class="fas fa-shopping-basket"></i></i>&nbsp 0</a>
            </div>
        </div>
    </div>
    
    <%
    String product = request.getParameter("productID");
    
    DBConnection dbc = new DBConnection();   
    ResultSet result = dbc.ExecuteQuery("select distinct produkty.nazwa, count(produkty.nazwa) as ilosc, produkty.opis, klucze.cena, zdjecia.okladka, zdjecia.zdjecie1, zdjecia.zdjecie2, zdjecia.zdjecie3, "
            + "producenci.nazwa as producenci_nazwa, platformy.nazwa as platformy_nazwa, wymagania_systemowe.procesor, wymagania_systemowe.karta_graficzna, wymagania_systemowe.pamiec_ram, wymagania_systemowe.dysk, "
            + "wymagania_systemowe.system_operacyjny from produkty join zdjecia on produkty.id_produktu = zdjecia.id_produktu join producenci on "
            + "produkty.id_producenta = producenci.id_producenta join platformy on produkty.id_platformy = platformy.id_platformy join wymagania_systemowe on produkty.id_wymagan = "
            + "wymagania_systemowe.id_wymagan join klucze on produkty.id_produktu = klucze.id_produktu where produkty.id_produktu = "+product+" group by produkty.nazwa, produkty.opis, klucze.cena,"
            + "zdjecia.okladka, zdjecia.zdjecie1, zdjecia.zdjecie2, zdjecia.zdjecie3, producenci.nazwa, platformy.nazwa, wymagania_systemowe.procesor, wymagania_systemowe.karta_graficzna,"
            + " wymagania_systemowe.pamiec_ram, wymagania_systemowe.dysk, wymagania_systemowe.system_operacyjny;");
            result.next();
    %>

    <section class="productView">
        <div class="imgField">
            <img src="<%=result.getString("okladka")%>" alt="">
        </div>

        <div class="infoField">
            <h1 class="productName"><%=result.getString("nazwa")%></h1>
            <div class="descField">
                <h4> <strong>Informacje</strong> </h4>
                <h4>Platforma: <%=result.getString("platformy_nazwa")%></h4>
                <h4>Wydawca: <%=result.getString("producenci_nazwa")%></h4>
                <h4>Może być aktywowany w Polsce</h4>
                <h4 class="sysReq">Wymagania sprzętowe</h4>
                <h4>Procesor: <%=result.getString("procesor")%></h4>
                <h4>Karta graficzna: <%=result.getString("karta_graficzna")%></h4>
                <h4>Pamięć RAM: <%=result.getString("pamiec_ram")%></h4>
                <h4>Przestrzeń dyskowa: <%=result.getString("dysk")%></h4>
                <h4>System operacyjny: <%=result.getString("system_operacyjny")%></h4>
            </div>



            <div class="addToCartField">

                <h1 class="price"><%=result.getString("cena")%> zł</h1>
                <form action="">
                    <input class="addToCartNumber" type="number" value="1" name="quantity" min="1">
                    <input class="addToCartBtn" type="submit" value="Dodaj do koszyka">
                </form>


                <div class="addInfo">
                    <div><i class="fas fa-check-circle"></i><strong>&nbsp; Dostępnych <%=result.getString("ilosc")%> sztuk </strong></div>
                    <div><i class="fas fa-envelope"></i>&nbsp; Natychmiastowa wysyłka</div>
                    <div><i class="fas fa-key"></i>&nbsp;  Klucz cyfrowy</div>
                    <a href=""><i class="fas fa-question"></i>&nbsp; Jak aktywować klucz</a>

                </div>
            </div>
        </div>
    </section>

    <section class="offer">
        <h1 class="napis">Może Ci się również spodobać</h1>

        <div class="product">
            <img class="productFgr" src="../img/okladki/Malwarebytes/cover.jpg" alt="">
            <img class="productBgr" src="../img/okladki/Malwarebytes/scr.jpg" alt="">
            <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
            <h2>kurwa bezcenny</h2>
        </div>

        <div class="product">
            <img class="productFgr" src="../img/okladki/Minecraft/cover.jpg" alt="">
            <img class="productBgr" src="../img/okladki/Minecraft/scr.jpg" alt="">
            <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
            <h2>kurwa bezcenny</h2>
        </div>

        <div class="product">
            <img class="productFgr" src="../img/okladki/Motorsport Manager/cover.jpg" alt="">
            <img class="productBgr" src="../img/okladki/Motorsport Manager/scr.jpg" alt="">
            <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
            <h2>kurwa bezcenny</h2>
        </div>
    </section>

    <section class="description">
        <h3><%=result.getString("nazwa")%></h3>
         <%=result.getString("opis")%>
    </section>
    <section class="gallery">
        <div class="carousel">
            <div class="bd-example">
                <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
                        <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
                        <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                        <a href="" class="carousel-item active">
                            <img src="<%=result.getString("zdjecie1")%>" class="d-block w-100" alt="...">
                            <div class="carousel-caption d-none d-md-block">
                            </div>
                        </a>
                        <div class="carousel-item">
                            <img src="<%=result.getString("zdjecie2")%>" class="d-block w-100" alt="...">
                            <div class="carousel-caption d-none d-md-block">
                            </div>
                        </div>
                        <div class="carousel-item">
                            <img src="<%=result.getString("zdjecie3")%>"
                                class="d-block w-100" alt="...">
                            <div class="carousel-caption d-none d-md-block">
                            </div>
                        </div>
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>
        </div>
    </section>


    <footer>
        <div class="footerContent">
            <div class="firstHalf">
                <div class="footerKluczex">
                    <h1>KluczEX.com</h1>
                    <a href="">Privacy Policy</a>
                    <a href="">Terms & Conditions</a>
                </div>

                <div class="footerAccount">
                    <h1>My Account</h1>
                    <a href="">My Account</a>
                    <a href="">My Orders</a>
                </div>

                <div class="footerCustomerService">
                    <h1>Customer Service</h1>
                    <a href="">Submit a support request</a>
                    <a href="">FAQ</a>
                </div>

                <div class="footerGetToKnowUs">
                    <h1>Get to know Us</h1>
                    <a href="">About Us</a>
                    <a href="">Customer Service</a>
                </div>

                <div class="footerContact">
                    <h1>Contact Us</h1>
                    <a href="">support@kluczex.com</a>
                    <a href="">www.kluczex.com</a>
                </div>
            </div>

            <div class="secondHalf">
                <div class="footerPaymentMethods">
                    <h1>Payment Methods</h1>
                    <a href=""><i class="fab fa-paypal"></i></a>
                    <a href=""><i class="fab fa-apple-pay"></i></i></a>
                    <a href=""><i class="fab fa-cc-visa"></i></a>
                    <a href=""><i class="fab fa-cc-mastercard"></i></a>
                    <a href=""><i class="fas fa-credit-card"></i></a>
                    <a href=""><i class="fab fa-bitcoin"></i></a>
                </div>

                <div class="footerFollowUs">
                    <h1>Follow Us</h1>
                    <a href=""><i class="fab fa-facebook-f"></i></a>
                    <a href=""><i class="fab fa-twitter"></i></a>
                    <a href=""><i class="fab fa-instagram"></i></a>
                    <a href=""><i class="fab fa-youtube"></i></a>
                    <a href=""><i class="fab fa-twitch"></i></a>
                </div>
            </div>
        </div>
    </footer>
</body>

<script>

</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="../JS/maxInputNumberLength.js"></script>

</html>