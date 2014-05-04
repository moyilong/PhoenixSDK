@echo off
echo MMX External -- Bootanimation Maker
echo Useage : video_to_pic [video]
if exist bootanimation goto __exist
mkdir bootanimation
ffmpeg -i %1  bootanimation\bootanim_mmxout_%d.png


:__exist
echo Bootanimation Exist :(
goto end

:end
