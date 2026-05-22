
echo OFF

REM Load customized environment variables if available
IF EXIST env.bat call env.bat
set outputDirectory=%cd%\Assemblies
set zipPath=%cd%\Assemblies.zip

IF NOT EXIST %ResonitePath% (
	echo Incorrect or missing environment variable 'ResonitePath': "%ResonitePath%"
) ELSE (
	echo Creating assemblies from directory "%ResonitePath%"...

	pushd %ResonitePath%
	del /Q %outputDirectory%
	REM Create assemblies with Refasmer CLI tool (see: https://github.com/JetBrains/Refasmer)
	refasmer -g --all --outputdir=%outputDirectory% Awwdio*dll Elements*dll FrooxEngine*dll PhotonDust*dll ProtoFlux*dll Renderite*dll SkyFrost*dll YellowDogMan*dll

	echo Creating zip file...

	cd %outputDirectory%
	del /Q %zipPath%
	REM Create zip file that can be easily published
	tar -a -c -f %zipPath% *

	popd

	echo Successfully created and packaged Resonite assemblies:
	dir /B %outputDirectory%
)