<%@page import="java.sql.ResultSet"%>
<%@page import="kluczex.DBConnection"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page errorPage="error.jsp" %>  
<%
    response.setCharacterEncoding("UTF-8");
    request.setCharacterEncoding("UTF-8");
%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>KluczEx</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/style.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/navbar.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/productList.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
        <link href="https://fonts.googleapis.com/css?family=Roboto&amp;subset=latin-ext" rel="stylesheet">
        <link rel="shortcut icon" href="img/KluczEx.png" />
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
        user = (String)session.getAttribute("user");
        
        if(user!=null)
        {
            isLoggedIn = true;
        }
        
        DBConnection dbc = new DBConnection();
        ResultSet ilosc = dbc.ExecuteQuery("select sum(ilosc) as suma from koszyk where login ='" + user + "'");
        ilosc.next();
        String suma = ilosc.getString("suma");
        if (suma == null) {
            suma = "0";
        }
    %>
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
                    <a href="<%=request.getContextPath()%>/HTML/cart.jsp" class="link"><i class="fas fa-shopping-basket"></i></i>&nbsp <%=suma%></a>

                    <div class="btn-group">
                        <a href="<%=request.getContextPath()%>/HTML/profile.jsp" type="" class="btn  link">Profil</a>
                        <button type="button" class="btn dropdown-toggle dropdown-toggle-split link" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">
                            <span class="sr-only">Toggle Dropdown</span>
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item bt" href="<%=request.getContextPath()%>/HTML/keyList.jsp">Historia zakupów</a>
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

        String textInput = request.getParameter("textInput");
        String cheaperThan50 = request.getParameter("cheaperThan");
        String category = request.getParameter("category");
        String platform = request.getParameter("platform");
        ResultSet result;
        if (textInput == null && cheaperThan50 != null) {
            result = dbc.ExecuteQuery("select distinct produkty.nazwa, produkty.id_produktu, klucze.cena, zdjecia.okladka , zdjecia.tlo from zdjecia join produkty on produkty.id_produktu = "
                    + "zdjecia.id_produktu join klucze on klucze.id_produktu = produkty.id_produktu where klucze.cena<50;");
            textInput = "<50zł";
        } else if (textInput == null && cheaperThan50 == null && category != null) {
            result = dbc.ExecuteQuery("select distinct produkty.nazwa, produkty.id_produktu, klucze.cena, zdjecia.okladka , kategorie.nazwa as kn, zdjecia.tlo from zdjecia join produkty on produkty.id_produktu = "
                    + "zdjecia.id_produktu join klucze on klucze.id_produktu = produkty.id_produktu join kategorie on kategorie.id_kategorii = produkty.id_kategorii where produkty.id_kategorii = " + category + ";");
            //  result.next();
            //  textInput =result.getString("kn");
            if (category.contains("1")) {
                textInput = "Gry";
            }

            if (category.contains("2")) {
                textInput = "Programy antywirusowe";
            }

            if (category.contains("3")) {
                textInput = "Systemy operacyjne";
            }

            if (category.contains("4")) {
                textInput = "Programy biurowe";
            }

            if (category.contains("5")) {
                textInput = "Programy użytkowe";
            }

            if (category.contains("6")) {
                textInput = "Karty prepaid";
            }

        } else if (textInput == null && cheaperThan50 == null && category == null && platform != null) {
            result = dbc.ExecuteQuery("select distinct produkty.nazwa, produkty.id_produktu, klucze.cena, zdjecia.okladka , platformy.nazwa as pn, zdjecia.tlo from zdjecia join produkty on produkty.id_produktu = "
                    + "zdjecia.id_produktu join klucze on klucze.id_produktu = produkty.id_produktu join platformy on platformy.id_platformy = produkty.id_platformy where produkty.id_platformy = " + platform + ";");
            result.next();
            textInput = result.getString("pn");

        } else {

            result = dbc.ExecuteQuery("select distinct produkty.nazwa, produkty.id_produktu, klucze.cena, zdjecia.okladka , zdjecia.tlo from zdjecia join produkty on produkty.id_produktu = "
                    + "zdjecia.id_produktu join klucze on klucze.id_produktu = produkty.id_produktu where lower(nazwa) like (lower('%" + textInput + "%'));");

        }
    %>



    <div class="productListCaptions">
        <h1>Wyniki wyszukiwania dla "<%=textInput%>"</h1>
    </div>
    <div class="productsListcontent">

        <!-- <div class="fixedFilters"> -->
        <div class="filters">
            <a href="productList.jsp?category=1" class="filter firstFilter">Gry</a>
            <a href="productList.jsp?category=2" class="filter">Programy antywirusowe</a>
            <a href="productList.jsp?category=3" class="filter">Systemy operacyjne</a>
            <a href="productList.jsp?category=4" class="filter">Programy biurowe</a>
            <a href="productList.jsp?category=5" class="filter">Programy użytkowe</a>
            <a href="productList.jsp?category=6" class="filter">Karty prepaid</a>

        </div>
        <!-- </div> -->




        <div class="productList">
            <% while (result.next()) {
            %>
            <a href="<%=request.getContextPath()%>/HTML/product.jsp?productID=<%=result.getString("id_produktu")%>" class="product">
                <img class="productFgr"
                     src="<%=result.getString("okladka")%>" alt="">
                <img class="productBgr"
                     src="<%=result.getString("tlo")%>"
                     alt="">

                <h1><%=result.getString("nazwa")%></h1>
                <h2><%=result.getString("cena")%> zł</h2>
            </a>

            <%
                }


            %>

        </div>
    </div>

</div>

<button id="back-to-top-btn"><i class="fas fa-angle-double-up"></i></button>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="../JS/backToTopBtn.js"></script>
<script src="../JS/productListFix.js"></script>
</body>

</html>