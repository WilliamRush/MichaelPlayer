set "QtPath=E:\codeSpace\Qt\6.2.0\msvc2019_64"
set /p "QtPath=Enter path or just default [%QtPath%] :"
cmake -G "Visual Studio 16 2019" -DCMAKE_PREFIX_PATH=%QtPath% -B build