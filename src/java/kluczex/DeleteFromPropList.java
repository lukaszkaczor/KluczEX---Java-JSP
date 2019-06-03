
/*servlet do usuwanie pozycji z tabeli proponowane*/
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

@WebServlet(name = "DeleteFromPropList", urlPatterns = {"/DeleteFromPropList"})
public class DeleteFromPropList extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            /*dopoki na liscie jest 25 lub wiecej pozycji, mozna usunac jedna z nich
               w przeciwnym razie wyskakuje blad ktory zapobiega  "psuciu" sie strony*/
            String productID = request.getParameter("productID");
            DBConnection dbc = new DBConnection();
            ResultSet result = dbc.ExecuteQuery("select count(*) as ilosc from polecane");
            result.next();
            int ilosc = Integer.parseInt(result.getString("ilosc"));
            if (ilosc <= 25) {
                request.setAttribute("errorMessage", "W polecanych powinno byc min 25 pozycji");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/admin.jsp");
                rd.forward(request, response);
            } else {
                /*jesli poprzedni warunek nie zostal spelniony produkt zostaje usuniety z listy*/
                dbc.ExecuteUpdate("delete from polecane where id_produktu = " + productID);
                request.setAttribute("errorMessage", "Udało się!");
                RequestDispatcher rd = request.getRequestDispatcher("HTML/admin.jsp");
                rd.forward(request, response);
            }

        } catch (SQLException ex) {
            Logger.getLogger(DeleteFromPropList.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DeleteFromPropList.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
