<div class="container">
    <h2>Registered Users</h2>

    <cfif data.recordcount EQ 0>
        <cfoutput>No Users are Registered</cfoutput>
    <cfelse>
        <table id="userTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query="data">
                    <tr>
                        <td>#id#</td>
                        <td>#username#</td>
                        <td>
                            <cfif username EQ "admin">
                                Admin
                            <cfelse>
                                General User
                            </cfif>
                        </td>
                    </tr>
                </cfoutput>
            </tbody>
        </table>

        <!-- Placeholder for pagination -->
        <div class="pagination" id="pagination"></div>
    </cfif>

    <div class="home-btn">
        <a href="index.cfm" class="home-link">Back to Home</a>
    </div>
</div>
<link rel="stylesheet" href="css/user.css">
<!-- Include jQuery and custom JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="js/user.js"></script>

