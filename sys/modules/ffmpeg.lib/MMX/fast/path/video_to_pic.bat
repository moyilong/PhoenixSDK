@echo off
echo MMX External -- V2I
echo Useage : video_to_pic [video] [pic_out_name_formal]
ffmpeg -i %1 %2
