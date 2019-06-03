package kluczex;
/*SERVLET NIEUZYWANY W PROJEKCIE Z POWODU BLEDU
W INNYM PLIKU
*/
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ReloadServlet", urlPatterns = {"/ReloadServlet"})
public class ReloadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        Cookie cookie = null;
//        Cookie[] cookies = null;
//        cookies = request.getCookies();
//        String user = null;
//        Boolean isLoggedIn = false;
//        if (cookies != null) {
//            for (int i = 0; i < cookies.length; i++) {
//                if (cookies[i].getName().equals("username")) {
//                    isLoggedIn = true;
//                    user = cookies[i].getValue();
//                }
//            }
//        }
        HttpSession session = request.getSession();
        String user = null;
        Boolean isLoggedIn = false;
        user = (String)session.getAttribute("user");
        
        if(user!=null)
        {
            isLoggedIn = true;
        }


        String[] productID = request.getParameterValues("productID");
        String[] quantity = request.getParameterValues("quantity");
        String update = "";
            

        for (int i = 0; i < quantity.length; i++) {
            System.out.println(productID[i]);
            update += "update koszyk set ilosc = " + quantity[i] + " where login = '"+user+"' and id_produktu =" + productID[i]+ ";"; 
        }
        
        try {
            DBConnection dbc = new DBConnection();
            dbc.ExecuteUpdate(update);
            response.sendRedirect("HTML/cart.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(ReloadServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ReloadServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
