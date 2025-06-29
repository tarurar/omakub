# Install default programming languages
if [[ -v OMAKUB_FIRST_RUN_LANGUAGES ]]; then
  languages=$OMAKUB_FIRST_RUN_LANGUAGES
else
  AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java" ".NET")
  languages=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --height 10 --header "Select programming languages")
fi

if [[ -n "$languages" ]]; then
  for language in $languages; do
    case $language in
    Ruby)
      mise use --global ruby@latest
      mise settings add idiomatic_version_file_enable_tools ruby
      mise x ruby -- gem install rails --no-document
      ;;
    Node.js)
      mise use --global node@lts
      ;;
    Go)
      mise use --global go@latest
      ;;
    PHP)
      sudo add-apt-repository -y ppa:ondrej/php
      sudo apt -y install php8.4 php8.4-{curl,apcu,intl,mbstring,opcache,pgsql,mysql,sqlite3,redis,xml,zip}
      php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
      php composer-setup.php --quiet && sudo mv composer.phar /usr/local/bin/composer
      rm composer-setup.php
      ;;
    Python)
      mise use --global python@latest
      ;;
    Elixir)
      mise use --global erlang@latest
      mise use --global elixir@latest
      mise x elixir -- mix local.hex --force
      ;;
    Rust)
      bash -c "$(curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs)" -- -y
      ;;
    Java)
      mise use --global java@latest
      ;;
    .NET)
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
      ;;
    esac
  done
fi
