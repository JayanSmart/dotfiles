{
	config,
	pkgs, lib, ...
}:
{
	config = {
		users.users.${config.user} = {
			isNormalUser = true;

			extraGroups = [
				"wheel" # sudo privileges
			];
		};

	home-manager.users.${config.user}.xdg = {
		mimeApps.enable = true;

		# desktopEntries.burp = lib.mkIf pkgs.stdenv.isLinux {
		# 	name = "Burp";
		# 	exec = "${config.homePath}/.local/bin/burp.sh";
		# 	catagories = [ "Application" ];
		# };

		userDirs = {
			enable = true;
			createDirectories = true;
			documents = "$HOME/documents";
			download = config.userDirs.download;
			desktop = "$HOME/desktop";
			music = "$HOME/media/music";
			videos = "$HOME/media/videos";
			pictures = "$HOME/media/pictures";
			templates = "$HOME/other/templates";
			extraConfig = {
				XDG_DEV_DIR = "$HOME/git";
			};
		};
	};
};
}
