/*servlet oblusgujacy zmiane hasla*/
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

@WebServlet(name = "PasswordChangeServlet", urlPatterns = {"/PasswordChangeServlet"})
public class PasswordChangeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            /*pobieranie danych z formualarza*/
            String oldPassword = request.getParameter("oldPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            HttpSession session = request.getSession();
            String user = null;
            Boolean isLoggedIn = false;
            user = (String) session.getAttribute("user");
            if (user != null) {
                isLoggedIn = true;
            }
            DBConnection dbc = new DBConnection();
            ResultSet result;
            /*pobieranie danych z bazy*/
            result = dbc.ExecuteQuery("select * from uzytkownicy where login ='" + user + "'");
            result.next();
            String password = result.getString("haslo");
            /*porownywanie wprowadzonych danych z danymi z formularza
               jesli wszystko sie zgadza- haslo zostaje zmienione, jesli wystepuja jakies bledy program wskazuje blad
            */
            if (!password.equals(oldPassword)) {
                request.setAttribute("errorMessage", "Podałeś złe hasło");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/profile.jsp");
                rd.forward(request, response);
            } else if (oldPassword.equals(newPassword)) {
                request.setAttribute("errorMessage", "Nowe i stare hasło są takie same!");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/profile.jsp");
                rd.forward(request, response);
            } else if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Podane hasła różnią się od siebie");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/profile.jsp");
                rd.forward(request, response);
            } else if (!oldPassword.equals(newPassword) && newPassword.equals(confirmPassword) && oldPassword.equals(password)) {
                try {

                    dbc.ExecuteUpdate("update uzytkownicy set haslo = '" + newPassword + "' where login = '" + user + "'");
                    request.setAttribute("errorMessage", "Hasło zostało zmienione");
                    RequestDispatcher rd = request.getRequestDispatcher("HTML/profile.jsp");
                    rd.forward(request, response);
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(PasswordChangeServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PasswordChangeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
