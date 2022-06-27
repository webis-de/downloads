<!DOCTYPE html>
<html lang="de">
<head>
    <title>URL Parameter</title>
    <meta charset="utf-8">
</head>
<body>
<% String user = request.getParameter("user");
if (user == null || user.trim().isEmpty()) { %>
    <h3>Anmeldung</h3>
    <form method="get">
        <div>
            <label for="user">Benutzername:</label>
            <input type="text" name="user" id="user">
        </div>
        <input type="submit" value="Anmelden"> <br>
    </form>
<% } else { %>
    <h3>Ihre Anmeldedaten:</h3>
    Benutzername: <%= user %>
<% } %>
</body>
</html>
