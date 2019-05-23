<%@page import="java.sql.ResultSet"%>
<%@page import="kluczex.DBConnection"%>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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
        <link rel="stylesheet" href="../CSS/style.css">
        <link rel="stylesheet" href="../CSS/navbar.css">
        <link rel="stylesheet" href="../CSS/productList.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
        <link href="https://fonts.googleapis.com/css?family=Roboto&amp;subset=latin-ext" rel="stylesheet">
        <link rel="shortcut icon" href="img/KluczEx.png" />
    </head>

    <body>
        <div class="navbar">
            <div class="nav">
                <div class="logo">
                    <a href="../index.jsp" class="logoText">KluczEx</a>
                </div>

                <form action="productList.jsp" class="search">
                    <input class="searchInput" type="text" name="textInput" placeholder="Szukaj...">
                    <button type="submit" class="searchButton"><i class="fas fa-search"></i></button>
                </form>

                <div class="navigation">
                    <a href="login.jsp" class="link"><i class="fas fa-user-alt"></i></i>&nbsp Zaloguj</a>
                    <a href="" class="link"><i class="fas fa-shopping-basket"></i></i>&nbsp 0</a>
                </div>
            </div>
        </div>

 
        
        
        <div class="productListCaptions">
            <h1>Wyniki wyszukiwania dla "<%=request.getParameter("textInput")%>"</h1>
        </div>
        <div class="productsListcontent">

            <!-- <div class="fixedFilters"> -->
            <div class="filters">
                <a href="" class="filter firstFilter">Gry</a>
                <a href="" class="filter">Programy uzytkowe</a>
                <a href="" class="filter">Systemy operacyjne</a>
                <a href="" class="filter">Gry</a>
                <a href="" class="filter">Programy uzytkowe</a>
                <a href="" class="filter">Systemy operacyjne</a>

            </div>
            <!-- </div> -->

            <%
                DBConnection dbc = new DBConnection();

                String textInput = request.getParameter("textInput");
                ResultSet result = dbc.ExecuteQuery("select * from produkty where lower(nazwa) like (lower('%" + textInput + "%'));");
            %>



            <div class="productList">
                <% while (result.next()) {
                %>
                <a href="" class="product">
                    <img class="productFgr"
                         src="https://images.g2a.com/newlayout/323x433/1x1x0/06114476276e/59108976ae653aa55c6ac1f2" alt="">
                    <img class="productBgr"
                         src="https://steamcdn-a.akamaihd.net/steam/apps/292030/ss_b74d60ee215337d765e4d20c8ca6710ae2362cc2.1920x1080.jpg?t=1550078557"
                         alt="">

                    <h1><%=result.getString(2)%></h1>
                    <h2>kurwa bezcenny</h2>
                </a>

                <%
                    }


                %>
                <!--                <a href="" class="product">
                                    <img class="productFgr"
                                         src="https://images.g2a.com/newlayout/323x433/1x1x0/06114476276e/59108976ae653aa55c6ac1f2" alt="">
                                    <img class="productBgr"
                                         src="https://steamcdn-a.akamaihd.net/steam/apps/292030/ss_b74d60ee215337d765e4d20c8ca6710ae2362cc2.1920x1080.jpg?t=1550078557"
                                         alt="">
                
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </a>
                                <div class="product">
                                    <img class="productFgr"
                                         src="https://images-eds-ssl.xboxlive.com/image?url=8Oaj9Ryq1G1_p3lLnXlsaZgGzAie6Mnu24_PawYuDYIoH77pJ.X5Z.MqQPibUVTcFkzcpqDpuJG5vRk3lXTx6tYMHkjStCsnVFqhvniX5wZizniMfw1izt4OoWeSUSleQIYGgBhTg9OhILmPIM.7EwDU6c9QzQIbexVx4J1ib6Qi0zQdLh3AZlRdPuayxqgVsR_mcsefLNWWrJo60t0Vt38UIPDoTEdBD6StwasBkFo-"
                                         alt="">
                                    <img class="productBgr" src="https://www.testergier.pl/wp-content/uploads/2017/11/ac-origins.jpg"
                                         alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr"
                                         src="../img/okladki/(podobno lepsze od wiedzmina czy) The Legend of Zelda Breath of the Wild/cover.jpg"
                                         alt="">
                                    <img class="productBgr"
                                         src="../img/okladki/(podobno lepsze od wiedzmina czy) The Legend of Zelda Breath of the Wild/scr.jpg"
                                         alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/3DMark/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/3DMark/scr.jpg" alt="">
                
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                
                                    <img class="productFgr" src="../img/cover.jpg" alt="">
                                    <img class="productBgr"
                                         src="https://ocdn.eu/pulscms-transforms/1/RP-k9kqTURBXy9hZDc0MTM1MWFmMWJlMGJiOTUwZDU2YjAxMzgxMGI4MC5qcGVnkpUDIADNA0TNAdaTBc0DFM0BvIGhMAE"
                                         alt="">
                
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Action!/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Action!/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Amazon/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Amazon/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/App Game Kit 2/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/App Game Kit 2/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Apple iTunes/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Apple iTunes/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Battlefield V/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Battlefield V/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Burnout Paradise/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Burnout Paradise/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Civilization V/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Civilization V/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Dead by Daylight/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Dead by Daylight/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Google Play/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Google Play/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Imperator Rome/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Imperator Rome/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
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
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Netflix/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Netflix/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/New Super Mario Bros/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/New Super Mario Bros/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Nintendo eShop/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Nintendo eShop/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Office 365/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Office 365/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Playstation Network/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Playstation Network/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Steam Wallet/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Steam Wallet/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/WOW prepaid/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/WOW prepaid/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>
                
                                <div class="product">
                                    <img class="productFgr" src="../img/okladki/Xbox Live/cover.jpg" alt="">
                                    <img class="productBgr" src="../img/okladki/Xbox Live/scr.jpg" alt="">
                                    <h1>wiedzmin 3 dziki gon to najlepsza gra na swiecie</h1>
                                    <h2>kurwa bezcenny</h2>
                                </div>-->

            </div>
        </div>

    </div>

    <button id="back-to-top-btn"><i class="fas fa-angle-double-up"></i></button>


    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="../JS/backToTopBtn.js"></script>
    <script src="../JS/productListFix.js"></script>
</body>

</html>