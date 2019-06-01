/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package kluczex;

import java.io.IOException;
import java.io.PrintWriter;
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
import javax.servlet.http.HttpSession;

@WebServlet(name = "AddToCartServlet", urlPatterns = {"/AddToCartServlet"})
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productID = request.getParameter("productID");
        String quantity = request.getParameter("quantity");

//        Cookie cookie = null;
//        Cookie[] cookies = null;
//        cookies = request.getCookies();
//        String user = null;
        HttpSession session = request.getSession();
        String user = null;
        Boolean isLoggedIn = false;
        user = (String)session.getAttribute("user");
        
        if(user!=null)
        {
            isLoggedIn = true;
        }

      
//        if (cookies != null) {
//            for (int i = 0; i < cookies.length; i++) {
//                if (cookies[i].getName().equals("username")) {
//                    isLoggedIn = true;
//                    user = cookies[i].getValue();
//                }
//            }
//        }

        if (!isLoggedIn) {
            response.sendRedirect("HTML/login.jsp");
        } else {
            try {
                DBConnection dbc = new DBConnection();
                ResultSet result = dbc.ExecuteQuery("select cena, count(klucz_seryjny) as ilosc from klucze where id_produktu = " + productID + " group by cena");
                result.next();

                if (Integer.parseInt(result.getString("ilosc")) < Integer.parseInt(quantity)) {
                    request.setAttribute("errorMessage", "Nie ma aż tylu dostępnych sztuk");
                    RequestDispatcher rd = request.getRequestDispatcher("HTML/product.jsp");
                    rd.forward(request, response);
                }
                else
                dbc.ExecuteUpdate("insert into koszyk values('" + user + "', " + productID + ", " + quantity + ", " + result.getString("cena") + ")");
                 response.sendRedirect("HTML/cart.jsp");
            
            } catch (SQLException ex) {
                Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(AddToCartServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

//        System.out.println(isLoggedIn);
//        System.out.println(productID);
//        System.out.println(quantity);
////        System.out.println(user);
    }

}
