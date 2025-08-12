/**
 * Utility functions for authentication and session management
 */

/**
 * Clears all authentication-related cookies and storage
 * This ensures complete session cleanup on logout
 */
export const clearAuthData = () => {
  // Clear NextAuth cookies
  const authCookies = [
    'next-auth.session-token',
    'next-auth.csrf-token',
    'next-auth.callback-url',
    'next-auth.state',
    '__Secure-next-auth.session-token',
    '__Host-next-auth.csrf-token'
  ];

  authCookies.forEach(cookieName => {
    // Clear cookie for current domain
    document.cookie = `${cookieName}=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/;`;
    // Clear cookie for parent domain
    document.cookie = `${cookieName}=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/; domain=${window.location.hostname};`;
    // Clear cookie for subdomain
    document.cookie = `${cookieName}=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/; domain=.${window.location.hostname};`;
  });

  // Clear local storage items
  try {
    localStorage.removeItem('next-auth.session');
    sessionStorage.removeItem('next-auth.session');
  } catch (error) {
    console.warn('Could not clear storage:', error);
  }
};

/**
 * Performs a complete logout including Keycloak session termination
 */
export const performCompleteLogout = async (): Promise<void> => {
  try {
    // Clear all auth data
    clearAuthData();
    
    // Force a hard reload to ensure all state is cleared
    setTimeout(() => {
      window.location.href = '/';
    }, 100);
  } catch (error) {
    console.error('Error during complete logout:', error);
    // Fallback: force redirect
    window.location.href = '/';
  }
};
