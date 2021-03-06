@echo off

set okio_version=1.6.0
set okhttp_version=2.5.0
set okhttpws_version=2.5.0
set picasso_version=2.5.2
set androidtimessquare_version=1.6.4
set socketrocket_version=0.4.1
set valet_version=2.0.3
set aardvark_version=1.2.2
set seismic_version=1.0.2
set pollexor_version=2.0.4

echo Setting up
rem clean up before packaging
rmdir /Q /S build
rmdir /Q /S nuget\build
rem make sure all the folders are in place
mkdir build

rem download the files
echo Downloading binaries
if not exist binding/Square.OkIO/Jars/okio-%okio_version%.jar (
    wget "http://search.maven.org/remotecontent?filepath=com/squareup/okio/okio/%okio_version%/okio-%okio_version%.jar" -O "binding/Square.OkIO/Jars/okio-%okio_version%.jar" --no-check-certificate
)
if not exist binding/Square.OkHttp/Jars/okhttp-%okhttp_version%.jar (
    wget "http://search.maven.org/remotecontent?filepath=com/squareup/okhttp/okhttp/%okhttp_version%/okhttp-%okhttp_version%.jar" -O "binding/Square.OkHttp/Jars/okhttp-%okhttp_version%.jar" --no-check-certificate
)
if not exist binding/Square.OkHttp.WS/Jars/okhttp-ws-%okhttpws_version%.jar (
    wget "http://search.maven.org/remotecontent?filepath=com/squareup/okhttp/okhttp-ws/%okhttpws_version%/okhttp-ws-%okhttpws_version%.jar" -O "binding/Square.OkHttp.WS/Jars/okhttp-ws-%okhttpws_version%.jar" --no-check-certificate
)
if not exist binding/Square.Picasso/Jars/picasso-%picasso_version%.jar (
    wget "http://search.maven.org/remotecontent?filepath=com/squareup/picasso/picasso/%picasso_version%/picasso-%picasso_version%.jar" -O "binding/Square.Picasso/Jars/picasso-%picasso_version%.jar" --no-check-certificate
)
if not exist binding/Square.AndroidTimesSquare/Jars/android-times-square-%androidtimessquare_version%.aar (
    wget "http://search.maven.org/remotecontent?filepath=com/squareup/android-times-square/%androidtimessquare_version%/android-times-square-%androidtimessquare_version%.aar" -O "binding/Square.AndroidTimesSquare/Jars/android-times-square-%androidtimessquare_version%.aar" --no-check-certificate
)
if not exist binding/Square.Seismic/Jars/seismic-%seismic_version%.jar (
    wget "http://search.maven.org/remotecontent?filepath=com/squareup/seismic/%seismic_version%/seismic-%seismic_version%.jar" -O "binding/Square.Seismic/Jars/seismic-%seismic_version%.jar" --no-check-certificate
)
if not exist binding/Square.Pollexor/Jars/pollexor-%pollexor_version%.jar (
    wget "http://search.maven.org/remotecontent?filepath=com/squareup/pollexor/%pollexor_version%/pollexor-%pollexor_version%.jar" -O "binding/Square.Pollexor/Jars/pollexor-%pollexor_version%.jar" --no-check-certificate
)

rem check out any files

rem build any native libraries

rem build the solution
echo Building the solution
msbuild binding\Square.sln /p:Configuration=Release /t:Rebuild

rem copy the output for NuGet (so that we can avoid Windows/Mac path issues)
echo Copying the output files packaging
mkdir nuget\build
copy README.md nuget\build
copy LICENSE.txt nuget\build
copy binding\Square.OkIO\bin\Release\Square.OkIO.dll nuget\build
copy binding\Square.OkHttp\bin\Release\Square.OkHttp.dll nuget\build
copy binding\Square.Picasso\bin\Release\Square.Picasso.dll nuget\build
copy binding\Square.OkHttp.WS\bin\Release\Square.OkHttp.WS.dll nuget\build
copy binding\Square.SocketRocket\bin\Release\Square.SocketRocket.dll nuget\build
copy binding\Square.AndroidTimesSquare\bin\Release\Square.AndroidTimesSquare.dll nuget\build
copy binding\Square.Valet\bin\Release\Square.Valet.dll nuget\build
copy binding\Square.Aardvark\bin\Release\Square.Aardvark.dll nuget\build
copy binding\Square.Seismic\bin\Release\Square.Seismic.dll nuget\build
copy binding\Square.Pollexor\bin\Release\Square.Pollexor.dll nuget\build

rem build the nuget
echo Packaging the NuGets
nuget pack nuget\Square.OkIO.nuspec -OutputDirectory build
nuget pack nuget\Square.OkHttp.nuspec -OutputDirectory build
nuget pack nuget\Square.Picasso.nuspec -OutputDirectory build
nuget pack nuget\Square.OkHttp.WS.nuspec -OutputDirectory build
nuget pack nuget\Square.SocketRocket.nuspec -OutputDirectory build
nuget pack nuget\Square.AndroidTimesSquare.nuspec -OutputDirectory build
nuget pack nuget\Square.Valet.nuspec -OutputDirectory build
nuget pack nuget\Square.Aardvark.nuspec -OutputDirectory build
nuget pack nuget\Square.Seismic.nuspec -OutputDirectory build
nuget pack nuget\Square.Pollexor.nuspec -OutputDirectory build

rem build the components
echo Packaging the Components
xamarin-component package component\square.picasso
xamarin-component package component\square.okhttp
xamarin-component package component\square.okhttp.ws
xamarin-component package component\square.socketrocket
xamarin-component package component\square.androidtimessquare
xamarin-component package component\square.valet
xamarin-component package component\square.aardvark
xamarin-component package component\square.seismic
xamarin-component package component\square.pollexor

rem move the files to the output location
echo Moving files to the build directory
move component\square.picasso\*.xam build
move component\square.okhttp.ws\*.xam build
move component\square.okhttp\*.xam build
move component\square.socketrocket\*.xam build
move component\square.androidtimessquare\*.xam build
move component\square.valet\*.xam build
move component\square.aardvark\*.xam build
move component\square.seismic\*.xam build
move component\square.pollexor\*.xam build

rem clean any temporary files/folders
echo Cleaning up
rmdir /Q /S nuget\build
