<!DOCTYPE html>
<html>
  <head>
    <title>Registration</title>
  </head>
  <body>
    <% 
    String user=request.getParameter("user");
    if(user==null || user.trim().equals("")){
    %>
    <h3>Anmeldung</h3>
<!--    <form method="get" action="registration.jsp"> -->
    <form method="get">
      <table>
	<tr>
	    <td>Benutzername:</td>
            <td> <input type="text" name="user"></td>
	</tr>
	<tr>
	    <td>
	      <input type="submit" value="Anmelden">
	    </td>
	</tr>
      </table>
    </form>
    <% 
    }
    else{
    %>
    <h3>Ihre Anmeldedaten:</h3>
    Benutzername: <%= user %>
    <%
    }
    %>
  </body>
</html>
