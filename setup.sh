#!/bin/bash

function rvm_installation
{
    if [[ -e "$HOME/.rvm/scripts/rvm" ]];
    then
        [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
    fi
    # TODO: Also check for root-installation of rvm!!!
    echo "Checking for rvm installation..."
    RVM_TYPE_OUTPUT=$( (type rvm | head -1) 2>&1 )

    if [[ $RVM_TYPE_OUTPUT = "rvm is a function" ]];
    then
        echo "rvm is already installed."
    else
        echo "rvm is not installed. Installing stable..."
        \curl -sSL https://get.rvm.io | bash -s stable
    fi
    export PATH="$PATH:$HOME/.rvm/bin"
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
}

function ruby_installation
{
    echo "Checking for rvm ruby installation..."
    REQUIRED_RUBY_VERSION="$(head -n 1 ".ruby-version")"
    INSTALLED_RUBY_VERSION=$RUBY_VERSION

    echo "Required: $REQUIRED_RUBY_VERSION"
    echo "Installed: $INSTALLED_RUBY_VERSION"

    if [[ $NO_SUCH_FILE_OR_DIRECTORY = "No such file or directory" ]];
    then
        echo "ruby is not installed."
        echo "Installing $REQUIRED_RUBY_VERSION using rvm..."
        rvm install $REQUIRED_RUBY_VERSION
    elif [[ $INSTALLED_RUBY_VERSION != $REQUIRED_RUBY_VERSION ]];
    then
        echo "Installed ruby version is not $REQUIRED_RUBY_VERSION."
        echo "Installing $REQUIRED_RUBY_VERSION using rvm..."
        rvm install $REQUIRED_RUBY_VERSION
    else
        echo "$REQUIRED_RUBY_VERSION is already installed."
    fi
}

function rvm_use_ruby
{
    RUBYGEMSET="$(head -n 1 ".ruby-version")@$(head -n 1 ".ruby-gemset")"
    echo "Telling rvm to use $RUBYGEMSET for this project..."
    rvm use "$RUBYGEMSET" --create
    source "$HOME/.rvm/scripts/rvm"
}

function bundler_installation
{
    echo "Checking for bundler installation..."
    GEM_SPEC_BUNDLER_OUTPUT=$( (gem spec bundler) 2>&1 )
    GEM_NOT_FOUND=${GEM_SPEC_BUNDLER_OUTPUT::5}
    if [[ $GEM_NOT_FOUND = "ERROR" ]];
    then
        echo "bundler is not installed."
        echo "Installing bundler..."
        gem install bundler
    else
        echo "bundler is already installed."
    fi
}

function install_bundle
{
    echo "Installing Gems..."
    bundle install
}

function install_pods
{
    echo "Installing Pods..."
    pod install
}

function remove_old_git_hooks
{
    if [ -e ".git/hooks/pre-commit" ]
    then
        echo "Removing old pre-commit hook link..."
        sed -i ".bak" "/.\/.pre-commit/d" ".git/hooks/pre-commit"
    fi

    if [ -e ".git/hooks/post-commit" ]
    then
        echo "Removing old post-commit hook link..."
        sed -i ".bak" "/.\/.post-commit/d" ".git/hooks/post-commit"
    fi
}

function install_git_hooks
{
    mkdir -p ".git/hooks/"
    echo "Installing new git hooks..."

    echo "Installing pre-push hook..."
    {
        echo "#!/bin/bash"
        echo ""
        echo "./scripts/pre-push"
    } > ".git/hooks/pre-push"

    chmod +x ".git/hooks/pre-push"

    echo "Installing post-merge hook..."
    {
        echo "#!/bin/bash"
        echo ""
        echo "./scripts/post-merge"
    } > ".git/hooks/post-merge"

    chmod +x ".git/hooks/post-merge"
}

function open_workspace
{
    echo "Opening workspace..."
    open ./TastyTomato.xcworkspace
}


function main
{
    echo "# # # # #"
    rvm_installation
    echo "# # #"
    ruby_installation
    echo "# # #"
    rvm_use_ruby
    echo "# # #"
    bundler_installation
    echo "# # #"
    install_bundle
    echo "# # #"
    install_pods
    echo "# # #"
    remove_old_git_hooks
    echo "# # #"
    install_git_hooks
    echo "# # #"
    open_workspace
    echo "Done. Have fun!"
    echo "# # # # #"
}


main
