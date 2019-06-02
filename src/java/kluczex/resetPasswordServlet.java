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

@WebServlet(name = "resetPasswordServlet", urlPatterns = {"/resetPasswordServlet"})
public class resetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            DBConnection dbc = new DBConnection();

            ResultSet result = dbc.ExecuteQuery("select * from uzytkownicy where email = '" + email + "'");
            if (result.next()) {
                String key = email + (int) (Math.random() * 2140000000 + 100000);
                SendEmail.sendMail("sklep.kluczex@gmail.com", "Hurtownia1", email, "KluczEX reset hasła", "<h3>Przesylamy klucz resetowania hasla:</h3><br><h4>" + key + "</h4>");
                dbc.ExecuteUpdate("insert into reset_hasla (klucz_weryfikacyjny, email ,zuzyty) values ('" + key + "','"+email+"' ,false)");
                response.sendRedirect("HTML/confirmPassword.jsp");
            } else {
                request.setAttribute("errorMessage", "Nie znaleziono takiego adresu email");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/resetPassword.jsp");
                rd.forward(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(resetPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(resetPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(resetPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
