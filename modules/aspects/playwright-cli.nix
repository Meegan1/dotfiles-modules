{
  dotfiles-modules.playwright-cli = {
    homeManager =
      { pkgs, ... }:
      let
        playwright-cli-pkg =
          {
            lib,
            buildNpmPackage,
            fetchFromGitHub,
          }:
          buildNpmPackage {
            pname = "playwright-cli";
            version = "0.1.20";

            src = fetchFromGitHub {
              owner = "microsoft";
              repo = "playwright-cli";
              rev = "12228454ed024c9ac89abd59df3b706ed9135fd9";
              hash = "sha256-MSBXygESmOlZi8qryAsUN6jb30RbysdEZRBXocrXZ14=";
            };

            npmDepsHash = "sha256-PZrjfveGYvPapua4eRV6FJRc9txh8OXSsbsxQmkiZPw=";

            # Skip the build phase since there's no build script
            dontNpmBuild = true;

            meta = with lib; {
              description = "CLI for common Playwright actions";
              homepage = "https://playwright.dev";
              license = licenses.asl20;
              maintainers = [ ];
              platforms = platforms.all;
            };
          };

        playwright-cli = pkgs.callPackage playwright-cli-pkg { };
      in
      {
        home.packages = [ playwright-cli ];
      };
  };
}
