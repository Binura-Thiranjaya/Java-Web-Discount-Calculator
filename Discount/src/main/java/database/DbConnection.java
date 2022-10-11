package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DbConnection {
	private static Connection connection;

	private static void init() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/nippon_paint", "root", "");
		System.out.println("Connection Success");
	}

	public static void iud(String sql) throws Exception {
		if (connection == null) {
			init();
		}
		connection.createStatement().executeUpdate(sql);
	}

	public static ResultSet search(String sql) throws Exception {
		if (connection == null) {
			init();
		}
		return connection.createStatement().executeQuery(sql);
	}
}