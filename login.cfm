<cfif structKeyExists(form, "username") AND structKeyExists(form, "password")>

    <cfquery name="myquery" datasource="#application.datasource#">
        SELECT id, username, profile_picture
        FROM users
        WHERE username = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">
        AND password = <cfqueryparam value="#form.password#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <cfif myquery.recordcount EQ 1>
        <cfset session.userid = myquery.id>
        <cfset session.username = form.username>
        <cfif len(myquery.profile_picture)>
            <cfset session.profilePic = "/CRMv3/uploads/#myquery.profile_picture#">
        </cfif>
        <cflocation url="index.cfm">
    <cfelse>
        <cflocation url="login.cfm?error=true">
    </cfif>

</cfif>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="css/login.css">
    <link rel="stylesheet" href="css/common.css">
</head>
<body>
 <cfif structKeyExists(url, "error") AND url.error EQ "login">
  <p class="error-msg">Login First!</p>
</cfif>
 <cfif structKeyExists(url, "error") AND url.error EQ "logout">
  <p class="success-msg">Successfully Logout!</p>
</cfif>

    <div class="login-container">
        <h2>Login</h2>

        <!-- Error Message -->
        <cfif structKeyExists(url, "error") AND url.error EQ "true">
            <div class="error-msg">Invalid username or password</div>
        </cfif>

        <form method="post">
            <label for="username">Username:</label>
            <input type="text" name="username" id="username" required><br>

            <label for="password">Password:</label>
            <input type="password" name="password" id="password" required><br>

            <input type="submit" value="Login" class="sub-btn">
        </form>
         <form action="pages/register.cfm" method="get">
    <input class="reg-btn" type="submit" value="Registration">
  </form></br>
  <a href="pages/forgot.cfm">forgot password?</a>
    </div>
</body>
</html>
