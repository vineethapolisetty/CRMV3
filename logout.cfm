<cfset structClear(session)>
<cfset sessionInvalidate()>
<cflocation url="login.cfm?error=logout">