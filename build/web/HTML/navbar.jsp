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
                    <!--<a href="<%=request.getContextPath()%>/HTML/login.jsp" class="link"><i class="fas fa-shopping-basket"></i>&nbsp 0</a>-->
                    <a href="<%=request.getContextPath()%>/HTML/login.jsp" class="link"><i class="fas fa-user-alt"></i>&nbsp Zaloguj</a>
                </div>
            </div>
        </div>