/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package kluczex;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnection {

    public ResultSet result;
    PreparedStatement stmt; 
    public String statement;
    Connection con;

    public DBConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection("jdbc:postgresql://sql.racecar.nazwa.pl/racecar_sklepKluczy", "racecar_sklepKluczy", "Hurtownia1");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public ResultSet ExecuteQuery(String statement) throws SQLException {
        stmt = con.prepareStatement(statement);
        result = stmt.executeQuery();
//        con.close();

        return result;
    }

    public void ExecuteUpdate(String statement) throws ClassNotFoundException {

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://sql.racecar.nazwa.pl/racecar_sklepKluczy", "racecar_sklepKluczy", "Hurtownia1");

            PreparedStatement ps = null;
            String query = statement;
            ps = con.prepareStatement(query);
            ps.executeUpdate();
            con.close();

        } catch (SQLException ex) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
}


/*public class DBConnection {
    public static void main(String[] args) throws SQLException{
        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection("jdbc:postgresql://sql.racecar.nazwa.pl/racecar_zaopatrzeniePizzerii", "racecar_zaopatrzeniePizzerii", "Hurtownia1");
            PreparedStatement stmt = con.prepareStatement("select * from etaty");
            ResultSet rs = stmt.executeQuery();
            while(rs.next()){
                System.out.println(rs.getInt(1)+" "+rs.getString(2));
       
            }
            
                    } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
 */
