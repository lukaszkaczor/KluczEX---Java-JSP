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

            String user = null;
            Boolean isLoggedIn = false;
            user = (String) session.getAttribute("user");
            Boolean admin =  (Boolean)session.getAttribute("admin");
            
            if(admin == null || admin == false)
            {
              response.sendRedirect("../index.jsp");   
            }
            
            if (user != null) {
                isLoggedIn = true;
            }
            DBConnection dbc = new DBConnection();
            ResultSet result = dbc.ExecuteQuery("select produkty.id_produktu, produkty.nazwa,  okladka from polecane join produkty on produkty.id_produktu = polecane.id_produktu "
                    + "join zdjecia on zdjecia.id_produktu = polecane.id_produktu where polecane.id_produktu is not null;");
            ResultSet ilosc = dbc.ExecuteQuery("select sum(ilosc) as suma from koszyk where login ='" + user + "'");
            ilosc.next();
            String suma = ilosc.getString("suma");
            if (suma == null) {
                suma = "0";
            }
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
                            <%
                                if (admin) {
                            %>
                            <a class="dropdown-item bt" href="<%=request.getContextPath()%>/HTML/admin.jsp">Edytuj proponowane</a>
                            <%}
                            %>
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
        <h1 class="empty">Twój koszyk jest pusty</h1>
        <%
        } else {

            int iterator = 0;
        %> 

        <section class="content">
            <h1 class="adminText">Edytuj listę proponowane</h1>
            <form action="<%=request.getContextPath()%>/AddToPropList" method="POST" >
                <input class="adminInput" name="productID" type="text" placeholder="ID produktu">
                <input class="adminBtn" type="submit" value="Dodaj">
            </form>
            <%if (request.getAttribute("errorMessage") != null) {%>
            <h2 style="padding: 20px;" class="loginInfo"><%= request.getAttribute("errorMessage")%></h2>
            <%}%>


            <div class="ree">
                <h3 class="prName">Nazwa</h3>
                <h3 class="prQuan">ID</h3>
                <h3 class="prAmount">Usuń</h3>
            </div>
            <form action="<%=request.getContextPath()%>/CartServlet" class="list" method="POST">
                <%
                    do {
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
                            <a href="<%=request.getContextPath()%>/HTML/product.jsp?productID=<%=result.getString("id_produktu")%>"><%=result.getString("nazwa")%></a>
                            <input id="productID" type="text" name="productID" value="<%=result.getString("id_produktu")%>" style="display: none" readonly>
                        </div>
                        
                           <h3 class="adminID"><%=result.getString("id_produktu")%></h3>



                        <a class="delete2" href="<%=request.getContextPath()%>/DeleteFromPropList?productID=<%=result.getString("id_produktu")%>"><i class="fas fa-times"></i></a>
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
    <script src="<%=request.getContextPath()%>/JS/cart.js" type="text/javascript"></script>
</html>