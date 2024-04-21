{ config, pkgs, ... }:

{
# Home Manager needs a bit of information about you and the paths it should
# manage.
	home.username = "mohammedbilalns";
	home.homeDirectory = "/home/mohammedbilalns";

# This value determines the Home Manager release that your configuration is
# compatible with. This helps avoid breakage when a new Home Manager release
# introduces backwards incompatible changes.
#
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
	home.stateVersion = "23.11"; # Please read the comment before changing.

# The home.packages option allows you to install Nix packages into your
# environment.
		home.packages = [
# # Adds the 'hello' command to your environment. It prints a friendly
# # "Hello, world!" when run.
		pkgs.hello

# # It is sometimes useful to fine-tune packages, for example, by applying
# # overrides. You can do that directly here, just don't forget the
# # parentheses. Maybe you want to install Nerd Fonts with a limited number of
# # fonts?
# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

# # You can also create simple shell scripts directly inside your
# # configuration. For example, this adds a command 'my-hello' to your
# # environment:
# (pkgs.writeShellScriptBin "my-hello" ''
#   echo "Hello, ${config.home.username}!"
# '')
		];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
	home.file = {
# # Building this configuration will create a copy of 'dotfiles/screenrc' in
# # the Nix store. Activating the configuration will then make '~/.screenrc' a
# # symlink to the Nix store copy.
# ".screenrc".source = dotfiles/screenrc;

# # You can also set the file content immediately.
# ".gradle/gradle.properties".text = ''
#   org.gradle.console=verbose
#   org.gradle.daemon.idletimeout=3600000
# '';
	};

# Home Manager can also manage your environment variables through
# 'home.sessionVariables'. If you don't want to manage your shell through Home
# Manager then you have to manually source 'hm-session-vars.sh' located at
# either
#
#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
#
# or
#
#  /etc/profiles/per-user/mohammedbilalns/etc/profile.d/hm-session-vars.sh
#
	home.sessionVariables = {
# EDITOR = "emacs";
	};
# ZSH Config  
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		enableAutosuggestions = true;
		syntaxHighlighting.enable = true;

		oh-my-zsh = {
			enable = true;
			plugins = [ "git" ];
			theme = "robbyrussell";
		};

		shellAliases = {
			ll = "ls -l";
			update = "sudo nixos-rebuild switch";
			updatehome = "home-manager switch";
			editsys = "sudo nvim /etc/nixos/configuration.nix";
			edithome = "nvim ~/.config/home-manager/home.nix";
		};

	};
# Atuin 
	programs.atuin = {
		enable = true;
		enableZshIntegration = true;
		settings = {
		};
	};
#neofetch 
	home.file.".config/neofetch/config.conf".source = ./neofetch.conf;
#mpv 
	programs.mpv = {
		enable  = true;
		config = {
			hwdec = "auto";
			volume = "40";
			save-position-on-quit = "yes";
		};
		bindings = {
			UP = "add volume 5";
			DOWN = "add volume -5";

		};
		scripts = [
			pkgs.mpvScripts.sponsorblock
				pkgs.mpvScripts.autoload
		];

	};
#wofi 
	programs.wofi = {
		enable = true;
		settings = {
			width = 600;
			height = 300;
			location = "center";
			show = "drun";
			prompt = "Search...";
			filter_rate= 100;
			allow_markup = true;
			no_actions = true;
			halign = "fill";
			orientation = "vertical";
			content_halign = "fill";
			insensitive = true;
			allow_images = true;
			image_size = 40;
			gtk_dark = true;
			dynamic_lines  = true;

		};
		style = " window {
margin: 0px;
border: 5px solid #000000;
	background-color: #000000;
	border-radius: 15px;
		}

#input {
padding: 4px;
margin: 4px;
	padding-left: 20px;
border: none;
color: #cdd6f4;
       font-weight: bold;
       background-color: #111111;
outline: none;
	 border-radius: 15px;
margin: 10px;
	margin-bottom: 2px;
}
#input:focus {
border: 0px solid #1e1e2e;
	margin-bottom: 0px;


#inner-box {
margin: 4px;
border: 10px solid #1e1e2e;
color: #cdd6f4;
       font-weight: bold;
       background-color: #1e1e2e;
       border-radius: 15px;
}

#outer-box {
margin: 0px;
border: none;
	border-radius: 15px;
	background-color: #1e1e2e;
}

#scroll {
	margin-top: 5px;
border: none;
	border-radius: 15px;
	margin-bottom: 5px;
	/* background: rgb(255,255,255); */
}

#img:selected {
	background-color: #89b4fa;
	border-radius: 15px;
}

#text:selected {
color: #cdd6f4;
margin: 0px 0px;
border: none;
	border-radius: 15px;
	background-color: #89b4fa;
}

#entry {
margin: 0px 0px;
border: none;
	border-radius: 15px;
	background-color: transparent;
}

#entry:selected {
margin: 0px 0px;
border: none;
	border-radius: 15px;
	background-color: #89b4fa;
}";

};


# Let Home Manager install and manage itself.
programs.home-manager.enable = true;
}
