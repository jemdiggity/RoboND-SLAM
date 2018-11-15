#! /bin/bash

echo ' '
read -p 'Would you like to clear the previous map database? (y/n): ' ansinput

if [ “$ansinput” = “y” ]
then
 printf '\n Map deleted \n'
 rm -f ~/.ros/rtabmap.db

elif [ “$ansinput” = “n” ]
then
 printf '\n Map kept \n'

else
 echo 'Warning: Not an acceptable option. Choose (y/n).
         '
fi

echo ' '

read -p 'Enter target world destination or enter for default: ' input_choice

if [ “$input_choice” = “” ]
then
 echo "Using default world"
 x-terminal-emulator -x roslaunch slam_project world.launch world_file:=kitchen_dining 2>/dev/null &

else
 echo "Using ${input_choice}.world"
 x-terminal-emulator -x roslaunch slam_project world.launch world_file:=${input_choice} 2>/dev/null &
fi

sleep 3 &&

x-terminal-emulator -x roslaunch slam_project teleop.launch 2>/dev/null &

sleep 3 &&

echo ' '
read -p 'Press any key to continue to mapping... ' -n1 -s

x-terminal-emulator -x roslaunch slam_project mapping.launch simulation:=true 2>/dev/null &
sleep 3 &&
x-terminal-emulator -e roslaunch slam_project rviz.launch 2>/dev/null

echo ' '
echo 'Script Completed'
echo ' '
