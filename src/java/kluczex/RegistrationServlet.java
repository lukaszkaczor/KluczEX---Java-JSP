package kluczex;
/*servlet umozliwiajacy rejestracje*/
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

@WebServlet(name = "RegistrationServlet", urlPatterns = {"/RegistrationServlet"})
public class RegistrationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            /*pobieranie danych z formualarza*/
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confPassword = request.getParameter("confirmPassword");

            /*pobieranie danych z bazy*/
            DBConnection dbc = new DBConnection();
            ResultSet result = dbc.ExecuteQuery("select * from uzytkownicy where login = '" + username + "' or email = '" + email + "'");

            /*sprawdzanie czy login i email sa zajete*/
            while (result.next()) {
                if (username.equals(result.getString("login"))) {
                    request.setAttribute("errorMessage", "Taki użytkownik już istnieje");
                    RequestDispatcher rd = request.getRequestDispatcher("HTML/registration.jsp");
                    rd.forward(request, response);

                } else if (email.equals(result.getString("email"))) {
                    request.setAttribute("errorMessage", "Podany adres email jest już używany");
                    RequestDispatcher rd = request.getRequestDispatcher("HTML/registration.jsp");
                    rd.forward(request, response);
                }
            }

            /*sprawdzanie czy haslo i potwierdzenie hasla sa takie same*/
            if (!password.equals(confPassword)) {
                request.setAttribute("errorMessage", "Hasła nie pasują do siebie");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/registration.jsp");
                rd.forward(request, response);
            } else {
                /*rejestracja nowego uzytkownika*/
                dbc.ExecuteUpdate("insert into uzytkownicy (login, haslo, email, administrator) values('" + username + "', '" + password + "', '" + email + "', false)");
                response.sendRedirect("HTML/registrationSuccessful.html");
            }

        } catch (SQLException ex) {
            Logger.getLogger(RegistrationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RegistrationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
