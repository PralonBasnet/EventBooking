// app.js — shared JS helpers (lecture slide 102)

function toggleDropdown(btn) {
  btn.nextElementSibling.classList.toggle('open');
}

function confirmDelete(msg) {
  return confirm(msg || 'Are you sure?');
}

function autoSubmit(input) {
  input.form.submit();
}

// close any open dropdown when clicking outside
document.addEventListener('click', function(e) {
  if (!e.target.closest('.profile-dropdown')) {
    document.querySelectorAll('.dropdown-card.open').forEach(function(d) {
      d.classList.remove('open');
    });
  }
});
