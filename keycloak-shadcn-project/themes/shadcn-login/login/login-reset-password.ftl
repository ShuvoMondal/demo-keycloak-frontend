<#import "template.ftl" as layout>
<@layout.mainLayout>
<div class="container">
  <div class="login-panel-content">
    <div class="card">
      <div class="card-header">
        <h1 class="card-title">${msg("emailForgotTitle")}</h1>
        <p class="card-description">${msg("emailInstruction")}</p>
      </div>
      <form id="kc-reset-password-form" action="${url.loginAction}" method="post">
        <div class="form-group">
          <label for="username" class="label">${msg("usernameOrEmail")}</label>
          <input type="text" id="username" name="username" class="input" autofocus />
        </div>
        <div class="form-group" style="margin-top: 2rem;">
          <input class="button button-primary" type="submit" value="${msg("doSubmit")}" />
        </div>
      </form>
      <div class="links-container">
        <a class="back-to-login" href="${url.loginUrl}">${msg("backToLogin")}</a>
      </div>
    </div>
  </div>
</div>
</@layout.mainLayout>
