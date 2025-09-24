<cfparam name="form.username" default="">
<cfparam name="form.password" default="">
<cfparam name="form.cpassword" default="">
<cfparam name="form.email" default="">

<cfset errorMsg = "">
<cfset successMsg = "">

<cfif structKeyExists(form, "register")>

  <!-- Only now run validations -->
  <cfif NOT len(trim(form.username)) EQ 0>

    <cfif form.password EQ form.cpassword>

      <!-- Check username -->
      <cfquery name="checkUser" datasource=#application.datasource#>
        SELECT id FROM users WHERE username = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">
      </cfquery>

      <!-- Check email -->
      <cfquery name="emailcheck" datasource=#application.datasource#>
        SELECT email FROM users WHERE email = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
      </cfquery>

      <!-- Validate password -->
      <cfset hasSpecialChar = reFind("[@##\$%&*!?]", form.password)>
      <cfset hasCapital     = reFind("[A-Z]", form.password)>
      <cfset hasSmall       = reFind("[a-z]", form.password)>
      <cfset hasNumbers     = reFind("[0-9]", form.password)>
      <cfset islen          = len(trim(form.password)) GTE 8>

      <cfif checkUser.recordCount GT 0>
        <cfset errorMsg = "username">
      <cfelseif emailcheck.recordCount GT 0>
        <cfset errorMsg = "email">
      <cfelseif NOT (hasSpecialChar GT 0 AND hasCapital GT 0 AND hasSmall GT 0 AND hasNumbers GT 0 AND islen)>
        <cfset errorMsg = "invalidpassword">
      <cfelse>
        <!-- Insert user -->
        <cfif len(trim(form.email)) GT 0>
          <cfquery name="insertUser" datasource="#application.datasource#">
            INSERT INTO users (username, password, email)
            VALUES (
              <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">,
              <cfqueryparam value="#form.password#" cfsqltype="cf_sql_varchar">,
              <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
            )
          </cfquery>
        <cfelse>
          <cfquery name="insertUser" datasource="#application.datasource#">
            INSERT INTO users (username, password)
            VALUES (
              <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">,
              <cfqueryparam value="#form.password#" cfsqltype="cf_sql_varchar">
            )
          </cfquery>
        </cfif>

        <cfset successMsg = "true">
      </cfif>

    <cfelse>
      <cfset errorMsg = "password">
    </cfif>

  <cfelse>
    <cfset errorMsg = "blankusername">
  </cfif>
</cfif>

<!DOCTYPE html>
<html>
<head>
  <title>Register</title>
  <link rel="stylesheet" href="../css/common.css">
  <link rel="stylesheet" href="../css/register.css">
</head>
<body>

<div class="form-container">
  <h2>User Registration</h2>

  <!-- Display Alerts -->
  <cfif len(errorMsg) >
    <cfif errorMsg EQ "username">
      <p class="error-msg">Username already exists or registration failed</p>
    <cfelseif errorMsg EQ "email">
      <p class="error-msg">Email is already linked with another user</p>
    <cfelseif errorMsg EQ "password">
      <p class="error-msg">Passwords do not match</p>
    <cfelseif errorMsg EQ "invalidpassword">
      <p class="error-msg">
       Please choose a stronger password. Try a mix of letters, numbers, and symbols.
      </p>
    </cfif>
  <cfelseif successMsg EQ "true">
    <p class="success-msg">Registration successful!</p>
  </cfif>

  <!-- Registration Form -->
  <form method="post">
    <label>Username:</label>
    <input type="text" name="username" required>

    <label>Enter Password:</label>
    <input type="password" name="password" required>

    <label>Confirm Password:</label>
    <input type="password" name="cpassword" required>

    <label>Email (optional):</label>
    <input type="email" name="email">

    <input type="submit" name="register" value="Register">
  </form>

  <div class="login-link">
    Already registered? <a href="../login.cfm">Login Here</a><br><br>
    Forgot your password? <a href="forgot.cfm">Reset Here</a>
  </div>
</div>

</body>
</html>
