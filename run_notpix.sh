#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Display welcome message
echo -e "${GREEN}============================================================${NC}"
echo -e "${GREEN}           Welcome to the Notpixel-bot Installation           ${NC}"
echo -e "${GREEN}============================================================${NC}"
echo -e "${YELLOW}Auto script installer by: 🚀 AIRDROP SEIZER 💰${NC}"
echo -e "${YELLOW}Join our channel on Telegram: https://t.me/airdrop_automation${NC}"
echo -e "${GREEN}============================================================${NC}"

# Function to install a package if not already installed
install_if_not_installed() {
    pkg_name=$1
    if ! dpkg -s "$pkg_name" >/dev/null 2>&1; then
        echo -e "${BLUE}Installing ${pkg_name}...${NC}"
        pkg install "$pkg_name" -y >/dev/null 2>&1
    else
        echo -e "${GREEN}${pkg_name} is already installed. Skipping...${NC}"
    fi
}

# Function to install necessary packages
install_packages() {
    echo -e "${BLUE}Updating package lists...${NC}"
    pkg update -y >/dev/null 2>&1

    # List of required packages
    packages=("git" "nano" "clang" "cmake" "ninja" "rust" "make" "tur-repo" "python3.10" "libjpeg-turbo" "libpng" "zlib")

    # Loop through the packages and install each if not present
    for pkg in "${packages[@]}"; do
        install_if_not_installed "$pkg"
    done
}

# Check if Notpixel-bot directory exists
if [ ! -d "Notpixel-bot" ]; then
    install_packages

    echo -e "${BLUE}Upgrading pip and installing wheel...${NC}"
    pip3.10 install --upgrade pip wheel --quiet

    echo -e "${BLUE}Cloning Notpixel-bot repository...${NC}"
    git clone https://github.com/vanhbakaa/Notpixel-bot

    echo -e "${BLUE}Navigating to Notpixel-bot directory...${NC}"
    cd Notpixel-bot || exit

    echo -e "${BLUE}Copying .env-example to .env...${NC}"
    cp .env-example .env

    echo -e "${YELLOW}Opening .env file for editing...${NC}"
    nano .env

    # Set up Python virtual environment if it doesn't exist
    if [ ! -d "venv" ]; then
        echo -e "${BLUE}Setting up Python virtual environment...${NC}"
        python3.10 -m venv venv
    fi

    echo -e "${BLUE}Activating Python virtual environment...${NC}"
    source venv/bin/activate

    echo -e "${BLUE}Installing Python dependencies from requirements.txt...${NC}"
    pip install -r requirements.txt --quiet

    echo -e "${BLUE}Installing Pillow...${NC}"
    pip install pillow --quiet

    echo -e "${GREEN}Installation completed! You can now run the bot.${NC}"

else
    echo -e "${GREEN}Notpixel-bot is already installed. Navigating to the directory...${NC}"
    cd Notpixel-bot || exit

    echo -e "${BLUE}Activating Python virtual environment...${NC}"
    source venv/bin/activate
fi

# Ensure the virtual environment is set up
if [ ! -d "venv" ]; then
    echo -e "${BLUE}Setting up Python virtual environment...${NC}"
    python3.10 -m venv venv

    echo -e "${BLUE}Activating Python virtual environment...${NC}"
    source venv/bin/activate

    echo -e "${BLUE}Installing Python dependencies from requirements.txt...${NC}"
    pip install -r requirements.txt --quiet

    echo -e "${BLUE}Installing Pillow...${NC}"
    pip install pillow --quiet
else
    echo -e "${GREEN}Virtual environment already exists. Skipping dependency installation.${NC}"
fi

# Run the bot
echo -e "${GREEN}Running the bot...${NC}"
python3.10 main.py

echo -e "${GREEN}Script execution completed!${NC}"
