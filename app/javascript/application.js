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
    userPass.type = flg? "text" : "password";
    target.classList.toggle("fa-eye", flg);
    target.classList.toggle("fa-eye-slash", !flg);
    if (document.getElementById("user_password_confirmation")) {
      const userPassConfirm = document.getElementById("user_password_confirmation");
      const flg_2 = userPassConfirm.type === "password";
      userPassConfirm.type = flg_2? "text" : "password";
      target.classList.toggle("fa-eye", flg_2);
      target.classList.toggle("fa-eye-slash", !flg_2);
    }
    if (document.getElementById("user_current_password")) {
      const userPassCurrent = document.getElementById("user_current_password");
      const flg_3 = userPassCurrent.type === "password";
      userPassCurrent.type = flg_3? "text" : "password";
      target.classList.toggle("fa-eye", flg_3);
      target.classList.toggle("fa-eye-slash", !flg_3);
    }
  }
  if (target.matches(".close")) {
    const alertMsg = document.getElementById("flash-message");
    alertMsg.classList.add("fade-out");
    alertMsg.addEventListener("animationend", () => {
      alertMsg.remove();
    });
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
});
