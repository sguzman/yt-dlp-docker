# Use the official Arch Linux base image
FROM archlinux:latest

# Set environment variables to avoid interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Update the system and install necessary packages
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    base-devel \
    git \
    yt-dlp \
    sqlite \
    fish \
    zpaq \
    jq

# Create a working directory
WORKDIR /app

# Copy the urls.txt file to the container
COPY urls.txt .

# Copy the script to the container
COPY scrape_and_store.fish .

# Make the script executable
RUN chmod +x scrape_and_store.fish

# Run the script
CMD ["./scrape_and_store.fish"]
