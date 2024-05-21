# Use the official Arch Linux base image
FROM archlinux:latest

# Set environment variables to avoid interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Update the system and install necessary packages
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    base-devel \
    git \
    newsboat \
    sqlite

# Create a directory for Newsboat configuration and data
RUN mkdir -p /root/.newsboat /root/.newsboat-data

# Set the working directory
WORKDIR /root

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

