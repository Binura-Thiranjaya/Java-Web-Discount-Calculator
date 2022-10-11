package database;

import java.sql.ResultSet;

public class Result {
	public static ResultSet getRs() {
		return rs;
	}

	public static void setRs(ResultSet rs) {
		Result.rs = rs;
	}

	private static ResultSet rs;
}
