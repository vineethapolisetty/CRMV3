<!DOCTYPE html>
<html>
<head>
    <title>Forgot / Reset Password</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../css/forgot.css">
   
</head>
<body>
    <h3>Forgot / Reset Password</h3>

    <cfparam name="form.username" default="">
    <cfparam name="form.email" default="">
    <cfparam name="form.otp" default="">
    <cfparam name="form.newPassword" default="">
    <cfparam name="form.confirmPassword" default="">
    <cfset session.emailConfirmed = structKeyExists(session, "emailConfirmed") AND session.emailConfirmed EQ true>

    <!-- STEP 1: Username Input -->
    <cfif NOT structKeyExists(form, "submit") AND NOT structKeyExists(form, "submitEmail") AND NOT structKeyExists(form, "verifyOtp") AND NOT structKeyExists(form, "reset")>
        <form method="post">
            <label>Enter your Username*</label><br>
            <input type="text" name="username" required><br><br>
            <input type="submit" name="submit" value="Submit">
        </form>
       <div class="button-container">
    <a href="../login.cfm" class="back-btn">Go back</a>
</div>

    <!-- STEP 2: Submit Username -->
    <cfelseif structKeyExists(form, "submit")>
        <cfquery name="getUser" datasource="#application.datasource#">
            SELECT username, email FROM users WHERE username = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">
        </cfquery>

        <cfif getUser.recordCount EQ 0>
            <p class="error-msg">Username doesn't exist.</p>
        <cfelse>
            <cfset session.username = form.username>
            <cfif len(trim(getUser.email)) EQ 0>
                <!-- No email exists, ask to provide -->
                <form method="post">
                    <label>Email not found. Please enter your email*</label><br>
                    <input type="email" name="email" required><br><br>
                    <input type="submit" name="submitEmail" value="Send OTP">
                </form>
            <cfelse>
                <cfset session.email = getUser.email>
                <cfset session.otp = randRange(111111, 999999)>
                <cfmail to="#session.email#" from="kottunarasimha22@gmail.com" subject="Reset Password OTP" type="html">
                    <p>Your OTP is: <strong>#session.otp#</strong></p>
                </cfmail>
                <p class="success-msg">OTP sent to your registered email.</p>

                <form method="post">
                    <label>Enter OTP*</label><br>
                    <input type="text" name="otp" required><br><br>
                    <input type="submit" name="verifyOtp" value="Verify OTP">
                </form>
            </cfif>
        </cfif>

    <!-- STEP 2B: User provides email -->
    <cfelseif structKeyExists(form, "submitEmail")>
        <cfset session.email = form.email>
        <cfset session.otp = randRange(111111, 999999)>
        <cfmail to="#session.email#" from="kottunarasimha22@gmail.com" subject="Verify Your Email" type="html">
            <p>Your OTP is: <strong>#session.otp#</strong></p>
        </cfmail>
        <p class="success-msg">OTP sent to your provided email address.</p>

        <form method="post">
            <label>Enter OTP*</label><br>
            <input type="text" name="otp" required><br><br>
            <input type="submit" name="verifyOtp" value="Verify OTP">
        </form>

    <!-- STEP 3: Verify OTP -->
    <cfelseif structKeyExists(form, "verifyOtp")>
        <cfif form.otp EQ session.otp>
            <!-- Save email to DB if it was newly given -->
            <cfif NOT session.emailConfirmed>
                <cfquery datasource="#application.datasource#">
                    UPDATE users
                    SET email = <cfqueryparam value="#session.email#" cfsqltype="cf_sql_varchar">
                    WHERE username = <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">
                </cfquery>
                <cfset session.emailConfirmed = true>
            </cfif>

            <!-- Show Reset Password Form -->
            <form method="post">
                <label>New Password*</label><br>
                <input type="password" name="newPassword" required><br><br>
                <label>Confirm Password*</label><br>
                <input type="password" name="confirmPassword" required><br><br>
                <input type="submit" name="reset" value="Reset Password">
            </form>
        <cfelse>
            <p class="error-msg">Incorrect OTP. Please try again.</p>
            <form method="post">
                <label>Enter OTP*</label><br>
                <input type="text" name="otp" required><br><br>
                <input type="submit" name="verifyOtp" value="Verify OTP">
            </form>
        </cfif>

    <!-- STEP 4: Reset Password -->
    <cfelseif structKeyExists(form, "reset")>
        <cfset hasSpecialChar = reFind("[@##\$%&*!?]", form.newPassword)>
        <cfset hasCapital     = reFind("[A-Z]", form.newPassword)>
        <cfset hasSmall       = reFind("[a-z]", form.newPassword)>
        <cfset hasNumbers     = reFind("[0-9]", form.newPassword)>
        <cfset islen          = len(trim(form.newPassword)) GTE 8>

        <cfif form.newPassword NEQ form.confirmPassword>
            <p class="error-msg">Passwords do not match.</p>
            <form method="post">
                <label>New Password*</label><br>
                <input type="password" name="newPassword" required><br><br>
                <label>Confirm Password*</label><br>
                <input type="password" name="confirmPassword" required><br><br>
                <input type="submit" name="reset" value="Reset Password">
            </form>

        <cfelseif NOT (hasSpecialChar GT 0 AND hasCapital GT 0 AND hasSmall GT 0 AND hasNumbers GT 0 AND islen)>
            <p class="error-msg">
                Password must contain at least:<br>
                - One capital letter [A-Z]<br>
                - One small letter [a-z]<br>
                - One number [0-9]<br>
                - One special character [@##\$%&*!?]<br>
                - Minimum 8 characters
            </p>
            <form method="post">
                <label>New Password*</label><br>
                <input type="password" name="newPassword" required><br><br>
                <label>Confirm Password*</label><br>
                <input type="password" name="confirmPassword" required><br><br>
                <input type="submit" name="reset" value="Reset Password">
            </form>

        <cfelse>
            <cfquery datasource="#application.datasource#">
                UPDATE users
                SET password = <cfqueryparam value="#form.newPassword#" cfsqltype="cf_sql_varchar">
                WHERE username = <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">
            </cfquery>

            <p class="success-msg">Password reset successful!</p>
            <a href="../login.cfm">Click here to login</a>
        </cfif>
    </cfif>
</body>
</html>
