#!/usr/bin/env bash

cd "$( dirname "$0" )" || exit 1

# Load customized environment variables if available
if [ -r .env ]
then
	. .env || exit 10
fi

outputDirectory="$(realpath Assemblies)"
licenseSourcePath="$(realpath Licenses)"
zipPath="$(realpath Assemblies.zip)"

if [ ! -r "$ResonitePath" ]
then
	echo "Incorrect or missing environment variable 'ResonitePath': \"$ResonitePath\"" >&2
	exit 9
else
	echo "Creating assemblies from directory \"$ResonitePath\"..."

	rm -rf "$outputDirectory"
	# Create assemblies with Refasmer CLI tool (see: https://github.com/JetBrains/Refasmer)
	{
		dotnet refasmer -g --all --outputdir="$outputDirectory" "$ResonitePath/"Awwdio*dll && 
		dotnet refasmer -g --all --outputdir="$outputDirectory" "$ResonitePath/"ColorLUT*dll && 
		dotnet refasmer -g --all --outputdir="$outputDirectory" "$ResonitePath/"Elements*dll && 
		dotnet refasmer -g --all --outputdir="$outputDirectory" "$ResonitePath/"FrooxEngine*dll && 
		dotnet refasmer -g --all --outputdir="$outputDirectory" "$ResonitePath/"PhotonDust*dll && 
		dotnet refasmer -g --all --outputdir="$outputDirectory" "$ResonitePath/"ProtoFlux*dll  && 
		dotnet refasmer -g --all --outputdir="$outputDirectory" "$ResonitePath/"Renderite*dll && 
		dotnet refasmer -g --all --outputdir="$outputDirectory" "$ResonitePath/"SkyFrost*dll && 
		dotnet refasmer -g --all --outputdir="$outputDirectory" "$ResonitePath/"YellowDogMan*dll && 
		dotnet refasmer -g --all --outputdir="$outputDirectory" "$ResonitePath/"Bepu*dll
	} || {
		echo "This script requires refasmer to extract reference assemblies!" >&2
		echo "Please install it according to the instructions from https://github.com/JetBrains/Refasmer!" >&2
		echo ">dotnet tool install JetBrains.Refasmer.CliTool" >&2
		exit 4
	}
	
	cp -r "$licenseSourcePath" "$outputDirectory/Licenses"

	echo "Creating zip file..."

	pushd "$outputDirectory" || exit 5
	rm -rf "$zipPath"
	# Create zip file that can be easily published
	zip -r "$zipPath" * || exit 6

	popd || exit 7

	echo "Successfully created and packaged Resonite assemblies:"
	find "$outputDirectory"

	echo "Extracting Resonite Version..."
	dotnet script get-assembly-version.csx Assemblies/FrooxEngine.dll > RESONITE_VERSION || {
		echo "Did you install dotnet script?" >&2
		echo ">dotnet tool install dotnet-script"
		exit 8
	}
	echo "Version:"
	cat RESONITE_VERSION
fi