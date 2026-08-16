#!/usr/bin/env bash

cd "$( dirname "$0" )" || exit 1

# Load customized environment variables if available
if [ -r .env ]
then
	. .env
fi

if ! which refasmer >/dev/null
then
	echo "This script requires refasmer to extract reference assemblies!" >&2
	echo "Please install it according to the instructions from https://github.com/JetBrains/Refasmer!" >&2
	echo "(Likely: dotnet tool install -g JetBrains.Refasmer.CliTool)" >&2
	exit 98
fi

outputDirectory="$(realpath Assemblies)"
licenseSourcePath="$(realpath Licenses)"
zipPath="$(realpath Assemblies.zip)"

if [ ! -r "$ResonitePath" ]
then
	echo "Incorrect or missing environment variable 'ResonitePath': \"$ResonitePath\"" >&2
	exit 99
else
	echo "Creating assemblies from directory \"$ResonitePath\"..."

	pushd "$ResonitePath" || exit 2
	rm -rf "$outputDirectory"
	# Create assemblies with Refasmer CLI tool (see: https://github.com/JetBrains/Refasmer)
	refasmer -g --all --outputdir="$outputDirectory" Awwdio*dll ColorLUT*dll Elements*dll FrooxEngine*dll PhotonDust*dll ProtoFlux*dll Renderite*dll SkyFrost*dll YellowDogMan*dll || exit 3
	refasmer -g --all --outputdir="$outputDirectory" Bepu*dll || exit 4
	
	cp -r "$licenseSourcePath" "$outputDirectory/Licenses"

	echo "Creating zip file..."

	cd "$outputDirectory" || exit 5
	rm -rf "$zipPath"
	# Create zip file that can be easily published
	zip -r "$zipPath" * || exit 6

	popd || exit 7

	echo "Successfully created and packaged Resonite assemblies:"
	find "$outputDirectory"
fi