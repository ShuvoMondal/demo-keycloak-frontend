<#-- 
  ==============================================================================
  NEW: IDP REVIEW USER PROFILE PAGE
  This template is shown to users after their first SSO login.
  It allows them to review their profile details before account creation.
  ==============================================================================
-->
<#import "template.ftl" as layout>
<@layout.mainLayout>
<div class="container">
  <div class="login-panel-content">
    <div class="card">
      <div class="card-header">
        <h1 class="card-title">${msg("reviewProfileTitle")}</h1>
        <p class="card-description">${msg("reviewProfileMessage")}</p>
      </div>

      <#if message?has_content>
        <div class="alert alert-${message.type}"><span>${kcSanitize(message.summary)?no_esc}</span></div>
      </#if>

      <form id="kc-review-profile-form" action="${url.loginAction}" method="post">
        
        <#-- Keycloak requires this hidden field to maintain state -->
        <input type="hidden" name="stateChecker" value="${stateChecker}" />

        <#if user.firstName?has_content>
          <div class="form-group">
            <label for="firstName" class="label">${msg("firstName")}</label>
            <input type="text" id="firstName" class="input" name="firstName" value="${(user.firstName!'')}" />
          </div>
        </#if>

        <#if user.lastName?has_content>
          <div class="form-group">
            <label for="lastName" class="label">${msg("lastName")}</label>
            <input type="text" id="lastName" class="input" name="lastName" value="${(user.lastName!'')}" />
          </div>
        </#if>

        <div class="form-group">
          <label for="email" class="label">${msg("email")}</label>
          <input type="email" id="email" class="input" name="email" value="${(user.email!'')}" />
        </div>
        
        <div class="form-group" style="margin-top: 2rem;">
          <input class="button button-primary" type="submit" value="${msg("doSubmit")}" />
        </div>
      </form>
    </div>
  </div>
</div>
</@layout.mainLayout>
