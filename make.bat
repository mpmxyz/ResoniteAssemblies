
echo OFF

REM Load customized environment variables if available
IF EXIST env.bat call env.bat
set outputDirectory=%cd%\Assemblies
set licenseSourcePath=%cd%\Licenses
set zipPath=%cd%\Assemblies.zip

IF NOT EXIST %ResonitePath% (
	echo Incorrect or missing environment variable 'ResonitePath': "%ResonitePath%"
) ELSE (
	echo Creating assemblies from directory "%ResonitePath%"...
 
	del /S /Q %outputDirectory%
	REM Create assemblies with Refasmer CLI tool (see: https://github.com/JetBrains/Refasmer)
	dotnet refasmer -g --all --outputdir=%outputDirectory% %ResonitePath%\Awwdio*dll
	dotnet refasmer -g --all --outputdir=%outputDirectory% %ResonitePath%\ColorLUT*dll
	dotnet refasmer -g --all --outputdir=%outputDirectory% %ResonitePath%\Elements*dll
	dotnet refasmer -g --all --outputdir=%outputDirectory% %ResonitePath%\FrooxEngine*dll
	dotnet refasmer -g --all --outputdir=%outputDirectory% %ResonitePath%\PhotonDust*dll
	dotnet refasmer -g --all --outputdir=%outputDirectory% %ResonitePath%\ProtoFlux*dll
	dotnet refasmer -g --all --outputdir=%outputDirectory% %ResonitePath%\Renderite*dll
	dotnet refasmer -g --all --outputdir=%outputDirectory% %ResonitePath%\SkyFrost*dll
	dotnet refasmer -g --all --outputdir=%outputDirectory% %ResonitePath%\YellowDogMan*dll
	dotnet refasmer -g --all --outputdir=%outputDirectory% %ResonitePath%\Bepu*dll
	
	xcopy /I /E %licenseSourcePath% %outputDirectory%\Licenses

	echo Extracting Resonite Version...
	dotnet script get-assembly-version.csx %outputDirectory%\FrooxEngine.dll > %outputDirectory%\RESONITE_VERSION
	echo Version:
	type %outputDirectory%\RESONITE_VERSION
	echo Creating zip file...

	pushd %outputDirectory%
	del /Q %zipPath%
	REM Create zip file that can be easily published
	tar -a -c -f %zipPath% *

	popd

	echo Successfully created and packaged Resonite assemblies:
	dir /B %outputDirectory%

)	