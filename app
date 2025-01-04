#!/bin/bash

## Tarniceriu, Luca, 8
## Albu, David, 2



PS3='Enter your option: '

select opt in "List older files" "Move files" "Periodic file deletion" "Delete file" "Rename files" "Edit files"; do

    case $opt in
        "List older files")
            echo "Find files created before (ex. mm/dd/yyyy or 10 day/month/year etc): "
            read date
            
            if [[ "$date" =~ ^(0[1-9])|1[012]/(0[1-9])|([1-3][0-9])/[0-9]{4}$ ]]; then 
                parsed_date=$(date -d "$date" +"%Y-%m-%d")
                find /home/$USER/Documents -type f -not -newermt "$parsed_date"
                
            elif [[ "$date" =~ ^[0-9]*[[:space:]](zile|luni|ani|saptamani|days|months|years|weeks)$ ]]; then
                if [[ "$date" =~ ^[0-9]*[[:space:]](zile|days|zi|day) ]]; then
                    value=$(echo $date | awk -F ' ' '{print $1}')
                    parsed_date=$(date -d "$value days ago" +"%Y-%m-%d")
                    find /home/$USER/Documents -type f -not -newermt "$parsed_date"
                    
                fi
                
                if [[ "$date" =~ ^[0-9]*[[:space:]](luni|months|luna|month) ]]; then
                    value=$(echo $date | awk -F ' ' '{print $1}')
                    parsed_date=$(date -d "$value months ago" +"%Y-%m-%d")
                    find /home/$USER/Documents -type f -not -newermt "$parsed_date"
                fi
                
                if [[ "$date" =~ ^[0-9]*[[:space:]](ani|years|an|year) ]]; then
                    value=$(echo $date | awk -F ' ' '{print $1}')
                    parsed_date=$(date -d "$value years ago" +"%Y-%m-%d")
                    find /home/$USER/Documents -type f -not -newermt "$parsed_date"
                fi
                
                if [[ "$date" =~ ^[0-9]*[[:space:]](saptamani|weeks|saptamana|week) ]]; then
                    value=$(echo $date | awk -F ' ' '{print $1}')
                    parsed_date=$(date -d "$value weeks ago" +"%Y-%m-%d")
                    find /home/$USER/Documents -type f -not -newermt "$parsed_date"
                fi
            fi
            ;;

            
        "Move files")
        
            PS3='Enter your option: '

            select opt in "Local" "Cloud"; do

                case $opt in
                    "Local")
                    
                        echo "Enter file path: "
                        read file_path
                        echo "Enter new location: "
                        read new_location
                        
                        mv $file_path $new_location
                        break
                        ;;
                        
                    "Cloud")
                        echo "Enter file path: "
                        read file_path
                        git add $file_path
                        git commit -m "Added file $file_path to cloud"
                        git push -u origin "main"
                esac
                        
            done
            
            
            ;;
            
        "Periodic file deletion")
            echo "Enter path to delete files from: "
            read path
            (crontab -l ; echo "0 20 * * 1 find $path -type f -mtime +60 -delete") | crontab -
            echo "File deletion is has been initialised"
            ;;
            
        "Delete file")
            echo "Enter file to delete: "
            read file_to_delete
            rm $file_to_delete
            ;;
            
        "Rename files")
            echo "Enter file to rename: "
            read file_to_rename
            echo "Enter extension: "
            read extension
            
            mv $file_to_rename $file_to_rename$extension
            
            
            xargs -I mv {}
            ;;
        
        "Edit files")
            echo "edit file"
            ;;
        
        *)
            echo "default"
            ;;
    esac    
done
