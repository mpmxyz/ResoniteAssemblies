# ResoniteAssemblies
This repository contains a small script and the reference assemblies it creates from a Resonite install.
It is meant as a lightweight starting point to create workflows for mods and plugins.

Distribution of reference assemblies is permitted by Resonite's [mod and plugin policies](https://resonite.com/policies/ModAndPlugin.html#reference-assemblies).

You can clone this repository to update the assemblies independently from me.

# How to use
1. Download the zip file [Assemblies.zip](https://github.com/mpmxyz/ResoniteAssemblies/raw/refs/heads/main/Assemblies.zip)

```sh
curl https://github.com/mpmxyz/ResoniteAssemblies/raw/refs/heads/main/Assemblies.zip
```
or use a github action of your choice to download the latest release zip file

2. Unpack the zip file into the folder that is supposed to emulate the Resonite install directory.

```sh
ZIP_FILE="$(realpath Assemblies.zip)"
mkdir -p "$ResonitePath" &&
cd "$ResonitePath" &&
unzip "$ZIP_FILE"
```

3. Your projects can reference files both locally and during a GitHub action if you make the assumed install path of Resonite configurable. (i.e. using the variable `ResonitePath`)

```xml
	<ItemGroup>
		<Reference Include="FrooxEngine">
			<HintPath>$(ResonitePath)FrooxEngine.dll</HintPath>
			<Private>False</Private>
		</Reference>
	</ItemGroup>
```


# How to update
1. Ensure that the environment variable `ResonitePath` points to a valid Resonite install! (can be configured in an optional `env.bat` file)
2. Run the script `make.bat`! It requires the Refasmer CLI tool. (see: [https://github.com/JetBrains/Refasmer](https://github.com/JetBrains/Refasmer))
3. `git add *`
4. `git commit -m 'Updated Assemblies'`
5. `git tag "$RESONITE_VERSION"` (`$RESONITE_VERSION` needs to match the pattern "*.*.*.*")
6. `git push`
7. `git push --tags`
