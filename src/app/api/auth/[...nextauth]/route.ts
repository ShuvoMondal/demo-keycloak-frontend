import NextAuth from "next-auth";
import KeycloakProvider from "next-auth/providers/keycloak";

const handler = NextAuth({
  providers: [
    KeycloakProvider({
      clientId: process.env.KEYCLOAK_CLIENT_ID!,
      clientSecret: process.env.KEYCLOAK_CLIENT_SECRET!,
      issuer: process.env.KEYCLOAK_ISSUER!,
      authorization: {
        params: {
          prompt: "login",
          scope: "openid profile email"
        }
      }
    })
  ],
  callbacks: {
    async jwt({ token, account, trigger }) {
      if (account) {
        token.accessToken = account.access_token;
        token.idToken = account.id_token;
        token.refreshToken = account.refresh_token;
      }
      
      // Clear token on signout
      if (trigger === "signOut") {
        token = {};
      }
      
      return token;
    },
    async session({ session, token }) {
      session.accessToken = token.accessToken;
      session.idToken = token.idToken;
      return session;
    },
    async redirect({ url, baseUrl }) {
      // Always redirect to dashboard after successful sign in
      if (url.startsWith("/")) return `${baseUrl}${url}`;
      else if (new URL(url).origin === baseUrl) return url;
      return `${baseUrl}/dashboard`;
    },
  },
  events: {
    async signOut({ token }) {
      // Logout from Keycloak
      if (token?.idToken) {
        try {
          const issuerUrl = process.env.KEYCLOAK_ISSUER!;
          const logoutUrl = new URL(`${issuerUrl}/protocol/openid-connect/logout`);
          logoutUrl.searchParams.set("id_token_hint", token.idToken as string);
          await fetch(logoutUrl.href, { method: "GET" });
        } catch (error) {
          console.error("Error during Keycloak logout:", error);
        }
      }
    },
  },
  session: {
    strategy: "jwt",
    maxAge: 24 * 60 * 60, // 24 hours
  },
});

export { handler as GET, handler as POST };
