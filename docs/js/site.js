(function () {
  "use strict";

  document.addEventListener("keydown", function (event) {
    if (event.altKey || event.ctrlKey || event.metaKey || event.shiftKey) return;
    if (event.target.matches("input, textarea, select, [contenteditable]")) return;

    var destination;
    if (event.key === "ArrowLeft") destination = document.getElementById("previous-object");
    if (event.key === "ArrowRight") destination = document.getElementById("next-object");

    if (destination) window.location.assign(destination.href);
  });
})();
