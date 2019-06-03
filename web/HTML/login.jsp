<%@page import="java.sql.ResultSet"%>
<%@page import="kluczex.DBConnection"%>
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

        <form action="<%=request.getContextPath()%>/LoginServlet" method="post">
            <h1>Zaloguj</h1>
            <div class="line">
                <label for="login"><i class="fas fa-user"></i></label>
                <input  name="username" type="text" placeholder="Login">
            </div>

            <div class="line">
                <label for="password"><i class="fas fa-lock"></i></label>
                <input name="password" type="password" placeholder="Hasło">
            </div>

            <a href="<%=request.getContextPath()%>/HTML/resetPassword.jsp">Zapomniałeś hasła?</a>
            <input class="btnLogin" type="submit" value="Zaloguj">
            <a href="registration.jsp">lub <span> UTWÓRZ NOWE KONTO</span></a>
        </form>


        <%if (request.getAttribute("errorMessage") != null) {%>
        <h2 class="loginInfo"><%= request.getAttribute("errorMessage")%></h2>
        <%}%>

    </body>



</html>