<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>

<html>
<head>
<title>Connection with mysql database</title>
</head>
<body>
<h1>Connection status</h1>
<% 
try {
/* Create string of connection url within specified format with machine name, 
port number and database name. Here machine name id localhost and 
database name is usermaster. */ 
String url = "jdbc:mysql://localhost:3306/company_connect";
String dbName = "jdbctutorial";
String driver = "com.mysql.jdbc.Driver";
String userName = "root"; 
String password = "root";
// declare a connection by using Connection interface 
Connection con = null; 

// Load JBBC driver "com.mysql.jdbc.Driver" 
Class.forName("com.mysql.jdbc.Driver").newInstance(); 

/* Create a connection by using getConnection() method that takes parameters of 
string type connection url, user name and password to connect to database. */ 
con = DriverManager.getConnection(url, "root", "");

String name = request.getParameter("name");
String com	= request.getParameter("company");
String col=request.getParameter("college");
String exp=request.getParameter("experience");
String sk=request.getParameter("skills");
String data="";
/*if( name != null &&  com == null && col==null && exp == null && sk == null ){
	Statement st=con.createStatement();
    ResultSet rs=st.executeQuery("select id from person where name like '"+name+"' or ");
}*/
String query1="select * from person where 1=1";
if(name!=null){
	query1=query1+" and name like '"+name+"'";
}

if(com!=null)
{
	query1+="and id in (select id from position where company like '"+com+"')";
}
if(col!=null)
{
	query1+="and id in (select id from education where university like '"+col+"')";
}
if(exp!=null)
{
	query1+="and id in (select id from position where experience like '"+exp+"')";
}
if(sk!=null)
{
	query1+="and id in (select id from skills where skills like '"+sk+"')";
}
Statement st = con.createStatement();
ResultSet rs = st.executeQuery(query1);
/*while(rs.next())
{
data = ":" +rs.getString("first_name") + " "+rs.getString("last_name")+":"+ rs.getString("email_id") +":"+  rs.getString("linkedin")+ rs.getString("mobile")+ rs.getString("position");
}*/

     session.setAttribute("RS", rs);

// check weather connection is established or not by isClosed() method 
if(!con.isClosed())
%>
<font size="+3" color="green"></b> <% 
out.println("Successfully connected to " + "MySQL server using TCP/IP...");
con.close();
}
catch(Exception ex){
	ex.printStackTrace();
%> </font>
<font size="+3" color="red"></b> <%
out.println("Unable to connect to database.");
}
%> </font>
response.sendRedirect("index.jsp");
</body>
</html>
