package kluczex;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.MessagingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "confirmPasswordServlet", urlPatterns = {"/confirmPasswordServlet"})
public class confirmPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String key = request.getParameter("key");
//            String newPassword = request.getParameter("newPassword");
//            String confirmPassword = request.getParameter("confirmPassword");
            DBConnection dbc = new DBConnection();

            ResultSet result = dbc.ExecuteQuery("select * from reset_hasla where email ='" + email + "' and zuzyty = false order by lp desc");

            if (!result.next()) {
                request.setAttribute("errorMessage", "Nie znaleziono takiego adresu email");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/confirmPassword.jsp");
                rd.forward(request, response);
            } else if (!key.equals(result.getString("klucz_weryfikacyjny"))) {
                request.setAttribute("errorMessage", "Podałeś zły klucz");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/confirmPassword.jsp");
                rd.forward(request, response);

            } else if (!email.equals(result.getString("email"))) {
                request.setAttribute("errorMessage", "Podałeś zły email");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/confirmPassword.jsp");
                rd.forward(request, response);
            }
            else if (key.equals(result.getString("klucz_weryfikacyjny")) && email.equals(result.getString("email"))) {
                String newPassword = "" + (int) (Math.random() * 2140000000 + 100000);
                dbc.ExecuteUpdate("update uzytkownicy set haslo = '" + newPassword + "' where email ='" + email + "'");
                dbc.ExecuteUpdate("update reset_hasla set zuzyty = true where klucz_weryfikacyjny = '" +result.getString("klucz_weryfikacyjny")+ "'");
                SendEmail.sendMail("sklep.kluczex@gmail.com", "Hurtownia1", email, "KluczEX", "Twoje nowe haslo: " + newPassword);
                request.setAttribute("errorMessage", "Nowe hasło zostało wysłane na adres email");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/confirmPassword.jsp");
                rd.forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Wystąpił nieoczekiwany błąd");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/confirmPassword.jsp");
                rd.forward(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(confirmPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(confirmPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(confirmPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
