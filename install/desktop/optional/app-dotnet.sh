# Install .NET SDK for cross-platform development. See https://dotnet.microsoft.com/
cd /tmp
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel LTS
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$PATH:$HOME/.dotnet:$HOME/.dotnet/tools"

# Add .NET to shell profiles
echo 'export DOTNET_ROOT="$HOME/.dotnet"' >> ~/.bashrc
echo 'export PATH="$PATH:$HOME/.dotnet:$HOME/.dotnet/tools"' >> ~/.bashrc

if [ -f ~/.zshrc ]; then
    echo 'export DOTNET_ROOT="$HOME/.dotnet"' >> ~/.zshrc
    echo 'export PATH="$PATH:$HOME/.dotnet:$HOME/.dotnet/tools"' >> ~/.zshrc
fi

cd -