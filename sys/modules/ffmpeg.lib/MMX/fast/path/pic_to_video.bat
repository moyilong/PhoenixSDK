@echo off
echo MMX External -- V2I
echo Useage : video_to_pic [video] [pic_out_name_formal] [audio] [coder]
ffmpeg -i %1 -i -codec %4 %3 
