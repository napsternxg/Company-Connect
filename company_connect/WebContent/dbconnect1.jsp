

<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.company_connect.*"%>


<% 
ArrayList<Employee> al=new ArrayList<Employee>();

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

String name=request.getParameter("name");
String com=request.getParameter("company");
String col=request.getParameter("college");
String exp=request.getParameter("experience");
String sk=request.getParameter("skills");
String deg=request.getParameter("degree");
String tra=request.getParameter("trade");
String loc=request.getParameter("location");

//out.println(name);
//out.println(com);
//out.println(col);
//out.println(exp);
//out.println(sk);
/*
String name="ravi";
String com=null;
String col=null;
String exp=null;
String sk=null;
*/
String data="";
String first_name="",last_name="",x="",y="",z="";
int i=0;
/*if( name != null &&  com == null && col==null && exp == null && sk == null ){
	Statement st=con.createStatement();
    ResultSet rs=st.executeQuery("select id from person where name like '"+name+"' or ");
}*/
int n;
String query1="select * from person where 1=1";
if(name!=null && !name.equals(""))
{
	StringTokenizer stringTokenizer = new StringTokenizer(name);
	n=stringTokenizer.countTokens();
	//System.out.println(name);
	//System.out.println("The total no. of tokens  generated :  "+n);
	if(n==1)
	{
		z=name;
		first_name=z.toLowerCase();
	}
	else
	{
		while(stringTokenizer.hasMoreTokens())
		{
			if(i==0)
			{
				x=stringTokenizer.nextToken();
				first_name=x.toLowerCase();
			}
			if(i==(n-1))
			{
				y=stringTokenizer.nextToken();
				last_name=y.toLowerCase();
			} 
			i++;
			
		}
	}	
	if(n==1)
	{
		query1=query1+" and ( LCASE(first_name) like '"+first_name+"%' or LCASE(last_name) like '" +first_name+"%') ";
		//query1=query1+" and LCASE(first_name) like '"+last_name+"%'";
	
	}
	if(n>1 && first_name!=null && !first_name.equals(""))
	{
		query1=query1+" and LCASE(first_name) like '"+first_name+"%'";
	}
	if(last_name!=null && !last_name.equals(""))
	{
		query1=query1+" and LCASE(last_name) like '"+last_name+"%'";
	}
}

if(com!=null && !com.equals(""))
{
	String a="";
	a=com.toLowerCase();
	query1+=" and id in (select id from position where LCASE(company) like '"+a+"%')";
}

if(loc!=null && !loc.equals(""))
{
	String a="";
	a=loc.toLowerCase();
	query1+=" and id in (select id from person where LCASE(location) like '"+a+"%')";
}

if(col!=null && !col.equals(""))
{
	String b="";
	b=col.toLowerCase();
	query1+=" and id in (select id from education where LCASE(university) like '%"+b+"%')";
}
if(exp!=null && !exp.equals(""))
{
	query1+=" and id in (select id from position where duration >= "+exp+")";
}

if(sk!=null && !sk.equals(""))
{
	String[]tok=sk.split(",");
	
	for	(int xx=0;xx<tok.length;xx++)
	{
		String c=tok[xx].toLowerCase().trim();
		if(c.length()>0)
		{
			query1+=" and id in (select id from skills where LCASE(skills) like '"+c+"%')";
		}
	}
	
}
if(tra!=null && !tra.equals(""))
{
	String c="";
	c=tra.toLowerCase();
	query1+=" and id in (select id from education where LCASE(trade) like '%"+c+"%')";
}
if(deg!=null && !deg.equals(""))
{
	String c="";
	c=deg.toLowerCase();
	query1+=" and id in (select id from education where LCASE(degree) like '%"+c+"%')";
}
query1+= " order by first_name , last_name ";
Statement st = con.createStatement();
//System.out.println(query1);
ResultSet rs = st.executeQuery(query1);

//session.setAttribute("RS", rs);
session.setAttribute("searchResult","true");
int counter=0;
while(rs.next())
{
	counter++;
	Employee temp=new Employee();
	int id =rs.getInt("id");
	temp.name= (rs.getString("first_name")+ " " + rs.getString("last_name")).toUpperCase();
	temp.email=rs.getString("email_id");
	temp.url=rs.getString("linkedinURL");
	temp.mob=rs.getString("mobile_number");
	temp.picURL = rs.getString("photo_url");
	temp.location=rs.getString("location");
	
query1=" select * from education where id="+id;
	
	Statement st1 = con.createStatement();	
	//System.out.println(query1);
	ResultSet rs1 = st1.executeQuery(query1);
	
	boolean first=true;
	
	while(rs1.next())
	{
		if(first)
		{
			temp.education="";
			first =false;
		}
		String university=rs1.getString("university");
		String degree=rs1.getString("degree");
		String trade=rs1.getString("trade");
		if(university!=null && university.length()>0)
		{
			temp.education+= university+" - ";
		}
		if(degree!=null && degree.length()>0)
		{
			temp.education+= degree + " , ";
		}
		if(trade!=null && trade.length()>0)
		{
			temp.education+= trade;
		}
		temp.education+=";";
		
	}
	rs1.close();
	
	query1=" select * from position where id="+id;
	//System.out.println(query1);
	Statement st2 = con.createStatement();
	ResultSet rs2 = st2.executeQuery(query1);
	
	 first=true;
	
	while(rs2.next())
	{
		if(first)
		{
			temp.experience="";
			first=false;
		}
		String title=rs2.getString("title");
		String company=rs2.getString("company");
		Integer duration=rs2.getInt("duration");
		if(title!=null && title.length()>0)
		{
			temp.experience+= title;
		}
		if(company!=null && company.length()>0)
		{
			temp.experience+= " at "+company;
		}
		if(duration!=null && duration>=0)
		{
			if(duration!=0 && duration!=1)
				temp.experience+= ("-"+duration+" Months ");
			if(duration==1)
				temp.experience+= ("-"+duration+" Month ");
		}
		temp.experience+=";";
				
	}
	rs2.close();
	query1=" select * from skills where id="+id;
	Statement st3 = con.createStatement();
	//System.out.println(query1);
	ResultSet rs3 = st3.executeQuery(query1);
	first=true;
	//temp.skills="Skills: ";
	while(rs3.next())
	{
		if(first)
		{
			temp.skills="<b>Skills: </b>";
			first=false;
		}
		String skills=rs3.getString("skills");
		if(skills!=null && skills.length()>0)
		{
			temp.skills+= skills;
		}
		
		temp.skills+=";";
				
	}
	rs3.close();
	
	al.add(temp);
	
	
	//out.println(rs.getString("first_name"));
	//out.println(rs.getString("last_name"));
	//out.println(rs.getString("email_id"));
	//out.println(rs.getString("linkedinURL"));
	//out.println(rs.getString("mobile_number"));
	//out.println("Rohit");
//data = ":" +rs.getString("first_name") + " "+rs.getString("last_name")+":"+ rs.getString("email_id") +":"+  rs.getString("linkedinURL")+ rs.getString("mobile_number");
//out.println("Rohit");
}
//out.println();
%>
<h2 style="margin:0">Number of Result Found: <%=counter %></h2>
<%
    			ArrayList<Employee> RST = al;
    			String searchResult=(String)session.getAttribute("searchResult");
    			
    			
    			if(searchResult!=null &&searchResult.equals("true"))
    			{
    			
    			for(int ii=0;ii<RST.size();ii++)			
				{		
    				String email=RST.get(ii).email;
    				String mob=RST.get(ii).mob;
    				String url1=RST.get(ii).url;
    				String education =RST.get(ii).education;
    				String experience=RST.get(ii).experience;
    				String skills=RST.get(ii).skills;
    				String location=RST.get(ii).location;
    				%>
    				<div class="ex"  onclick="return toggleMe('para<%=ii+"'"%>)"> 
					 <%out.println("<img src='"+RST.get(ii).picURL+"' class='profile_pic'><h2>"+RST.get(ii).name+"<span class='expand'>+</span></h2>");%>			  
					<div id="para<%=ii+"\""%> style="display:none">
					
					<table>
						<tr><td><%if(location!=null)out.println("<b>Current Location: </b>"+RST.get(ii).location);%></td></tr>					
						<tr><td><%if(email!=null)out.println("<b>Email: </b>"+RST.get(ii).email);%></td></tr>
	    				<tr><td><%if(mob!=null)out.println("<b>Mobile Number: </b>"+RST.get(ii).mob);%> </td></tr>
	    				<tr><td><%if(url1!=null)out.println("<b>Linkedin URL: </b><a href='"+RST.get(ii).url+"' target='_blank'>Go to LinkedIn Profile</a>");%> </td></tr>
	    				<tr><td><%if(education!=null){
	    				String[] temp = RST.get(ii).education.split(";");
	    				out.println("<b> Education: </b><ul class='profile_data'>");
	    				for(String edu : temp ){
	    				out.println("<li>"+edu+"</li>");
	    				}
	    				out.println("</ul>");
	    				
	    				}%> </td></tr>
	    				<tr><td><%if(experience!=null){
	    				String[] temp = RST.get(ii).experience.split(";");
	    				out.println("<b> Career: </b><ul class='profile_data'>");
	    				for(String edu : temp ){
	    				out.println("<li>"+edu+"</li>");
	    				}
	    				out.println("</ul>");
	    				
	    				//out.println(RST.get(ii).experience);
	    				}%> </td></tr>
	    				<tr><td><%if(skills!=null)out.println(RST.get(ii).skills);%> </td></tr>
	    				
	    			</table>
	    			
					</div>
					</div>	
    				<%
    	    
				}
    			}
    			
if(!con.isClosed())

con.close();
}
catch(Exception ex){
	ex.printStackTrace();

}
%>




