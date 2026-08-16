# ResoniteAssemblies
This repository contains a small script and the reference assemblies it creates from a Resonite install.
It is meant as a lightweight starting point to create workflows for mods and plugins.

Distribution of reference assemblies is permitted by Resonite's [mod and plugin policies](https://resonite.com/policies/ModAndPlugin.html#reference-assemblies). (Note: Reference assemblies contain no implementation, just a hull of all structs and classes.)

You can clone this repository to update the assemblies independently from me.

# How to use
1. Download the zip file [Assemblies.zip](https://github.com/mpmxyz/ResoniteAssemblies/raw/refs/heads/main/Assemblies.zip):

```sh
wget https://raw.githubusercontent.com/mpmxyz/ResoniteAssemblies/refs/heads/main/Assemblies.zip
```
or use a github action of your choice to download the latest release zip file

2. Unpack the zip file into the folder that is supposed to emulate the Resonite install directory:

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
## Prerequisites
1. Environment variable `ResonitePath` points to a valid Resonite install. (can be configured in an optional `env.bat` (Windows) or `.env` (Linux))
2. The dotnet tool dependencies are installed (i.e. via `dotnet tool restore`):
    - `dotnet-script`
    - [JetBrains.Refasmer.CliTool](https://github.com/JetBrains/Refasmer) is installed! (`dotnet tool install JetBrains.Refasmer.CliTool`)

## Update workflow
1. Update Resonite on local machine!
2. Run the script `make.bat` (Windows) or `make.sh` (Linux)! 
3. `git add *`
4. `git commit -m 'Updated Assemblies'`
5. `git push`
