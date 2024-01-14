// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery3
 //= require popper
 //= require bootstrap-sprockets

import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("click", ({target}) => {
  if (target.matches("#toggle-password-icon")) {
    const userPass = document.getElementById("user_password");
    const flg = userPass.type === "password";
    userPass.type = flg ? "text" : "password";
    target.classList.toggle("fa-eye", flg);
    target.classList.toggle("fa-eye-slash", !flg);
    if (document.getElementById("user_password_confirmation")) {
      const userPassConfirm = document.getElementById("user_password_confirmation");
      const flg_2 = userPassConfirm.type === "password";
      userPassConfirm.type = flg_2 ? "text" : "password";
      target.classList.toggle("fa-eye", flg_2);
      target.classList.toggle("fa-eye-slash", !flg_2);
    }
    if (document.getElementById("user_current_password")) {
      const userPassCurrent = document.getElementById("user_current_password");
      const flg_3 = userPassCurrent.type === "password";
      userPassCurrent.type = flg_3 ? "text" : "password";
      target.classList.toggle("fa-eye", flg_3);
      target.classList.toggle("fa-eye-slash", !flg_3);
    }
  }
});

document.addEventListener("change", ({target}) => {
  if (target.type === "checkbox") {
    const maxCheckedCount = 3;
    const checkedCheckBoxes = document.querySelectorAll("input[type=checkbox]:checked");
    const uncheckedCheckBoxes = document.querySelectorAll("input[type=checkbox]:not(:checked)");
    uncheckedCheckBoxes.forEach(checkbox => {
      checkbox.disabled = checkedCheckBoxes.length >= maxCheckedCount;
    });
  }
  if (target.matches("#category-select")) {
    const selectedCategoryId = target.value;
    const ingredientsContainers = document.querySelectorAll("#ingredients-container");
    ingredientsContainers.forEach(container => {
      container.style.display = selectedCategoryId == "" || container.dataset.category == selectedCategoryId ? "block" : "none";
    })
  }
});

document.addEventListener("turbo:load", () => {
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
  const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
});
