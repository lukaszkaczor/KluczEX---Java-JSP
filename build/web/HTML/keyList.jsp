<%@page import="java.sql.ResultSet"%>
<%@page import="kluczex.DBConnection"%>
<!DOCTYPE html>
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
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
        <link href="<%=request.getContextPath()%>/CSS/navbar.css" rel="stylesheet" type="text/css"/>
        <link href="<%=request.getContextPath()%>/CSS/style.css" rel="stylesheet" type="text/css"/>
        <link href="<%=request.getContextPath()%>/CSS/cart.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>

        <%
//            Cookie cookie = null;
//            Cookie[] cookies = null;
//            cookies = request.getCookies();
//            String user = null;
//            Boolean isLoggedIn = false;
//            if (cookies != null) {
//                for (int i = 0; i < cookies.length; i++) {
//                    if (cookies[i].getName().equals("username")) {
//                        isLoggedIn = true;
//                        user = cookies[i].getValue();
//                    }
//                }
//            }

        String user = null;
        Boolean isLoggedIn = false;
        user = (String)session.getAttribute("user");
        
        if(user!=null)
        {
            isLoggedIn = true;
        }
            DBConnection dbc = new DBConnection();
            ResultSet result = dbc.ExecuteQuery("select nazwa, zdjecia.okladka, data_zakupu, klucz_seryjny from produkty join zdjecia on zdjecia.id_produktu = produkty.id_produktu "
                    + "join klucze on produkty.id_produktu = klucze.id_produktu where login = '"+user+"' order by data_zakupu desc;");
            ResultSet ilosc = dbc.ExecuteQuery("select sum(ilosc) as suma from koszyk where login ='" + user + "'");
            ilosc.next();
            String suma = ilosc.getString("suma");
            if(suma==null) 
                suma = "0";
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
            if (!result.next()) {%>
        <h1 class="empty">Historia zakupów jest pusta</h1>
        <%
        } else {

            int iterator = 0;
        %> 

        <section class="content">
            <div class="ree">
                <h3 class="prName">Nazwa</h3>
                <!--<h3 class="prPrice">Cena</h3>-->
                <h3 class="prQuan">Numer seryjny</h3>
                <h3 class="prAmount">Data zakupu</h3>
                <!-- <h3 class="prDelete">Razem</h3> -->
            </div>
            <form class="list">
                <%
                    do {
                        float total = 0;
//                        int quantity = Integer.parseInt(result.getString("ilosc"));
//                        float price = Float.parseFloat(result.getString("cena_za_sztuke"));
//                        total = quantity * price;
                        if (iterator == 0) {
                %>
                <div class="product firstProduct">
                    <%
                    } else {
                    %>
                    <div class="product">
                        <%
                            }
                        %>


                        <div class="productName">
                            <img src="<%=result.getString("okladka")%>" alt="">
                            <a href=""><%=result.getString("nazwa")%></a>
               
                        </div>


                        <div class="ilosc">
                            <h3 class="key"><%=result.getString("klucz_seryjny")%></h3>

                        </div>

                        <h2 class="amountHld"> <span class="amount"><%=result.getString("data_zakupu")%></span></h2>
                    </div>
                    <%
                            iterator++;
                        } while (result.next());%>
                    </form>

                    </section>
                    <%}
                    %>

                    </body>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
                    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
                    </html>