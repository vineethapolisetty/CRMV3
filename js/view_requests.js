document.addEventListener("DOMContentLoaded", function () {
  const rowsPerPage = 5;
  const table = document.getElementById("viewRequestsTable");
  const rows = table.querySelectorAll("tbody tr");
  const totalRows = rows.length;
  const totalPages = Math.ceil(totalRows / rowsPerPage);
  const pagination = document.getElementById("pagination");

  function showPage(page) {
    const start = (page - 1) * rowsPerPage;
    const end = start + rowsPerPage;

    rows.forEach((row, index) => {
      row.style.display = (index >= start && index < end) ? "" : "none";
    });

    renderPagination(page);
  }

  function renderPagination(currentPage) {
    pagination.innerHTML = "";

    if (currentPage > 1) {
      const prev = document.createElement("a");
      prev.href = "#";
      prev.textContent = "Prev";
      prev.className = "pagi-pn";
      prev.addEventListener("click", () => showPage(currentPage - 1));
      pagination.appendChild(prev);
    }

    for (let i = 1; i <= totalPages; i++) {
      const pageLink = document.createElement("a");
      pageLink.href = "#";
      pageLink.textContent = i;
      pageLink.className = (i === currentPage) ? "active-page" : "";
      pageLink.addEventListener("click", () => showPage(i));
      pagination.appendChild(pageLink);
    }

    if (currentPage < totalPages) {
      const next = document.createElement("a");
      next.href = "#";
      next.textContent = "Next";
      next.className = "pagi-pn";
      next.addEventListener("click", () => showPage(currentPage + 1));
      pagination.appendChild(next);
    }
  }

  // Initial page display
  showPage(1);
});
