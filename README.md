# unmigrate
Unmigrates split tunnel configurations for I2P portable installs

The only time it's really useful is when someone is going from a regular router
install, which uses a configdir, to a portable router install, which uses a
monolithic config file. Because a file in the configdir has a different layout
from the monolithic config file, they need to be un-migrated in this scenario.
This is essentially a script which does that in an automatic fashion.

## usage

Unmigrate takes two optional string arguments, dirpath and outpath.

Passing dirpath sets the directory to look for config files. So to look for
config files in the usual I2P config directory on Windows, you would run:

```
    unmigrate.exe -dirpath=C:\Users\YOUR_USERNAME\AppData\Roaming\I2P\i2ptunnel.config.d
```

Passing outpath sets the directory to place an unmigrated i2ptunnel.config. So
to place the migrated config file into your Documents directory on Windows, use
this:

```
    unmigrate.exe -outpath=C:\Users\YOUR_USERNAME\Documents\i2ptunnel.config
```

They can also be used together:

```
    unmigrate.exe -dirpath=C:\Users\YOUR_USERNAME\AppData\Roaming\I2P\i2ptunnel.config.d-dirpath=C:\Users\YOUR_USERNAME\AppData\Roaming\I2P\i2ptunnel.config.d -outpath=C:\Users\YOUR_USERNAME\Documents\i2ptunnel.config
```