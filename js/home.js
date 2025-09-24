// home.js
document.addEventListener("DOMContentLoaded", function () {
  const toggleBtn = document.getElementById("toggleBtn");
  const sidebar = document.getElementById("menu");

  toggleBtn.addEventListener("click", function () {
    sidebar.classList.toggle("visible");
  });
});

  document.getElementById("submitRequestLink").addEventListener("click", function(event) {
    const checkbox = document.getElementById("openInNewTab");
    const url = this.getAttribute("href");

    if (checkbox.checked) {
      event.preventDefault();
      window.open(url, "_blank");
    }
  });

