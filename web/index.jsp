<%@page import="java.util.ArrayList"%>
<%@page import="kluczex.IndexJSPproduct"%>
<%@page import="java.util.List"%>
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
        <link rel="stylesheet" href="CSS/style.css">
        <link rel="stylesheet" href="CSS/navbar.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
        <link href="https://fonts.googleapis.com/css?family=Roboto&amp;subset=latin-ext" rel="stylesheet">
        <link rel="shortcut icon" href="img/KluczEx.png" />

    </head>
    <%
        Cookie cookie = null;
        Cookie[] cookies = null;
        cookies = request.getCookies();
        String user = null;
        Boolean isLoggedIn = false;
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equals("username")) {
                    isLoggedIn = true;
                    user = cookies[i].getValue();
                }
            }
        } else {
            out.println("<h2>No cookies founds</h2>");
        }
    %>

    <body>
        <%
            if (isLoggedIn) {
        %>
        <link rel="stylesheet" href="CSS/style.css">
        <link rel="stylesheet" href="CSS/navbar.css">
        <div class="navbar">
            <div class="nav">
                <div class="logo">
                    <a href="../index.html" class="logoText">KluczEx</a>
                </div>

                <form action="HTML/productList.jsp" class="search">
                    <input class="searchInput" type="text" name="textInput" placeholder="Szukaj...">
                    <button type="submit" class="searchButton"><i class="fas fa-search"></i></button>
                </form>
                <div class="navigation">
                    <a href="" class="link"><i class="fas fa-shopping-basket"></i></i>&nbsp 0</a>

                    <div class="btn-group">
                        <a href="/HTML/login.html" type="" class="btn  link">Profil</a>
                        <button type="button" class="btn dropdown-toggle dropdown-toggle-split link" data-toggle="dropdown"
                                aria-haspopup="true" aria-expanded="false">
                            <span class="sr-only">Toggle Dropdown</span>
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item bt" href="#">Action</a>
                            <a class="dropdown-item bt" href="#">Another action</a>
                            <a class="dropdown-item bt" href="#">Something else here</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">
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
        <div class="navbar">
            <div class="nav">
                <div class="logo">
                    <a href="#" class="logoText">KluczEx</a>
                </div>

                <form action="HTML/productList.jsp" class="search">
                    <input class="searchInput" type="text" name="textInput" placeholder="Szukaj...">
                    <button type="submit" class="searchButton"><i class="fas fa-search"></i></button>
                </form>

                <div class="navigation">
                    <a href="" class="link"><i class="fas fa-shopping-basket"></i>&nbsp 0</a>
                    <a href="HTML/login.jsp" class="link"><i class="fas fa-user-alt"></i>&nbsp Zaloguj</a>
                </div>
            </div>
        </div>
        <%} %>
        <div class="captions">
            <h1 class="cpt1">Aktualności</h1>
            <h1 class="cpt2">Bestsellery</h1>
        </div>


        <section class="main">
            <div class="content">
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
                                    <img src="img/news.png" class="d-block w-100" alt="...">
                                    <div class="carousel-caption d-none d-md-block">
                                        <!-- <h5>First slide label</h5> -->
                                        <!-- <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p> -->
                                    </div>
                                </a>
                                <div class="carousel-item">
                                    <img src="img/summerSale.png" class="d-block w-100" alt="...">
                                    <div class="carousel-caption d-none d-md-block">
                                        <!-- <h5>Second slide label</h5> -->
                                        <!-- <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p> -->
                                    </div>
                                </div>
                                <div class="carousel-item">
                                    <img src="img/publishersWeek.png" class="d-block w-100" alt="...">
                                    <div class="carousel-caption d-none d-md-block">
                                        <!-- <h5>Third slide label</h5> -->
                                        <!-- <p>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</p> -->
                                    </div>
                                </div>
                            </div>
                            <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button"
                               data-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="sr-only">Previous</span>
                            </a>
                            <a class="carousel-control-next" href="#carouselExampleCaptions" role="button"
                               data-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="sr-only">Next</span>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="bestsellers">
                    <a href="" class="bestseller">
                        <div class="front">
                            <img src="http://www.mobygames.com/images/covers/l/83922-gothic-3-windows-front-cover.jpg"
                                 alt="">
                            <!-- <h1>front</h1> -->
                        </div>
                        <div class="back">
                            <h2>Lorem ipsum dolor sit amet consecteturnam tempora. Maxime nemo minus officii</h2>
                            <h3>36,50zł</h3>
                        </div>
                    </a>

                    <a href="" class="bestseller">
                        <div class="front">
                            <img src="https://cdns.kinguin.net/media/catalog/category/cache/1/hi_image/9df78eab33525d08d6e5fb8d27136e95/800x700_gta.png"
                                 alt="">
                            <!-- <h1>front</h1> -->
                        </div>
                        <div class="back">
                            <h2>Grand Theft Auto V</h2>
                            <h3>89zł</h3>
                        </div>
                    </a>

                    <a href="" class="bestseller">
                        <div class="front">
                            <img src="img/ee.png" alt="">
                            <!-- <h1>front</h1> -->
                        </div>
                        <div class="back">
                            <h2>Wiedźmin 3 Dziki Gon</h2>
                            <h3>250zł</h3>
                        </div>
                    </a>

                    <a href="" class="bestseller">
                        <div class="front">
                            <img src="https://images-eds-ssl.xboxlive.com/image?url=8Oaj9Ryq1G1_p3lLnXlsaZgGzAie6Mnu24_PawYuDYIoH77pJ.X5Z.MqQPibUVTcFkzcpqDpuJG5vRk3lXTx6tYMHkjStCsnVFqhvniX5wZizniMfw1izt4OoWeSUSleQIYGgBhTg9OhILmPIM.7EwDU6c9QzQIbexVx4J1ib6Qi0zQdLh3AZlRdPuayxqgVsR_mcsefLNWWrJo60t0Vt38UIPDoTEdBD6StwasBkFo-"
                                 alt="">
                            <!-- <h1>front</h1> -->
                        </div>
                        <div class="back">
                            <h2>Assassin's Creed Origins</h2>
                            <h3>189zł</h3>
                        </div>
                    </a>
                </div>
            </div>
        </section>

        <div class="captions">
            <h1 class="cpt3">Platformy</h1>
        </div>
        <section class="main platformSection">
            <div class="platforms">
                <a href="HTML/productList.jsp?platform=1" class="platform"> <img src="img/platforms/steam.png" alt="Steam">
                    <h1>Steam</h1>
                </a>

                <a href="HTML/productList.jsp?platform=3" class="platform"> <img src="img/platforms/ea-origin.png" alt="EA Origin">
                    <h1>Origin</h1>
                </a>

                <a href="HTML/productList.jsp?platform=2" class="platform"> <img src="img/platforms/uplay.png" alt="Uplay">
                    <h1>Uplay</h1>
                </a>

                <a href="HTML/productList.jsp?platform=4" class="platform"> <img src="img/platforms/battle-net.png" alt="Battle.net">
                    <h1>Battle.net</h1>
                </a>

                <a href="HTML/productList.jsp?platform=7" class="platform"> <img src="img/platforms/console.png" alt="Other">
                    <h1>Konsole</h1>
                </a>

                <a href="HTML/productList.jsp?platform=6" class="platform"> <img src="img/platforms/other.png" alt="GoG">
                    <h1>Inne</h1>
                </a>
            </div>
        </section>




        <%
            DBConnection dbc = new DBConnection();
            ResultSet result = dbc.ExecuteQuery("select distinct produkty.nazwa, produkty.id_produktu, klucze.cena, zdjecia.okladka from produkty join klucze on produkty.id_produktu = klucze.id_produktu join zdjecia on produkty.id_produktu = zdjecia.id_produktu where cena<50");
            List<IndexJSPproduct> cheaperThan50 = new ArrayList();
            int i = 0;

            while (result.next()) {
                cheaperThan50.add(new IndexJSPproduct(result.getString("id_produktu"), result.getString("nazwa"), result.getString("okladka"), result.getString("cena")));
            }
        %>


        <div class="whiteBg">
            <div class="captions">
                <h1 class="cpt4">Polecane</h1>
            </div>
        </div>
        <div class="whiteBg">
            <section class="main">
                <div class="posts">
                    <!-- holder -->
                    <div class="holder">
                        <div class="box">
                            <div class="front">
                                <img src="https://images-eds-ssl.xboxlive.com/image?url=8Oaj9Ryq1G1_p3lLnXlsaZgGzAie6Mnu24_PawYuDYIoH77pJ.X5Z.MqQPibUVTcFkzcpqDpuJG5vRk3lXTx6tYMHkjStCsnVFqhvniX5wZizniMfw1izt4OoWeSUSleQIYGgBhTg9OhILmPIM.7EwDU6c9QzQIbexVx4J1ib6Qi0zQdLh3AZlRdPuayxqgVsR_mcsefLNWWrJo60t0Vt38UIPDoTEdBD6StwasBkFo-"
                                     alt="">
                            </div>

                            <div class="back">
                                <h2>hreee</h2>
                                <h3>reee</h3>
                            </div>
                        </div>
                        <div class="box">
                            <div class="front">
                                <img src="img/ee.png" alt="">
                            </div>
                            <div class="back">
                                <h2>Wiedźmin 3 Dziki Gon</h2>
                                <h3>250zł</h3>
                            </div>

                        </div>
                        <div class="box">
                            <div class="front">
                                <img src="https://www.mobygames.com/images/covers/l/480193-far-cry-5-playstation-4-manual.jpg"
                                     alt="">
                            </div>
                            <div class="back">
                                <h2>Wiedźmin 3 Dziki Gon</h2>
                                <h3>250zł</h3>
                            </div>
                        </div>
                        <div class="box">
                            <div class="front">
                                <img src="https://img.sferis.pl/WAHPgRV/_/100/0/q8y6e4k5K0J0K1D5b4p4X1y8e1G6q630/gra-wersja-box-dying-light-xmas-edition.jpg"
                                     alt="">
                            </div>
                            <div class="back">
                                <h2>Wiedźmin 3 Dziki Gon</h2>
                                <h3>250zł</h3>
                            </div>
                        </div>
                        <div class="box">
                            <div class="front">
                                <img src="https://www.mobygames.com/images/covers/l/457219-kingdom-come-deliverance-playstation-4-front-cover.png"
                                     alt="">
                            </div>
                            <div class="back">
                                <h2>Wiedźmin 3 Dziki Gon</h2>
                                <h3>250zł</h3>
                            </div>
                        </div>
                        <div class="box">
                            <div class="front">
                                <img src="https://giveaway.download.hr/pictures/giveaway_box/grid-autosport-box.jpg" alt="">
                            </div>
                            <div class="back">
                                <h2>Wiedźmin 3 Dziki Gon</h2>
                                <h3>250zł</h3>
                            </div>
                        </div>
                    </div>


                    <div id="first" class="holder displayNone">
                        <!-- title -->
                        <div class="box"></div>
                        <div class="box"></div>
                        <div class="box"></div>
                        <div class="box"></div>
                        <div class="box"></div>
                        <div class="box"></div>
                    </div>

                    <div id="second" class="holder displayNone">
                        <!-- title -->
                        <div class="box"></div>
                        <div class="box"></div>
                        <div class="box"></div>
                        <div class="box"></div>
                        <div class="box"></div>
                        <div class="box"></div>
                    </div>

                    <div id="third" class="holder displayNone">
                        <!-- title -->
                        <div class="box"></div>
                        <div class="box"></div>
                        <div class="box"></div>
                        <div class="box"></div>
                        <div class="box"></div>
                        <div class="box"></div>
                    </div>

                    <!-- btn holder -->
                    <div class="btnHolder">
                        <a id="btnMore">Pokaż więcej</a>
                        <!-- <a href="" id="btnRedirect">Pokaż wszystkie</a> -->
                    </div>

                </div>
            </section>
        </div>






        <div class="captions">
            <h1 class="cpt4">Klucze za mniej niż 50zł</h1>
        </div>
        <section class="main">
            <div class="posts2">
                <!-- holder -->
                <%for (int j = 0; j < 24; j++) {
                        if (j == 0) {
                %>
                <div class="holder">
                    <%
                        }
                        if (j == 6) {
                    %>
                </div> 
                <div id="first2" class="holder displayNone">
                    <%}
                        if (j == 12) {
                    %>
                </div> 
                <div id="second2" class="holder displayNone">
                    <%}
                        if (j == 18) {
                    %>
                </div> 
                <div id="third2" class="holder displayNone">
                    <%}%>

                    <a href="<%=request.getContextPath()%>/HTML/product.jsp?productID=<%=cheaperThan50.get(j).getIdProduktu()%>" class="box">
                        <div class="front">
                            <img src="<%=cheaperThan50.get(j).getOkladka()%>" alt="">
                        </div>
                        <div class="back">
                            <h2><%=cheaperThan50.get(j).getNazwa()%></h2>
                            <h3><%=cheaperThan50.get(j).getCena()%> zł</h3>
                        </div>

                    </a>
                    <%}%>
                </div> 
                <div class="btnHolder">
                    <a id="btnMore2">Pokaż więcej</a>
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
                        <a href=""><i class="fab fa-apple-pay"></i></a>
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
        <button id="back-to-top-btn"><i class="fas fa-angle-double-up"></i></button>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script src="JS/loadMore.js"></script>
        <script src="JS/backToTopBtn.js"></script>
    </body>
</html>