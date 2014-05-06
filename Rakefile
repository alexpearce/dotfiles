# Lifted with love from Ryan Bates
# https://github.com/ryanb/dotfiles/
require "rake"

desc "Install dotfiles."
task :install do
  puts '     _       _    __ _ _           '
  puts '    | |     | |  / _(_) |          '
  puts '  __| | ___ | |_| |_ _| | ___  ___ '
  puts ' / _` |/ _ \| __|  _| | |/ _ \/ __|'
  puts '| (_| | (_) | |_| | | | |  __/\__ \\'
  puts ' \__,_|\___/ \__|_| |_|_|\___||___/'
  puts "\nFirst, I'll install Prezto and switch you to zsh."
  puts "Then I'll symlink all the dotfiles to $HOME."
  puts "You now have a choice:"
  puts "  y - Proceed"
  puts "  q - Exit"
  puts "What would you like to do? [yq]"
  case $stdin.gets.chomp
  when "y"
    puts "Let's go!"
  else
    puts "Exiting, goodbye!"
  end
  install_prezto
  files = Dir['*'] - %w[Rakefile README.md zprezto macros terminfo tmux-start.sh]
  # Add ROOT macros
  files << "macros/newBrowser.C"
  # Add Prezto files
  files << "zprezto/modules/alxprc/init.zsh"
  files << "zprezto/modules/prompt/functions/prompt_alxprc_setup"
  files.each do |file|
    # Create directory, if file should live in one
    system %Q{mkdir -p "$HOME/.#{File.dirname(file)}"} if file =~ /\//
    dotfile = File.join(ENV["HOME"], ".#{file}")
    # Does the file already exist in $HOME?
    if File.exist?(dotfile)
      # If so, is it identical?
      if File.identical? file, dotfile
        puts "Identical file, skipping #{file}"
      else
        # Not identical, so what does the user want to do
        puts "Overwrite '#{dotfile}'? [ynq]"
        case $stdin.gets.chomp
        when "y"
          replace_file(file, dotfile)
        when "q"
          exit
        else
          puts "Skipping #{dotfile}"
        end
      end
    else
      link_file(file, dotfile)
    end
  end
  puts "\nYou should now install Homebrew with"
  puts "  curl -fsSL https://raw.github.com/mxcl/homebrew/go"
end

# Remove destination, link source there
def replace_file(source, destination)
  system %Q{rm -rf "#{destination}"}
  link_file(source, destination)
end

# Symlink source to destination
def link_file(source, destination)
  puts "Linking #{source}"
  system %Q{ln -s "$PWD/#{source}" "#{destination}"}
end

# Hey Prezto!
# https://github.com/sorin-ionescu/prezto
def install_prezto
  puts "Installing Prezto..."
  system %Q{git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"}
  system %Q{chsh -s `which zsh`}
end
