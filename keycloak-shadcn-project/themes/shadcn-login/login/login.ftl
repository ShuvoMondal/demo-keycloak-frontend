<#import "template.ftl" as layout>
<@layout.mainLayout>
<div class="container">
  <div class="login-panel-content">
    <div class="card">
      <div class="card-header">
        <h1 class="card-title">${msg("signInTitle")}</h1>
        <p class="card-description">${msg("loginWelcomeMessage")}</p>
      </div>

      <#if message?has_content && message.type = 'error'>
        <div class="alert alert-error"><span>${kcSanitize(message.summary)?no_esc}</span></div>
      </#if>

      <form id="kc-form-login" action="${url.loginAction}" method="post">
        <div class="form-group">
          <label for="username" class="label">${msg("usernameOrEmail")}</label>
          <input id="username" class="input <#if message?has_content && message.type = 'error'>input-error</#if>" name="username" value="${(login.username!'')}" type="text" autofocus />
        </div>
        <div class="form-group">
          <label for="password" class="label">${msg("password")}</label>
          <div class="password-wrapper">
            <input id="password" class="input <#if message?has_content && message.type = 'error'>input-error</#if>" name="password" type="password" />
            <button type="button" class="password-toggle" aria-label="Toggle password visibility">
              <svg class="eye-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor"><path d="M10 12.5a2.5 2.5 0 100-5 2.5 2.5 0 000 5z" /><path fill-rule="evenodd" d="M.664 10.59a1.651 1.651 0 010-1.186A10.004 10.004 0 0110 3c4.257 0 7.893 2.66 9.336 6.41.147.381.146.804 0 1.186A10.004 10.004 0 0110 17c-4.257 0-7.893-2.66-9.336-6.41zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd" /></svg>
              <svg class="eye-off-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" style="display: none;"><path fill-rule="evenodd" d="M3.28 2.22a.75.75 0 00-1.06 1.06l14.5 14.5a.75.75 0 101.06-1.06l-1.745-1.745a10.029 10.029 0 003.3-4.38c.148-.381.148-.804 0-1.186A10.004 10.004 0 0010 3c-.996 0-1.95.15-2.86.433l-1.544-1.544A10.035 10.035 0 0010 1.5a.75.75 0 000 1.5c.355 0 .703.033 1.044.095l-1.35-1.35A9.954 9.954 0 003.28 2.22zM7.879 9.879a2.5 2.5 0 003.242 3.242l-3.242-3.242zM10.933 7.067a4.002 4.002 0 00-4.866 4.866l4.866-4.866zM2.087 7.913a10.01 10.01 0 00-1.423 2.087.75.75 0 000 1.186A10.004 10.004 0 0010 17c.996 0 1.95-.15-2.86-.433l1.544 1.544a10.035 10.035 0 001.35 1.35.75.75 0 001.06-1.06l-14.5-14.5z" clip-rule="evenodd" /></svg>
            </button>
          </div>
        </div>        
        <div class="form-group" style="margin-top: 2rem;">
          <input class="button button-primary" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
        </div>
      </form>

      <!-- SSO / SOCIAL PROVIDERS SECTION -->
      <#if realm.password && social.providers?has_content>
        <div class="sso-divider"><span>${msg("identity-provider-login-label", "Or sign in with")}</span></div>
        <div class="sso-buttons">
          <#list social.providers as p>
            <a href="${p.loginUrl}" class="button button-sso" type="button">
              <#-- This block dynamically inserts the correct icon based on the provider's alias -->
              <#if p.alias == 'google'>
                <svg class="sso-icon" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21.45 10.23c.12.72.18 1.45.18 2.17 0 5.62-4.5 10.1-10.12 10.1-5.61 0-10.1-4.48-10.1-10.1S5.91 2.38 11.52 2.38c3.16 0 5.54 1.25 7.12 2.7l-2.33 2.2c-1.12-1.05-2.6-1.78-4.79-1.78-3.78 0-6.85 3.08-6.85 6.85s3.07 6.85 6.85 6.85c4.4 0 6.22-3.23 6.46-4.85h-6.46v-3.3h10.33z"/></svg>
              <#elseif p.alias == 'github'>
                <svg class="sso-icon" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 19c-4.3 1.4-4.3-2.5-6-3m12 5v-3.5c0-1 .1-1.4-.5-2 2.8-.3 5.5-1.4 5.5-6.2 0-1.4-.5-2.5-1.3-3.4.1-.3.5-1.6 0-3.2 0 0-1.1-.3-3.5 1.3a12.3 12.3 0 0 0-6.2 0C6.5 2.8 5.4 3.1 5.4 3.1c-.5 1.6-.1 2.9 0 3.2-.8.9-1.3 2-1.3 3.4 0 4.8 2.7 5.9 5.5 6.2-.6.5-.9 1.3-.9 2.5v3.5"/></svg>
              <#-- Add other providers like 'facebook', 'microsoft', etc. here -->
              <#else>
                <span class="sso-icon-default"></span>
              </#if>
              <span>${p.displayName}</span>
            </a>
          </#list>
        </div>
      </#if>

      <div class="links-container">
        <#if realm.registrationAllowed>
          <p>${msg("noAccount")} <a href="${url.registrationUrl}">${msg("doRegister")}</a></p>
        </#if>
        <#if realm.resetPasswordAllowed>
          <a class="back-to-login" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
        </#if>
      </div>
    </div>
  </div>
</div>
</@layout.mainLayout>
