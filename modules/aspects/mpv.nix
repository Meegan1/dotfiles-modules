{
  dotfiles-modules.mpv = {
    homeManager =
      { pkgs, ... }:
      let
        strm-script = ''
          local function read_strm(path)
              local f = io.open(path, "r")
              if not f then return nil end
              local url = f:read("*l")
              f:close()
              return url and url:match("^%s*(.-)%s*$")
          end

          mp.add_hook("on_load", 10, function()
              local path = mp.get_property("path")
              if path and path:match("%.strm$") then
                  local url = read_strm(path)
                  if url and url ~= "" then
                      mp.set_property("stream-open-filename", url)
                  end
              end
          end)
        '';
      in
      {
        programs.mpv = {
          enable = true;
          package = (
            pkgs.mpv.override {
              scripts = with pkgs.mpvScripts; [
                modernz
              ];
            }
          );

          config = {
            profile = "high-quality";
            ytdl-format = "bestvideo+bestaudio";
          };
        };

        home.file.".config/mpv/scripts/strm.lua" = {
          text = strm-script;
        };

      };
  };
}
