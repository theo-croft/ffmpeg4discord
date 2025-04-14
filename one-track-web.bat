@echo off
setlocal

:: Check if a file was dragged onto the script
if "%~1"=="" (
    echo Please drag and drop an MP4 file onto this script.
    pause
    exit /b
)

:: Set the input and output file names
set "input_file=%~1"
set "output_file=%~dpn1_merged.mp4"

:: Execute the FFmpeg command to merge audio tracks
ffmpeg -i "%input_file%" -filter_complex "[0:a:0][0:a:1][0:a:2]amerge=inputs=3[a]" -map 0:v -map "[a]" -c:v copy -c:a aac "%output_file%"

echo Audio tracks merged successfully into %output_file%.

:: Open the newly created video with ff4d
ff4d "%output_file%" -o "PUT A PATH FILE HERE" --web

endlocal
pause