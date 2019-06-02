<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="kluczex.DBConnection"%>
<!DOCTYPE html>
<%--<%@ page errorPage="error.jsp" %>--%>  
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
        <link rel="shortcut icon" href="img/KluczEx.png" />
        <title>KluczEx</title>
        <link href="https://fonts.googleapis.com/css?family=Roboto&amp;subset=latin-ext" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/navbar.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/style.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/productList.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/product.css">

    </head>
    <%
//        Cookie cookie = null;
//        Cookie[] cookies = null;
//        cookies = request.getCookies();
//        String user = null;
//        Boolean isLoggedIn = false;
//        if (cookies != null) {
//            for (int i = 0; i < cookies.length; i++) {
//                if (cookies[i].getName().equals("username")) {
//                    isLoggedIn = true;
//                    user = cookies[i].getValue();
//                }
//            }
//        }

        String user = null;
        Boolean isLoggedIn = false;
        user = (String) session.getAttribute("user");

        Boolean admin = (Boolean) session.getAttribute("admin");
        if (admin == null) {
            admin = false;
        }

        if (user != null) {
            isLoggedIn = true;
        }
        DBConnection dbc = new DBConnection();
        ResultSet ilosc2 = dbc.ExecuteQuery("select sum(ilosc) as suma from koszyk where login ='" + user + "'");
        ilosc2.next();
        String suma2 = ilosc2.getString("suma");
        if (suma2 == null) {
            suma2 = "0";
        }
    %>

    <body>
        <%
            if (isLoggedIn) {
        %>
        <div class="navbar">
            <div class="nav">
                <div class="logo">
                    <a href="<%=request.getContextPath()%>/index.jsp" class="logoText">KluczEx</a>
                </div>

                <form action="<%=request.getContextPath()%>/HTML/productList.jsp" class="search">
                    <input class="searchInput" type="text" name="textInput" placeholder="Szukaj...">
                    <button type="submit" class="searchButton"><i class="fas fa-search"></i></button>
                </form>



                <div class="navigation">
                    <a href="<%=request.getContextPath()%>/HTML/cart.jsp" class="link"><i class="fas fa-shopping-basket"></i></i>&nbsp <%=suma2%></a>

                    <div class="btn-group">
                        <a href="<%=request.getContextPath()%>/HTML/profile.jsp" type="" class="btn  link">Profil</a>
                        <button type="button" class="btn dropdown-toggle dropdown-toggle-split link" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">
                            <span class="sr-only">Toggle Dropdown</span>
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item bt" href="<%=request.getContextPath()%>/HTML/keyList.jsp">Historia zakupów</a>
                                                        <%
                                if (admin) {
                            %>
                            <a class="dropdown-item bt" href="<%=request.getContextPath()%>/HTML/admin.jsp">Edytuj proponowane</a>
                            <%}
                            %>
                            <!--<a class="dropdown-item bt" href="#">Action</a>-->
                            <!--                            <a class="dropdown-item bt" href="#">Another action</a>
                                                        <a class="dropdown-item bt" href="#">Something else here</a>-->
                            <div class="dropdown-divider"></div>
                            <!--<a class="dropdown-item" href="#">-->
                            <form action="<%=request.getContextPath()%>/LogoutServlet" method="post">
                                <input class="dropdown-item bt"  type="submit" value="Wyloguj">
                            </form>

                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%
        } else {
        %>
        <%@include file="navbar.jsp" %>
        <%} %>

        <%
            String product = request.getParameter("productID");

            ResultSet result = dbc.ExecuteQuery("select distinct produkty.nazwa, count(produkty.nazwa) as ilosc, produkty.opis, klucze.cena, zdjecia.okladka, zdjecia.zdjecie1, zdjecia.zdjecie2, zdjecia.zdjecie3, "
                    + "producenci.nazwa as producenci_nazwa, platformy.nazwa as platformy_nazwa, wymagania_systemowe.procesor, wymagania_systemowe.karta_graficzna, wymagania_systemowe.pamiec_ram, wymagania_systemowe.dysk, "
                    + "wymagania_systemowe.system_operacyjny from produkty join zdjecia on produkty.id_produktu = zdjecia.id_produktu join producenci on "
                    + "produkty.id_producenta = producenci.id_producenta join platformy on produkty.id_platformy = platformy.id_platformy join wymagania_systemowe on produkty.id_wymagan = "
                    + "wymagania_systemowe.id_wymagan join klucze on produkty.id_produktu = klucze.id_produktu where produkty.id_produktu = " + product + "and login is NULL group by produkty.nazwa, produkty.opis, klucze.cena,"
                    + "zdjecia.okladka, zdjecia.zdjecie1, zdjecia.zdjecie2, zdjecia.zdjecie3, producenci.nazwa, platformy.nazwa, wymagania_systemowe.procesor, wymagania_systemowe.karta_graficzna,"
                    + " wymagania_systemowe.pamiec_ram, wymagania_systemowe.dysk, wymagania_systemowe.system_operacyjny;");

            ResultSet resultIlosc = dbc.ExecuteQuery("select count(*) as ilosc from produkty");
            resultIlosc.next();
            int ilosc = resultIlosc.getInt("ilosc");
            int randomNumber;

            List<Integer> random = new ArrayList<Integer>();
            while (true) {
                randomNumber = (int) (Math.random() * ilosc + 1);
                if (!random.contains(randomNumber)) {
                    random.add(randomNumber);
                }

                if (random.size() == 3) {
                    break;
                }
            }

            ResultSet offer = dbc.ExecuteQuery("select distinct produkty.nazwa, produkty.id_produktu, klucze.cena, zdjecia.okladka, zdjecia.tlo from produkty join klucze on produkty.id_produktu"
                    + " = klucze.id_produktu join zdjecia on zdjecia.id_produktu = produkty.id_produktu where produkty.id_produktu in (" + random.get(0) + "," + random.get(1) + "," + random.get(2) + ")");

            if (!result.next()) {
        %>
        <h1>Produkt obecnie jest niedostępny</h1>
        <a href="">Poszukaj innych</a>
        <%} else {
        %>

        <% do {%>
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

                    <form action="<%=request.getContextPath()%>/AddToCartServlet?productID=<%=product%>&isLoggedIn=<%=isLoggedIn%>" method="POST">
                        <input class="addToCartNumber" type="number" value="1" name="quantity" min="1">
                        <input class="addToCartBtn" type="submit" value="Dodaj do koszyka">
                    </form>


                    <div class="addInfo">
                        <%if (request.getAttribute("errorMessage") != null) {%>
                        <div style="color:red" class="loginInfo"><i class="fas fa-times"></i>&nbsp;   <%= request.getAttribute("errorMessage")%></div>
                        <%}%>
                        <div><i class="fas fa-check-circle"></i><strong>&nbsp; Dostępnych <%=result.getString("ilosc")%> sztuk </strong></div>
                        <div><i class="fas fa-envelope"></i>&nbsp; Natychmiastowa wysyłka</div>
                        <div><i class="fas fa-key"></i>&nbsp;  Klucz cyfrowy</div>
                        <a href="https://wyrm.pl/jak-aktywowac-klucz-cyfrowy/"><i class="fas fa-question"></i>&nbsp; Jak aktywować klucz</a>
                    </div>
                </div>
            </div>
        </section>


        <section class="offer">
            <h1 class="napis">Może Ci się również spodobać</h1>

            <%
                while (offer.next()) {
            %>

            <a href="product.jsp?productID=<%=offer.getString("id_produktu")%>" class="product">
                <img class="productFgr" src="<%=offer.getString("okladka")%>" alt="">
                <img class="productBgr" src="<%=offer.getString("tlo")%>" alt="">
                <h1><%=offer.getString("nazwa")%></h1>
                <h2><%=offer.getString("cena")%> zł</h2>
            </a>
            <%
                }
            %>
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

        <% } while (result.next());
            }%>
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