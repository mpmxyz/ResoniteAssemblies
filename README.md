# ResoniteAssemblies
This repository contains a small script and the reference assemblies it creates from a Resonite install.
It is meant as a lightweight starting point to create workflows for mods and plugins.

Distribution of reference assemblies is permitted by Resonite's [mod and plugin policies](https://resonite.com/policies/ModAndPlugin.html#reference-assemblies).

You can clone this repository to update the assemblies independently from me.

# How to use
1. Download the zip file [TODO.zip]
2. Unpack the zip file into the folder that is supposed to emulate the Resonite install directory.
3. Your projects can reference files locally and during a GitHub action if you make the assumed install path of Resonite configurable. (i.e. using the variable `ResonitePath`)

# How to update
1. Ensure that the environment variable `ResonitePath` points to a valid Resonite install! (can be configured in an optional `env.bat` file)
2. Run the script `make.bat`!
3. `git add *`
4. `git commit -m 'Updated Assemblies'`
5. `git tag "$RESONITE_VERSION"` (`$RESONITE_VERSION` needs to match the pattern "*.*.*.*")
6. `git push`
7. `git push --tags`
