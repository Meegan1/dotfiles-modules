{
  darwinModules.capslock-delay =
    {
      pkgs,
      config,
      ...
    }:
    {
      system.activationScripts.keyboardCapslockDelay.text = ''
        # Set the delay to 0 seconds
        echo "setting keyboard caps lock delay to 0 seconds..." >&2
        hidutil property --set '{"CapsLockDelayOverride":0}' > /dev/null
      '';

      system.activationScripts.postActivation.text = ''
        ${config.system.activationScripts.keyboardCapslockDelay.source}
      '';
    };
}
