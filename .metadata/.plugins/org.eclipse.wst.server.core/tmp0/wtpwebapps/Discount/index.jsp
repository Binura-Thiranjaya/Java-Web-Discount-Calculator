<%@page import="database.DbConnection"%>
<%@page import="controller.DiscountController"%>
<%@page import="database.Result"%>
<%@page import="java.sql.ResultSet"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Nippon Paint</title>
<!-- Bootstrap css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
</head>
<body>
	<div class="container mt-2 ">
		<h2 class="text-center text-uppercase pb-4">SAP Discount
			Calculator</h2>
		<form action="index" method="post">
			<div class="form-group row  pb-2 ">
				<label for="customer_id_selector" class="col-sm-2 col-form-label">Customer
					Id :-</label>
				<div class="col-sm-8">
					<select class="form-control" id="customer_id" name="customer_id">
						<option>Select ID</option>
						<%
						ResultSet rs = DbConnection.search("SELECT customer_code FROM `customers`");
						while (rs.next()) {
						%>
						<option><%="" + Integer.parseInt(rs.getString("customer_code"))%></option>
						<%}%>
					</select>
				</div>
				<button type="submit" class="btn btn-outline-danger">Calcualate
					Discount</button>
			</div>
		</form>
		<table class="table table-striped">
			<thead class="thead-dark">
				<tr>
					<th scope="col">Invoice No</th>
					<th scope="col">Customer Code</th>
					<th scope="col">Customer Name</th>
					<th scope="col">Discount</th>
				</tr>
			</thead>
			<tbody>
				<%
				DiscountController objDiscountController = new DiscountController();
				ResultSet rs1 = DbConnection.search(
						"SELECT i.inv_number,i.customer_code,c.customer_name, DateDiff(invoice_setoff_date,invoice_date) AS Day ,d.material_group,SUM(d.quantity) aS Total FROM invoice i INNER JOIN invoice_detail d ON i.inv_number = d.invoice_number INNER JOIN customers c ON i.customer_code = c.customer_code GROUP BY d.invoice_number,d.material_group");

				while (rs1.next()) {

					int timeSlotID = objDiscountController.findTimeSlotID(Integer.parseInt(rs1.getString("Day")));
					int materialID = objDiscountController.findMaterialID(rs1.getString("material_group"));
					int value = objDiscountController.findValue(timeSlotID, materialID);
					int Discount = objDiscountController.Discount(value, Integer.parseInt(rs1.getString("Total")));
				%>
				<tr>
					<td><%="" + Integer.parseInt(rs1.getString("inv_number"))%></td>
					<td><%="" + Integer.parseInt(rs1.getString("i.customer_code"))%></td>
					<td><%=rs1.getString("c.customer_name")%></td>
					<td><%=Discount%></td>
				</tr>
				<%}%>
			</tbody>
		</table>


	</div>
	<!-- Bootstrap Js -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
</body>
</html>