#!/bin/bash

Video_download(){

	URL=""
	Directory=
	isMp4=""

	read -p "Enter the URL of the video: " URL
    read -p "Enter the download directory (ex: /home/user/Videos): " Directory
    read -p "Do you want the video in MP4 format? (y/n) (h246 + aac): " isMp4     
    
    if [[ "$isMp4" = "y" ]]; 
    then
    	yt-dlp -S vcodec:h264,res,acodec:m4a -P $Directory $URL
    else
    	yt-dlp -P $Directory $URL

    fi
}

Audio_download(){

    URL=""
    Directory=
    isMP3=""

    read -p "Enter the URL of the video: " URL
    read -p "Enter the download directory (ex: /home/user/Music): " Directory
    read -p "Do you want the audio in MP3 format? (y/n): " isMP3

    if [[ "$isMP3" = "y" ]]; 
    then
    	yt-dlp -x --audio-format mp3 --embed-metadata --embed-thumbnail -P $Directory $URL
    else
        yt-dlp -x --audio-format best --no-keep-video --embed-metadata --embed-thumbnail -P $Directory $URL
    fi
}

Playlist_download(){

	choice=""
	URL=""
	Directory=
	isMp4=""
	isMp3=""

	read -p "Do you want to download the playlist as video or audio? (v/a): " choice
    if [[ "$choice" = "v" ]];
     then
    	read -p "Enter the URL of the playlist: " URL
    	read -p "Enter the download directory (ex: /home/user/Videos): " Directory
    	read -p "Do you want the videos in MP4 format? (y/n) (h246 + aac): " isMp4
    	if [[ "$isMp4" = "y" ]];
    	 then
    		yt-dlp -o "%(playlist_index)s - %(title)s.%(ext)s" -S vcodec:h264,res,acodec:m4a -P $Directory $URL
    	else
    		yt-dlp -o "%(playlist_index)s - %(title)s.%(ext)s" -P $Directory $URL
        fi
    elif [[ "$choice" = "a" ]];
     then
    	read -p "Enter the URL of the playlist: " URL
    	read -p "Enter the download directory (ex: /home/user/Music): " Directory
        read -p "Do you want the audio files in MP3 format? (y/n): " isMp3
        if [[ "$isMp3" = "y" ]];
         then
        	yt-dlp -o "%(playlist_index)s - %(title)s.%(ext)s" -x --audio-format mp3 --embed-metadata --embed-thumbnail -P $Directory $URL
        else
        	yt-dlp -o "%(playlist_index)s - %(title)s.%(ext)s" -x --audio-format best --no-keep-video --embed-metadata --embed-thumbnail -P $Directory $URL
        fi
    else
    	echo "Invalid choice! Please try again."

    fi
}


Main(){

    choice=""

    echo "                                           "
    echo "**************[Yt-dlp]*********************"
    echo "                                           "
    echo " 1-Video downloader     2-Audio downloader "
    echo "                                           "
    echo " 3-Playlist download    4-Quit :P          "
    echo "                                           "
    echo "*******************************************"
    echo "                                           "
    read -p "What would you want to do today? (1/2/3/4): " choice
    if [[ "$choice" = "1" ]];
     then
    	Video_download
    elif [[ "$choice" = "2" ]];
     then
    	Audio_download
    elif [[ "$choice" = "3" ]];
     then
    	Playlist_download
    elif [[ "$choice" = "4" ]];
     then
    	exit
    else
    	echo "Invalid option!"
    fi
    
}

while [[ "1" = "1" ]];
 do
	Main
done