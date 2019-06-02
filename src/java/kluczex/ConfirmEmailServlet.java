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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ConfirmEmailServlet", urlPatterns = {"/ConfirmEmailServlet"})
public class ConfirmEmailServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String oldEmail = request.getParameter("oldEmail");
            String newEmail = request.getParameter("newEmail");
            String key = request.getParameter("key");
            HttpSession session = request.getSession();
            String user = null;
            Boolean isLoggedIn = false;
            user = (String) session.getAttribute("user");
            if (user != null) {
                isLoggedIn = true;
            }

            DBConnection dbc = new DBConnection();
            ResultSet result = dbc.ExecuteQuery("select klucz_weryfikacyjny, klucze_weryfikacyjne.login ,nowy_email, uzytkownicy.email as stary_email from klucze_weryfikacyjne join uzytkownicy on uzytkownicy.login = klucze_weryfikacyjne.login"
                    + " where klucze_weryfikacyjne.login ='" + user + "' and zuzyty = false order by lp desc");
            result.next();

            if (!oldEmail.equals(result.getString("stary_email"))) {
                request.setAttribute("errorMessage", "Podałeś zły email");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/changeEmail.jsp");
                rd.forward(request, response);
            } else if (!newEmail.equals(result.getString("nowy_email"))) {
                request.setAttribute("errorMessage", "Nowe emaile nie pasują do siebie");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/changeEmail.jsp");
                rd.forward(request, response);
            } else if (!key.equals(result.getString("klucz_weryfikacyjny"))) {
                request.setAttribute("errorMessage", "Podałeś zły klucz weryfikacyjny");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/changeEmail.jsp");
                rd.forward(request, response);
            } else {
                dbc.ExecuteUpdate("update klucze_weryfikacyjne set zuzyty = true where login = '" + user + "' and klucz_weryfikacyjny ='" + result.getString("klucz_weryfikacyjny") + "'");
                dbc.ExecuteUpdate("update uzytkownicy set email = '" + result.getString("nowy_email") + "' where login = '" + user + "'");
                request.setAttribute("errorMessage", "Udało się zmienić adres email");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/changeEmail.jsp");
                rd.forward(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(ConfirmEmailServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ConfirmEmailServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
