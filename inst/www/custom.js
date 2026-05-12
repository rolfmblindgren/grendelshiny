window.Shiny = window.Shiny || {};

function grendelshinySetSelectizeOpen(isOpen) {
  if (!document.body) {
    return;
  }

  document.body.classList.toggle("selectize-menu-open", isOpen);

  var button = document.getElementById("beregn");
  if (button) {
    button.style.visibility = isOpen ? "hidden" : "";
    button.style.pointerEvents = isOpen ? "none" : "";
  }
}

function grendelshinyBindSelectizeMenuState() {
  document.querySelectorAll("select.selectized").forEach(function(node) {
    if (node.dataset.grendelSelectizeBound === "1" || !node.selectize) {
      return;
    }

    node.dataset.grendelSelectizeBound = "1";
    node.selectize.on("dropdown_open", function() {
      grendelshinySetSelectizeOpen(true);
    });
    node.selectize.on("dropdown_close", function() {
      var anyOpen = Array.from(document.querySelectorAll(".selectize-dropdown")).some(function(dropdown) {
        return window.getComputedStyle(dropdown).display !== "none";
      });
      grendelshinySetSelectizeOpen(anyOpen);
    });
  });
}

document.addEventListener("DOMContentLoaded", function() {
  grendelshinyBindSelectizeMenuState();
  window.setInterval(grendelshinyBindSelectizeMenuState, 200);
});

document.addEventListener("shiny:connected", grendelshinyBindSelectizeMenuState);
document.addEventListener("shiny:value", grendelshinyBindSelectizeMenuState);
document.addEventListener("click", function(event) {
  if (!event.target.closest(".selectize-control")) {
    grendelshinySetSelectizeOpen(false);
  }
});

grendelshinySetSelectizeOpen(false);
grendelshinyBindSelectizeMenuState();
