#!/bin/sh
#video_source="/home/pedruino/Videos/VID_20180701_000108096.mp4"
video_source="/home/pedruino/Videos/YOLO2/Thunder/VID_20180630_115806452.mp4"
video_output="results/test_dnn_out.mkv"
log_output="results/log.txt"

base_command="./darknet detector demo cfg/coco.data"
output_dir="/home/pedruino/Documents/YOLO"

for model in "yolov3-tiny" "yolov3"
do
  for threshold in 0.25 0.50 0.75
  do
    echo "Running $model [$threshold]"

    $base_command cfg/$model.cfg $model.weights $video_source > $log_output -thresh $threshold

    #MODEL
    thresh_output_dir=$output_dir/$model
    if [ ! -d "$thresh_output_dir" ]; then
      mkdir $thresh_output_dir
    fi

    #THRESHHOLD
    thresh_output_dir=$thresh_output_dir/$threshold
    if [ ! -d "$thresh_output_dir" ]; then
      mkdir $thresh_output_dir
    fi

    echo $thresh_output_dir
    mv $video_output $thresh_output_dir
    mv $log_output $thresh_output_dir

    echo "What is done, is done!"
  done
done
