package kluczex;
/*servlet do zmiany emaila*/ 
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

@WebServlet(name = "EmailChangeServlet", urlPatterns = {"/EmailChangeServlet"})
public class EmailChangeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String oldEmail = request.getParameter("oldEmail");
            String newEmail = request.getParameter("newEmail");
            HttpSession session = request.getSession();
            String user = null;
            Boolean isLoggedIn = false;
            user = (String) session.getAttribute("user");
            if (user != null) {
                isLoggedIn = true;
            }
            DBConnection dbc = new DBConnection();
            ResultSet result;
            /*sprawdzanie czy podany email jest zgodny z tym przypisanym do konta*/
            result = dbc.ExecuteQuery("select * from uzytkownicy where login ='" + user + "'");
            result.next();
            String email = result.getString("email");

            if (!oldEmail.equals(email)) {
                request.setAttribute("emailMessage", "Podałeś zły email");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/profile.jsp");
                rd.forward(request, response);
            } else if (oldEmail.equals(newEmail)) {
                request.setAttribute("emailMessage", "Podane emaile są takie same!");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/profile.jsp");
                rd.forward(request, response);
            } else {
                try {
                    /*jesli podany email jest zgodny z tym przypisanym do konta- wysyla na email klucz weryfikacyjny i przekierowuje przegladarke do strony gdzie ten klucz trzeba wpisac*/
                     String textToSend = user+(int) (Math.random() * 2140000000 + 100000);
                    dbc.ExecuteUpdate("insert into klucze_weryfikacyjne(login, klucz_weryfikacyjny,nowy_email ,zuzyty) values ('" + user +"','"+textToSend+"','"+newEmail+"', false)");
                    SendEmail.sendMail("sklep.kluczex@gmail.com","Hurtownia1",email, "KluczEX zmiana adresu Email", "<h3>Przesylamy klucz potrzebny do zmiany adresu email:</h3><br><h4>" + textToSend+"</h4>");
                    response.sendRedirect("HTML/changeEmail.jsp");
                   
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(EmailChangeServlet.class.getName()).log(Level.SEVERE, null, ex);
                } catch (MessagingException ex) {
                    Logger.getLogger(EmailChangeServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                
            }
//
//            
//            if (oldEmail.equals(newEmail)) {
//                request.setAttribute("emailMessage", "Podane emaile są takie same!");
//                RequestDispatcher rd = request.getRequestDispatcher("HTML/profile.jsp");
//                rd.forward(request, response);
//            } else if(email.equals(newEmail)){
////                dbc.ExecuteUpdate("update uzytkownicy set email = '" + email + "' where login = '" + user + "'");
//                response.sendRedirect("HTML/changeEmail.jsp");
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(EmailChangeServlet.class.getName()).log(Level.SEVERE, null, ex);
//        }
            
        } catch (SQLException ex) {
            Logger.getLogger(EmailChangeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
