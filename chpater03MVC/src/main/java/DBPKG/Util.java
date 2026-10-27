package DBPKG;

import java.sql.*;
public class Util {
	
	// getConnection()五社球 持失
	public static Connection getConnection() throws Exception{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC&useSSL=false", 
				"root", 
				"1234");
		return con;
	}
}
