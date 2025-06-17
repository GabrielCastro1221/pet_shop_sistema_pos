package reportes;

import java.awt.Font;
import modelo.conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartFrame;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PiePlot;
import org.jfree.data.general.DefaultPieDataset;

public class grafico {

    public static void Graficar(String fecha) {
        conexion cn = new conexion();
        Connection con;
        PreparedStatement ps;
        ResultSet rs;

        try {
            String sql = "SELECT total FROM ventas WHERE fecha = ?";
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, fecha);
            rs = ps.executeQuery();

            DefaultPieDataset dataset = new DefaultPieDataset();
            int contador = 1;

            while (rs.next()) {
                double total = rs.getDouble("total");
                dataset.setValue(String.format("Venta %d ($%.2f)", contador, total), total);
                contador++;
            }

            if (contador == 1) {
                System.out.println("No hay ventas para la fecha: " + fecha);
                return;
            }

            JFreeChart chart = ChartFactory.createPieChart(
                    "Reporte de ventas del día " + fecha,
                    dataset,
                    true,
                    true,
                    false
            );

            chart.getTitle().setFont(new Font("Arial", Font.BOLD, 24));
            PiePlot plot = (PiePlot) chart.getPlot();
            plot.setLabelFont(new Font("Arial", Font.PLAIN, 16));

            ChartFrame frame = new ChartFrame("Gráfico de Ventas", chart);
            frame.setSize(900, 700); 
            frame.setLocationRelativeTo(null);
            frame.setVisible(true);

        } catch (Exception e) {
            System.out.println("Error al generar el gráfico: " + e.getMessage());
        }
    }
}
