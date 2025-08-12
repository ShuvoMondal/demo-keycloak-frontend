<#import "template.ftl" as layout>
<@layout.mainLayout>
<div class="container">
  <div class="login-panel-content">
    <div class="card">
      <div class="card-header">
        <h1 class="card-title">${msg("errorTitle")}</h1>
      </div>
      <div class="alert alert-error">
        <span>${(message.summary!'An unexpected error has occurred.')?no_esc}</span>
      </div>
      <div class="links-container">
        <a class="back-to-login" href="${url.loginUrl}">${msg("backToLogin")}</a>
      </div>
    </div>
  </div>
</div>
</@layout.mainLayout>
