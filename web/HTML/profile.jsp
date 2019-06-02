<%@page import="java.sql.ResultSet"%>
<%@page import="kluczex.DBConnection"%>
<!DOCTYPE html>
<html lang="en">
    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8"%>
    <%@ page errorPage="error.jsp" %>  
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
        <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/navbar.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/profile.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    </head>

    <body>
        <%
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

        <section class="profile">
            <form action="<%=request.getContextPath()%>/PasswordChangeServlet" method="POST">
                <h2>Zmiana hasła</h2>
                <input class="changeInput" type="password" name="oldPassword" placeholder="Obecne hasło" required>
                <input class="changeInput" type="password" name="newPassword" placeholder="Nowe hasło" required>
                <input class="changeInput" type="password" name="confirmPassword" placeholder="Powtórz hasło" required>
                <input class="changeBtn" type="submit" value="Zmień hasło">
                <%if (request.getAttribute("errorMessage") != null) {%>
                <h4 style="margin-top: 50px;" class="loginInfo"><%= request.getAttribute("errorMessage")%></h4>
                <%}%>
            </form>


            <form action="<%=request.getContextPath()%>/EmailChangeServlet" method="POST">
                <h2>Zmiana adresu email</h2>
                <input class="changeInput" type="email" name="oldEmail" placeholder="Obecny email">
                <input class="changeInput" type="email" name="newEmail" placeholder="Nowy email">

                <input class="changeBtn" type="submit" value="Zmień email">
                <%if (request.getAttribute("emailMessage") != null) {%>
                <h4 style="margin-top: 50px;" class="loginInfo"><%= request.getAttribute("emailMessage")%></h4>
                <%}%>
            </form>

            <form action="<%=request.getContextPath()%>/RODOServlet" method="POST">
                <h3>Pokaż informacje</h3>
                <h6>Wyślij na email wszystkie informacje powiązane z tym kontem</h6>
                <input type="submit" class="changeBtn">
                <%if (request.getAttribute("RODOMessage") != null) {%>
                <h4 style="margin-top: 50px; text-align: center; " class="loginInfo"><%= request.getAttribute("RODOMessage")%></h4>
                <%}%>
            </form>

        </section>

    </body>
</html>