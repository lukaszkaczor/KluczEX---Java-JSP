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

        <form action="<%=request.getContextPath()%>/ConfirmEmailServlet" method="POST">
            <h1>Zmień adres email</h1>
            <h5 style="text-align: center">Na twój adres mailowy został wysłany klucz weryfikacyjny</h5>
            <div class="line">
                <label for="oldEmail"><i class="fas fa-at"></i></label>
                <input  name="oldEmail" type="text" placeholder="Email" required>
            </div>

            <div class="line">
                <label for="newEmail"><i class="fas fa-at"></i></label>
                <input  name="newEmail" type="text" placeholder="Potwierdź nowy email" required>
            </div>

            <div class="line">
                <label for="key"><i class="fas fa-lock"></i></label>
                <input name="key" type="text" placeholder="Klucz" required>
            </div>

            <%if (request.getAttribute("errorMessage") != null) {%>
            <h4 style="margin-top: 50px;" class="loginInfo"><%= request.getAttribute("errorMessage")%></h4>
            <%}%>
      
            <input class="btnLogin" type="submit" value="Zmień">
            
        </form>

    </body>



</html>