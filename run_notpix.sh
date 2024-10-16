#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to install packages
install_packages() {
    echo -e "${BLUE}Updating and upgrading packages...${NC}"
    pkg update && pkg upgrade -y

    echo -e "${GREEN}Installing git and nano...${NC}"
    pkg install git nano -y

    echo -e "${GREEN}Installing development tools: clang, cmake, ninja, rust, make...${NC}"
    pkg install clang cmake ninja rust make -y

    echo -e "${GREEN}Installing tur-repo...${NC}"
    pkg install tur-repo -y

    echo -e "${GREEN}Installing Python 3.10...${NC}"
    pkg install python3.10 -y
}

# Check if Notpixel-bot directory exists
if [ ! -d "Notpixel-bot" ]; then
    # If the directory does not exist, install everything
    install_packages

    # Upgrade pip and install wheel
    echo -e "${BLUE}Upgrading pip and installing wheel...${NC}"
    pip3.10 install --upgrade pip wheel --quiet

    # Clone the MyNotpixel-bot repository
    echo -e "${BLUE}Cloning MyNotpixel-bot repository...${NC}"
    git clone https://github.com/rjfahad/Notpixel-bot.git

    # Change directory to Notpixel-bot
    echo -e "${BLUE}Navigating to Notpixel-bot directory...${NC}"
    cd MyNotpixel-bot || exit

    # Copy .env-example to .env
    echo -e "${BLUE}Copying .env-example to .env...${NC}"
    cp .env-example .env

    # Open .env file for editing
    echo -e "${YELLOW}Opening .env file for editing...${NC}"
    nano .env

    # Set up Python virtual environment
    echo -e "${BLUE}Setting up Python virtual environment...${NC}"
    python3.10 -m venv venv

    # Activate the virtual environment
    echo -e "${BLUE}Activating Python virtual environment...${NC}"
    source venv/bin/activate

    # Install required Python packages
    echo -e "${BLUE}Installing Python dependencies from requirements.txt...${NC}"
    pip3.10 install -r requirements.txt --quiet

    echo -e "${GREEN}Installation completed! You can now run the bot.${NC}"

else
    # If the directory exists, just navigate to it
    echo -e "${GREEN}Notpixel-bot is already installed. Navigating to the directory...${NC}"
    cd Notpixel-bot || exit

    # Activate the virtual environment
    echo -e "${BLUE}Activating Python virtual environment...${NC}"
    source venv/bin/activate
fi

# Check if required Python packages are already installed
if [ ! -f "venv/bin/activate" ]; then
    # If the virtual environment does not exist, set it up
    echo -e "${BLUE}Setting up Python virtual environment...${NC}"
    python3.10 -m venv venv

    # Activate the virtual environment
    echo -e "${BLUE}Activating Python virtual environment...${NC}"
    source venv/bin/activate

    # Install required Python packages
    echo -e "${BLUE}Installing Python dependencies from requirements.txt...${NC}"
    pip3.10 install -r requirements.txt
else
    echo -e "${GREEN}Virtual environment already exists. Skipping dependency installation.${NC}"
fi

# Run the bot
echo -e "${GREEN}Running the bot...${NC}"
python3.10 main.py

echo -e "${GREEN}Script execution completed!${NC}"
