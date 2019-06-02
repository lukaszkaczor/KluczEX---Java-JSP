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
import javax.servlet.http.HttpSession;

@WebServlet(name = "RODOServlet", urlPatterns = {"/RODOServlet"})
public class RODOServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            String user = null;
            Boolean isLoggedIn = false;
            user = (String) session.getAttribute("user");
            if (user != null) {
                isLoggedIn = true;
            }
            DBConnection dbc = new DBConnection();
            ResultSet result;
            ResultSet email;
            email = dbc.ExecuteQuery("select * from uzytkownicy where login = '" + user + "'");
            email.next();

            result = dbc.ExecuteQuery("select klucze.login, haslo, email, data_zakupu, klucz_seryjny, produkty.nazwa from uzytkownicy join klucze on klucze.login = uzytkownicy.login join"
                    + " produkty on produkty.id_produktu = klucze.id_produktu where klucze.login = '" + user + "';");
            result.next();
            String textToSend = "Login: " + result.getString("login") + "<br>Haslo: " + result.getString("haslo") + "<br>Email: " + result.getString("email") + "<br>Kupione klucze:";

            do {
                textToSend += "<br>" + result.getString("nazwa") + " " + result.getString("klucz_seryjny") + " " + result.getString("data_zakupu");

            } while (result.next());

            SendEmail.sendMail("sklep.kluczex@gmail.com", "Hurtownia1", email.getString("email"), "KluczEX RODO", textToSend);

            request.setAttribute("RODOMessage", "Informacje o koncie zostały wysłane na adres email");
            RequestDispatcher rd = request.getRequestDispatcher("HTML/profile.jsp");
            rd.forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(RODOServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(RODOServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
