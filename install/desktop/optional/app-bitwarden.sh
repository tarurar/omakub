# Install Bitwarden password manager. See https://bitwarden.com/
# Try official repository first, fallback to Flatpak if needed

# Official repository method
curl -fsSL https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=deb > /tmp/bitwarden.deb
if [ $? -eq 0 ] && [ -s /tmp/bitwarden.deb ]; then
    sudo apt install -y /tmp/bitwarden.deb
    rm /tmp/bitwarden.deb
else
    echo "Official package not available, installing via Flatpak..."
    # Fallback to Flatpak
    flatpak install -y flathub com.bitwarden.desktop
fi