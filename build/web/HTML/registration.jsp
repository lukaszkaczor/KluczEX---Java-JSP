<%@page import="kluczex.DBConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page errorPage="error.jsp" %>
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
                <link rel="shortcut icon" href="img/KluczEx.png" />
    <title>KluczEx</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/style.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/navbar.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/CSS/login.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
        <link href="https://fonts.googleapis.com/css?family=Roboto&amp;subset=latin-ext" rel="stylesheet">
        <link rel="shortcut icon" href="img/KluczEx.png" />
    </head>

    <body>
        <div class="logo">
            <a href="<%=request.getContextPath()%>/index.jsp" class="logoText">KluczEx</a>
        </div>

        <form action="<%=request.getContextPath()%>/RegistrationServlet" method="post">
            <h1>Utwórz konto</h1>
            <div class="line"</div>
            <label for="login"><i class="fas fa-user icon"></i></label>
            <input id="login" name="username" type="text" placeholder="Login" required>
            </div>

            <div class="line">
                <label for="email"><i class="fas fa-at icon"></i></label>
                <input id="email" name="email" type="text" placeholder="Email" required>
            </div>

            <div class="line">
                <label for="password"><i class="fas fa-lock icon"></i></label>
                <input id="password" name="password" type="password" placeholder="Hasło" required>
            </div>

            <div class="line">
                <label for="confirmPassword"><i class="fas fa-lock icon"></i></label>
                <input id="confirmPassword" name="confirmPassword" type="password" placeholder="Powtórz hasło" required>
            </div>

            <input class="btnLogin" type="submit" value="Zarejestruj">
        </form>

        <%if (request.getAttribute("errorMessage") != null) {%>
        <h2 class="loginInfo"><%= request.getAttribute("errorMessage")%></h2>
        <%}%>
    </body>
</html>