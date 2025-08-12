// Wait for the DOM to be fully loaded before running the script
document.addEventListener("DOMContentLoaded", () => {
  // Find all password toggle buttons on the page
  const passwordToggles = document.querySelectorAll(".password-toggle");

  passwordToggles.forEach((toggle) => {
    toggle.addEventListener("click", () => {
      // Find the parent wrapper of the button that was clicked
      const passwordWrapper = toggle.parentElement;

      // Find the input field ONLY within that specific wrapper
      const passwordInput = passwordWrapper.querySelector(".input");

      // Find the icons ONLY within the button that was clicked
      const eyeIcon = toggle.querySelector(".eye-icon");
      const eyeOffIcon = toggle.querySelector(".eye-off-icon");

      // This ensures we only affect the field next to the clicked button
      if (passwordInput && eyeIcon && eyeOffIcon) {
        if (passwordInput.type === "password") {
          // If it's a password, change it to text to show it
          passwordInput.type = "text";
          eyeIcon.style.display = "none";
          eyeOffIcon.style.display = "block";
        } else {
          // If it's text, change it back to password to hide it
          passwordInput.type = "password";
          eyeIcon.style.display = "block";
          eyeOffIcon.style.display = "none";
        }
      }
    });
  });
});
