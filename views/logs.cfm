<div class="container">
  <h2>Activity Logs</h2>
  <table id="logTable">
    <thead>
      <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Action</th>
        <th>Request ID</th>
        <th>Timestamp</th>
        <th>Details</th>
      </tr>
    </thead>
    <tbody>
      <cfoutput query="data">
        <tr>
          <td>#id#</td>
          <td>#username#</td>
          <td>#action#</td>
          <td>#request_id#</td>
          <td>#timestamp#</td>
          <td>#details#</td>
        </tr>
      </cfoutput>
    </tbody>
  </table>

  <div id="pagination" class="pagination"></div>

  <div class="home-btn">
    <a class="home-link" href="index.cfm">Back to Home</a>
  </div>
</div>
<link rel="stylesheet" href="css/logs.css">
<script src="js/logs.js"></script>


