package kluczex;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet LoginServlet</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
////        processRequest(request, response);
//    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            DBConnection dbc = new DBConnection();
            ResultSet result = dbc.ExecuteQuery("select * from uzytkownicy where login = '" + username + "'");

            if (result.next()) {
                if (password.equals(result.getString("haslo"))) {
                    Cookie cookie = new Cookie("username", username);
                    response.addCookie(cookie);

                    if (result.getBoolean("administrator")) {
                        response.sendRedirect("HTML/product.html");
                    } else {
                        response.sendRedirect("HTML/productList.html");
                    }
                } else {
                    request.setAttribute("errorMessage", "Podałeś złe hasło");
                    RequestDispatcher rd = request.getRequestDispatcher("HTML/login.jsp");
                    rd.forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "Użytkownik nie istnieje");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/login.jsp");
                rd.forward(request, response);

            }
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
