# Stage 1: Use the official Keycloak image as a base
FROM quay.io/keycloak/keycloak:latest as builder

# Copy your custom theme into the Keycloak themes directory
COPY ./themes/ /opt/keycloak/themes/

# Build an optimized Keycloak server image with your theme included.
# This is much more efficient than mounting themes in production.
RUN /opt/keycloak/bin/kc.sh build

# Stage 2: Create the final, lean image
FROM quay.io/keycloak/keycloak:latest

# Copy the optimized server from the builder stage
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Set the entrypoint to start Keycloak
# Use 'start-dev' for local development with auto-rebuild on theme changes
# Use 'start' for production
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]
