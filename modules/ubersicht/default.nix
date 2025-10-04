{
  darwinModules.ubersicht =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      homebrew = {
        casks = [
          "ubersicht"
        ];
      };
    };

  # install simple-bar into ubersicht widgets folder
  homeModules.ubersicht =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      home.file."Library/Application Support/Übersicht/widgets/simple-bar" = {
        source = pkgs.fetchFromGitHub {
          owner = "Jean-Tinland";
          repo = "simple-bar";
          rev = "7673cbbc56973748897bcae15afc135865694351";
          sha256 = "sha256-8MpANF0m/c8Z2btgArn1pavxoP2qdkKX4dD9l3nDFa8=";
        };
      };
      home.file.".simplebarrc" = {
        text =
          let
            config = builtins.toJSON {
              global = {
                theme = "dark";
                compactMode = false;
                floatingBar = false;
                noBarBg = true;
                noColorInData = false;
                bottomBar = false;
                sideDecoration = false;
                inlineSpacesOptions = false;
                spacesBackgroundColorAsForeground = false;
                widgetsBackgroundColorAsForeground = false;
                widgetMaxWidth = "160px";
                slidingAnimationPace = 4;
                font = "JetBrains Mono, Monaco, Menlo, monospace";
                fontSize = "11px";
                yabaiPath = "";
                aerospacePath = "${pkgs.aerospace}/bin/aerospace";
                windowManager = "aerospace";
                shell = "sh";
                terminal = "Terminal";
                disableNotifications = false;
                enableMissives = false;
                enableServer = false;
                serverSocketPort = 7777;
                yabaiServerRefresh = false;
                aerospaceServerRefresh = false;
                flashspaceServerRefresh = false;
              };
              themes = {
                lightTheme = "CatppuccinLatte";
                darkTheme = "CatppuccinMocha";
                colorMain = "";
                colorMainAlt = "";
                colorMinor = "";
                colorAccent = "";
                colorRed = "";
                colorGreen = "";
                colorYellow = "";
                colorOrange = "";
                colorBlue = "";
                colorMagenta = "";
                colorCyan = "";
                colorBlack = "";
                colorWhite = "";
                colorForeground = "";
                colorBackground = "";
              };
              process = {
                showOnDisplay = "false";
                displayOnlyCurrent = false;
                centered = false;
                showCurrentSpaceMode = false;
                hideWindowTitle = false;
                displayOnlyIcon = false;
                expandAllProcesses = false;
                displaySkhdMode = false;
                displayStackIndex = true;
                displayOnlyCurrentStack = false;
              };
              spacesDisplay = {
                showOnDisplay = "";
                exclusions = "";
                titleExclusions = "";
                spacesExclusions = "";
                exclusionsAsRegex = false;
                displayAllSpacesOnAllScreens = false;
                hideDuplicateAppsInSpaces = false;
                displayStickyWindowsSeparately = false;
                hideCreateSpaceButton = false;
                hideEmptySpaces = false;
                showOptionsOnHover = true;
                switchSpacesWithoutYabai = false;
                showOnlyFlashspaceSpaceIndex = false;
                hideFlashspaceAppIcons = false;
              };
              widgets = {
                processWidget = false;
                weatherWidget = false;
                netstatsWidget = false;
                cpuWidget = true;
                gpuWidget = false;
                memoryWidget = true;
                batteryWidget = true;
                wifiWidget = false;
                vpnWidget = false;
                zoomWidget = false;
                soundWidget = false;
                micWidget = false;
                dateWidget = true;
                timeWidget = true;
                keyboardWidget = false;
                spotifyWidget = false;
                cryptoWidget = false;
                stockWidget = false;
                youtubeMusicWidget = false;
                musicWidget = false;
                mpdWidget = false;
                browserTrackWidget = false;
              };
              weatherWidgetOptions = {
                refreshFrequency = 1800000;
                showOnDisplay = "";
                unit = "C";
                hideLocation = false;
                hideGradient = false;
                customLocation = "";
              };
              netstatsWidgetOptions = {
                refreshFrequency = 2000;
                showOnDisplay = "";
                displayAsGraph = false;
              };
              cpuWidgetOptions = {
                refreshFrequency = 2000;
                showOnDisplay = "";
                displayAsGraph = false;
                cpuMonitorApp = "Activity Monitor";
              };
              gpuWidgetOptions = {
                refreshFrequency = 3000;
                showOnDisplay = "";
                displayAsGraph = false;
                gpuMacmonBinaryPath = "/opt/homebrew/bin/macmon";
              };
              memoryWidgetOptions = {
                refreshFrequency = 4000;
                showOnDisplay = "";
                memoryMonitorApp = "Activity Monitor";
              };
              batteryWidgetOptions = {
                refreshFrequency = 10000;
                showOnDisplay = "";
                toggleCaffeinateOnClick = true;
                caffeinateOption = "";
              };
              networkWidgetOptions = {
                refreshFrequency = 20000;
                showOnDisplay = "";
                networkDevice = "en0";
                hideWifiIfDisabled = false;
                toggleWifiOnClick = false;
                hideNetworkName = false;
              };
              vpnWidgetOptions = {
                refreshFrequency = 8000;
                showOnDisplay = "";
                vpnConnectionName = "";
                vpnShowConnectionName = false;
              };
              zoomWidgetOptions = {
                refreshFrequency = 5000;
                showOnDisplay = "";
                showVideo = true;
                showMic = true;
              };
              soundWidgetOptions = {
                refreshFrequency = 20000;
                showOnDisplay = "";
              };
              micWidgetOptions = {
                refreshFrequency = 20000;
                showOnDisplay = "";
              };
              dateWidgetOptions = {
                refreshFrequency = 30000;
                showOnDisplay = "";
                shortDateFormat = true;
                locale = "en-UK";
                calendarApp = "";
                showIcon = false;
              };
              timeWidgetOptions = {
                refreshFrequency = 1000;
                showOnDisplay = "";
                hour12 = false;
                dayProgress = false;
                showIcon = false;
                showSeconds = false;
              };
              keyboardWidgetOptions = {
                refreshFrequency = 20000;
                showOnDisplay = "";
              };
              cryptoWidgetOptions = {
                refreshFrequency = 300000;
                showOnDisplay = "";
                denomination = "usd";
                identifiers = "bitcoin,ethereum,celo";
                precision = 5;
              };
              stockWidgetOptions = {
                refreshFrequency = 900000;
                showOnDisplay = "";
                yahooFinanceApiKey = "YOUR_API_KEY";
                symbols = "AAPL,TSLA";
                showSymbol = true;
                showCurrency = true;
                showMarketPrice = true;
                showMarketChange = false;
                showMarketPercent = true;
                showColor = true;
              };
              spotifyWidgetOptions = {
                refreshFrequency = 10000;
                showOnDisplay = "";
                showSpecter = true;
              };
              youtubeMusicWidgetOptions = {
                refreshFrequency = 10000;
                showOnDisplay = "";
                showSpecter = true;
                youtubeMusicPort = 26538;
              };
              musicWidgetOptions = {
                refreshFrequency = 10000;
                showOnDisplay = "";
                showSpecter = true;
              };
              mpdWidgetOptions = {
                refreshFrequency = 10000;
                showOnDisplay = "";
                showSpecter = true;
                mpdBinaryPath = "/opt/homebrew/bin/mpc";
                mpdPort = "6600";
                mpdHost = "127.0.0.1";
                mpdFormatString = "%title%[ - %artist%]|[%file%]";
              };
              browserTrackWidgetOptions = {
                refreshFrequency = 10000;
                showOnDisplay = "";
                showSpecter = true;
              };
              userWidgets = {
                userWidgetsList = { };
              };
              customStyles = {
                styles = ''
                  ::root {
                  }

                  .simple-bar {
                    padding-left: 5px;
                    padding-right: 5px;
                    padding-top: 5px;
                  }

                  .simple-bar .simple-bar__data {
                    border-radius: 8px;
                  }

                  .simple-bar .spaces {
                    border-radius: 8px;
                  }

                  .time, .battery, .date-display {
                    background-color: var(--minor);
                    color: var(--foreground);
                  }
                '';
              };
            };
          in
          config;
      };
    };
}
