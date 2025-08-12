<#-- 
  ==============================================================================
  FINAL, CORRECTED REGISTER.FTL
  This version re-enables the Username field and adds field-level error
  highlighting for a professional user experience.
  ==============================================================================
-->
<#import "template.ftl" as layout>
<@layout.mainLayout>
<div class="container">
  <div class="login-panel-content">
    <div class="card">
      <div class="card-header">
        <h1 class="card-title">${msg("registerTitle")}</h1>
        <p class="card-description">${msg("registerTitleHtml")}</p>
      </div>

      <#-- This is the main summary error box -->
      <#if message?has_content>
        <div class="alert alert-${message.type}"><span>${kcSanitize(message.summary)?no_esc}</span></div>
      </#if>

      <form id="kc-register-form" action="${url.registrationAction}" method="post">
        
        <#-- First Name -->
        <div class="form-group">
          <label for="firstName" class="label">${msg("firstName")}</label>
          <input type="text" id="firstName" class="input <#if messagesPerField.existsError('firstName')>input-error</#if>" name="firstName" value="${(register.formData.firstName!'')}" />
        </div>

        <#-- Last Name -->
        <div class="form-group">
          <label for="lastName" class="label">${msg("lastName")}</label>
          <input type="text" id="lastName" class="input <#if messagesPerField.existsError('lastName')>input-error</#if>" name="lastName" value="${(register.formData.lastName!'')}" />
        </div>

        <#-- Username - UNCOMMENTED AND FIXED -->
        <div class="form-group">
            <label for="username" class="label">${msg("username")}</label>
            <input type="text" id="username" class="input <#if messagesPerField.existsError('username')>input-error</#if>" name="username" value="${(register.formData.username!'')}" autocomplete="username" />
        </div>

        <#-- Email -->
        <div class="form-group">
          <label for="email" class="label">${msg("email")}</label>
          <input type="email" id="email" class="input <#if messagesPerField.existsError('email')>input-error</#if>" name="email" value="${(register.formData.email!'')}" autocomplete="email" />
        </div>
        
        <#-- Password Fields -->
        <#if passwordRequired??>
          <div class="form-group">
            <label for="password" class="label">${msg("password")}</label>
            <div class="password-wrapper">
              <input type="password" id="password" class="input <#if messagesPerField.existsError('password','password-confirm')>input-error</#if>" name="password" autocomplete="new-password" />
              <button type="button" class="password-toggle" aria-label="Toggle password visibility">
                <svg class="eye-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor"><path d="M10 12.5a2.5 2.5 0 100-5 2.5 2.5 0 000 5z" /><path fill-rule="evenodd" d="M.664 10.59a1.651 1.651 0 010-1.186A10.004 10.004 0 0110 3c4.257 0 7.893 2.66 9.336 6.41.147.381.146.804 0 1.186A10.004 10.004 0 0110 17c-4.257 0-7.893-2.66-9.336-6.41zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd" /></svg>
                <svg class="eye-off-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" style="display: none;"><path fill-rule="evenodd" d="M3.28 2.22a.75.75 0 00-1.06 1.06l14.5 14.5a.75.75 0 101.06-1.06l-1.745-1.745a10.029 10.029 0 003.3-4.38c.148-.381.148-.804 0-1.186A10.004 10.004 0 0010 3c-.996 0-1.95.15-2.86.433l-1.544-1.544A10.035 10.035 0 0010 1.5a.75.75 0 000 1.5c.355 0 .703.033 1.044.095l-1.35-1.35A9.954 9.954 0 003.28 2.22zM7.879 9.879a2.5 2.5 0 003.242 3.242l-3.242-3.242zM10.933 7.067a4.002 4.002 0 00-4.866 4.866l4.866-4.866zM2.087 7.913a10.01 10.01 0 00-1.423 2.087.75.75 0 000 1.186A10.004 10.004 0 0010 17c.996 0 1.95-.15-2.86-.433l1.544 1.544a10.035 10.035 0 001.35 1.35.75.75 0 001.06-1.06l-14.5-14.5z" clip-rule="evenodd" /></svg>
              </button>
            </div>
          </div>
          <div class="form-group">
            <label for="password-confirm" class="label">${msg("passwordConfirm")}</label>
            <div class="password-wrapper">
              <input type="password" id="password-confirm" class="input <#if messagesPerField.existsError('password-confirm')>input-error</#if>" name="password-confirm" autocomplete="new-password" />
              <button type="button" class="password-toggle" aria-label="Toggle password visibility">
                <svg class="eye-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor"><path d="M10 12.5a2.5 2.5 0 100-5 2.5 2.5 0 000 5z" /><path fill-rule="evenodd" d="M.664 10.59a1.651 1.651 0 010-1.186A10.004 10.004 0 0110 3c4.257 0 7.893 2.66 9.336 6.41.147.381.146.804 0 1.186A10.004 10.004 0 0110 17c-4.257 0-7.893-2.66-9.336-6.41zM14 10a4 4 0 11-8 0 4 4 0 018 0z" clip-rule="evenodd" /></svg>
                <svg class="eye-off-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" style="display: none;"><path fill-rule="evenodd" d="M3.28 2.22a.75.75 0 00-1.06 1.06l14.5 14.5a.75.75 0 101.06-1.06l-1.745-1.745a10.029 10.029 0 003.3-4.38c.148-.381.148-.804 0-1.186A10.004 10.004 0 0010 3c-.996 0-1.95.15-2.86.433l-1.544-1.544A10.035 10.035 0 0010 1.5a.75.75 0 000 1.5c.355 0 .703.033 1.044.095l-1.35-1.35A9.954 9.954 0 003.28 2.22zM7.879 9.879a2.5 2.5 0 003.242 3.242l-3.242-3.242zM10.933 7.067a4.002 4.002 0 00-4.866 4.866l4.866-4.866zM2.087 7.913a10.01 10.01 0 00-1.423 2.087.75.75 0 000 1.186A10.004 10.004 0 0010 17c.996 0 1.95-.15-2.86-.433l1.544 1.544a10.035 10.035 0 001.35 1.35.75.75 0 001.06-1.06l-14.5-14.5z" clip-rule="evenodd" /></svg>
              </button>
            </div>
          </div>
        </#if>        
        <div class="form-group" style="margin-top: 2rem;">
            <input class="button button-primary" type="submit" value="${msg("doRegister")}" />
        </div>
      </form>
      
      <div class="links-container">
        <a class="back-to-login" href="${url.loginUrl}">${msg("backToLogin")}</a>
      </div>
    </div>
  </div>
</div>
</@layout.mainLayout>
