package kluczex;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CartServlet", urlPatterns = {"/CartServlet"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
        user = (String) session.getAttribute("user");
        if (user != null) {
            isLoggedIn = true;
        }
        String[] productID = request.getParameterValues("productID");
        String[] quantity = request.getParameterValues("ilosc");
        List<CartServletProduct> productList = new ArrayList();
        List<String> keys = new ArrayList();
        String allKeys = "";
        String textToSend = "";
        String name = "";
        ResultSet result;
        ResultSet email = null;
        DBConnection dbc = null;
        try {
            dbc = new DBConnection();

            email = dbc.ExecuteQuery("select * from uzytkownicy where login = '" + user + "'");
            email.next();
            for (int i = 0; i < productID.length; i++) {
                result = dbc.ExecuteQuery("select klucz_seryjny, nazwa, count(klucz_seryjny) as ilosc from klucze join produkty on produkty.id_produktu = klucze.id_produktu"
                        + " where klucze.id_produktu = " + productID[i] + "and login is null group by klucz_seryjny, nazwa limit " + quantity[i]);
                keys = new ArrayList();
                while (result.next()) {
                    keys.add(result.getString("klucz_seryjny"));
                    name = result.getString("nazwa");
                }
                CartServletProduct product = new CartServletProduct(productID[i], name, quantity[i], keys, new Date());
                productList.add(product);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        for (int i = 0; i < productList.size(); i++) {
            textToSend += "<h1>" + productList.get(i).getName() + "</h1>";
            for (int j = 0; j < productList.get(i).getKeys().size(); j++) {
                textToSend += "<h3>" + productList.get(i).getKeys().get(j) + "</h3>";
                allKeys += "'" + productList.get(i).getKeys().get(j) + "', ";
                //  System.out.println(productList.get(i).getKeys().get(j));
            }
        }
        allKeys = allKeys.substring(0, allKeys.length() - 2);
        try {
            dbc.ExecuteUpdate("update klucze set login = '" + user + "', data_zakupu = '" + new Date() + "' where klucz_seryjny in(" + allKeys + ")");
            dbc.ExecuteUpdate("delete from koszyk where login = '" + user + "'");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            //wysylanie maila
            // do zrobienia
            SendEmail.sendMail("sklep.kluczex@gmail.com","Hurtownia1",email.getString("email"), "KluczEX", textToSend);
        } catch (MessagingException ex) {
            Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("HTML/transactionSucc.jsp");
    }

}
