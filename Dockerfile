# Use the official Arch Linux base image
FROM archlinux:latest

# Set environment variables to avoid interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# Update the system and install necessary packages
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm --needed git base-devel go fish jq yt-dlp perl

# Create a non-root user
RUN useradd -m builduser && echo "builduser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to the non-root user
USER builduser
WORKDIR /home/builduser

RUN git clone https://aur.archlinux.org/yay.git
WORKDIR yay
RUN makepkg -si --noconfirm
RUN yay -S --noconfirm pod2man
RUN yay -S --noconfirm zpaq

# Switch back to root user
USER root

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
