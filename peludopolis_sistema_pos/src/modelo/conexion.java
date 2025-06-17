package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class conexion {

    Connection con;

    public Connection getConnection() {
        try {
            String myDb = "jdbc:mysql://localhost:3306/peludopolis_sistema_ventas_db?serverTimezone=UTC";
            con = DriverManager.getConnection(myDb, "root", "");
            return con;
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
        return null;
    }
}
