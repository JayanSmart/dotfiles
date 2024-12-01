{
  config,
  pkgs,
  lib,
  ...
}:

{

  options = {
    firefox = {
      enable = lib.mkEnableOption {
        description = "Enable Firefox.";
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gui.enable && config.firefox.enable) {

    unfreePackages = [ "lastpass-password-manager" ];

    home-manager.users.${config.user} = {

      programs.firefox = {
        enable = true;
        package = if pkgs.stdenv.isDarwin then pkgs.firefox-bin else pkgs.firefox;
        profiles.default = {
          id = 0;
          name = "default";
          isDefault = true;
          # https://nur.nix-community.org/repos/rycee/
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            lastpass-password-manager
            # pkgs.bypass-paywalls-clean
            darkreader
            don-t-fuck-with-paste
            facebook-container
            ghostery
            markdownload
            #nordvpn-proxy-extension
            reddit-enhancement-suite
            return-youtube-dislikes
            sponsorblock
            vimium
            web-developer
          ];
          settings = {
            "app.update.auto" = false;
            "browser.bookmarks.addedImportButton" = false;
            "browser.aboutConfig.showWarning" = false;
            "browser.warnOnQuit" = false;
            "browser.quitShortcut.disabled" = if pkgs.stdenv.isLinux then true else false;
            "browser.theme.dark-private-windows" = true;
            "browser.toolbars.bookmarks.visibility" = false;
            "browser.startup.page" = 3; # Restore previous session
            "browser.newtabpage.enabled" = false; # Make new tabs blank
            "trailhead.firstrun.didSeeAboutWelcome" = true; # Disable welcome splash
            #"dom.forms.autocomplete.formautofill" = false; # Disable autofill
            #"extensions.formautofill.creditCards.enabled" = false; # Disable credit cards
            #"dom.payments.defaults.saveAddress" = false; # Disable address save
            "general.autoScroll" = true; # Drag middle-mouse to scroll
            "services.sync.prefs.sync.general.autoScroll" = false; # Prevent disabling autoscroll
            "services.sync.username" = "jayandrinsmart@gmail.com";
            "signon.rememberSignons" = false;
            "extensions.pocket.enabled" = false;
            "extensions.autoDisable" = 0;
            #"toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Allow userChrome.css
            #"layout.css.color-mix.enabled" = true;
            "ui.systemUsesDarkTheme" = true;
            "media.ffmpeg.vaapi.enabled" = true; # Enable hardware video acceleration
            "cookiebanners.ui.desktop.enabled" = true; # Reject cookie popups
            "devtools.command-button-screenshot.enabled" = true; # Scrolling screenshot of entire page
            "svg.context-properties.content.enabled" = true; # Sidebery styling
          };
          extraConfig = "";
        };
      };

      xdg.mimeApps = {
        associations.added = {
          "text.html" = [ "firefox.desktop" ];
        };
        defaultApplications = {
          "text.html" = [ "firefox.desktop" ];
        };
      };
    };
  };
}
