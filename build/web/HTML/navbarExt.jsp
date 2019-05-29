<%@page import="java.sql.ResultSet"%>
<%@page import="kluczex.DBConnection"%>
<head>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link href="<%=request.getContextPath()%>/CSS/navbar.css" rel="stylesheet" >
    <link href="<%=request.getContextPath()%>/CSS/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat&amp;subset=latin-ext" rel="stylesheet">
</head> 



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
            <a href="<%=request.getContextPath()%>/HTML/cart.jsp" class="link"><i class="fas fa-shopping-basket"></i></i>&nbsp 0</a>

            <div class="btn-group">
                <a href="<%=request.getContextPath()%>/HTML/login.html" type="" class="btn  link">Profil</a>
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

