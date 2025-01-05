#!/bin/bash

## Tarniceriu, Luca, 8
## Albu, David, 2










echo " " > out.log
DEBUG="off"

PS3='Enter your option: '

select opt in "List older files" "Move files" "Periodic file deletion" "Delete file" "Rename files" "Edit files" "List file size" "Search files by extension" "Exit"; do

    case $opt in
        "List older files")
            echo "Find files modifyed before (ex. mm/dd/yyyy or 10 day/month/year etc): "
            read date
            
            if [[ "$date" =~ ^(0[1-9])|1[012]/(0[1-9])|([1-3][0-9])/[0-9]{4}$ ]]; then 
                parsed_date=$(date -d "$date" +"%Y-%m-%d")
                find /home/$USER/Documents -type f -not -newermt "$parsed_date"
                
                echo "Found date of type: month/day/year" >> out.log
                if [[ DEBUG == "on" ]]; then
                    echo "Found date of type: month/day/year"
                fi
                
            else 
                 if [[ "$date" =~ ^[0-9]*[[:space:]](zile|days) ]] || [[ "$date" =~ ^[0-9]*[[:space:]](zi|day) ]]; then
                    value=$(echo $date | awk -F ' ' '{print $1}')
                    parsed_date=$(date -d "$value days ago" +"%Y-%m-%d")
                    find /home/$USER/Documents -type f -not -newermt "$parsed_date"
                    
                    echo "Found date of type 'x' days" >> out.log
                    if [[ DEBUG == "on" ]]; then
                        echo "Found date of type 'x' days"
                    fi
                    
                fi
                
                if [[ "$date" =~ ^[0-9]*[[:space:]](luni|months) ]] || [[ "$date" =~ ^[0-9]*[[:space:]](luna|month) ]]; then
                    value=$(echo $date | awk -F ' ' '{print $1}')
                    parsed_date=$(date -d "$value months ago" +"%Y-%m-%d")
                    find /home/$USER/Documents -type f -not -newermt "$parsed_date"
                    
                    echo "Found date of type 'x' moths" >> out.log
                    if [[ DEBUG == "on" ]]; then
                        echo "Found date of type 'x' months"
                    fi
                    
                    
                fi
                
                if [[ "$date" =~ ^[0-9]*[[:space:]](ani|years) ]] || [[ "$date" =~ ^[0-9]*[[:space:]](an|year) ]]; then
                    value=$(echo $date | awk -F ' ' '{print $1}')
                    parsed_date=$(date -d "$value years ago" +"%Y-%m-%d")
                    find /home/$USER/Documents -type f -not -newermt "$parsed_date"
                    
                    echo "Found date of type 'x' years" >> out.log
                    if [[ DEBUG == "on" ]]; then
                        echo "Found date of type 'x' years"
                    fi
                fi
                
                if [[ "$date" =~ ^[0-9]*[[:space:]](saptamani|weeks) ]] || [[ "$date" =~ ^[0-9]*[[:space:]](saptamana|week) ]]; then
                    value=$(echo $date | awk -F ' ' '{print $1}')
                    parsed_date=$(date -d "$value weeks ago" +"%Y-%m-%d")
                    find /home/$USER/Documents -type f -not -newermt "$parsed_date"
                    
                    echo "Found date of type 'x' weeks" >> out.log
                    if [[ DEBUG == "on" ]]; then
                        echo "Found date of type 'x' weeks"
                    fi
                    
                fi
            fi
            ;;

            
        "Move files")
        

            select opt in "Local" "Cloud" "Exit"; do

                case $opt in
                    "Local")
                    
                        echo "Enter file path: "
                        read file_path
                        echo "Enter new location: "
                        read new_location
                        
                        mv $file_path $new_location && failed=0 || failed=1
                        
                        if [[ failed==0 ]]; then
                        
                            echo "Moved $file_path to $new_location" >> out.log
                            if [[ DEBUG == "on" ]]; then
                                echo "Moved $file_path to $new_location"
                            fi
                        else
                            echo "Failed to move $file_path" >> out.log
                            if [[ DEBUG == "on" ]]; then
                                echo "Failed to move $file_path"
                            fi
                        fi
                        
                        
                        ;;
                        
                    "Cloud")
                        echo "Enter file path: "
                        read file_path
                        git add $file_path
                        git commit -m "Added file $file_path to cloud"
                        git push -u origin "main" && failed=0 || failed=1
                        
                        if [[ failed==0 ]]; then
                            echo "Moved $file_path to cloud" >> out.log
                            if [[ DEBUG == "on" ]]; then
                                echo "Moved $file_path to cloud"
                            fi
                        else
                            echo "Failed to move to cloud" >> out.log
                            if [[ DEBUG == "on" ]]; then
                                echo "Failed to move to cloud"
                            fi
                        fi
                        
                        ;;
                        
                    "Exit")
                        echo "Exited Move menu" | tee out.log
                        break
                        ;;
                    *)
                        echo "Unavailable option"
                        ;;
                esac
                        
            done
            
            
            ;;
            
        "Periodic file deletion")
            echo "Enter path to delete files from: "
            read path
            (crontab -l ; echo "0 20 * * 1 find $path -type f -mtime +60 -delete") | crontab - && failed=0 || failed=1

            if [[ failed==0 ]]; then
                echo "File deletion is has been initialised" >> out.log
                if [[ DEBUG == "on" ]]; then
                    echo "File deletion is has been initialised"
                fi
            else
                echo "Failed file deletion initialization" >> out.log
                if [[ DEBUG == "on" ]]; then
                    echo "Failed file deletion initialization"
                fi
            fi
            
            
            ;;
            
        "Delete file")
            echo "Enter file path to delete: "
            read file_to_delete
            rm $file_to_delete && failed=0 || failed=1
            
            if [[ failed==0 ]]; then
                echo "$file_to_delete deleted" >> out.log
                if [[ DEBUG == "on" ]]; then
                    echo "$file_to_delete deleted"
                fi
            else
                echo "Failed to delete $file_to_delete" >> out.log
                if [[ DEBUG == "on" ]]; then
                    echo "Failed to delete $file_to_delete"
                fi
            fi
            
            ;;
            
        "Rename files")
            echo "Enter file path to rename: "
            read file_to_rename
            echo "Enter extension: "
            read extension
            
            if [[ "$extension" =~ ^\.[A-Za-z0-9]* ]]; then 
                final_extension=$(echo $extension | awk -F '.' '{print $2}')
            else
                final_extension=$extension
            fi
            
            
            if [[ "$file_to_rename" =~ \.([A-Za-z0-9]*)$ ]]; then
                file_name=$(echo $file_to_rename | awk -F '.' '{print $1}')
                mv $file_to_rename $file_name.$final_extension && failed=0 || failed=1
            else
                mv $file_to_rename $file_to_rename.$final_extension && failed=0 || failed=1
            fi
            
            
            if [[ failed==0 ]]; then
                echo "$file_to_rename renamed" >> out.log
                if [[ DEBUG == "on" ]]; then
                    echo "$file_to_rename renamed"
                fi
            else
                echo "Failed to rename $file_to_rename" >> out.log
                if [[ DEBUG == "on" ]]; then
                    echo "Failed to rename $file_to_rename"
                fi
            fi
            
            ;;
        
        "Edit files")
            echo "Enter file path to edit: "
            read file_to_edit
            echo "Enter message to add to file: "
            read message
            
            select opt in "Add to beggining" "Add to end" "Exit"; do
            
                case $opt in
                    "Add to beggining")
                        sed -i "1i $message" $file_to_edit
                        
                        echo "Added message to beggining" >> out.log
                        if [[ DEBUG == "on" ]]; then
                            echo "Added message to beggining"
                        fi
                        ;;
                        
                    "Add to end")
                        echo $message >> $file_to_edit
                        
                        echo "Added message to end" >> out.log
                        if [[ DEBUG == "on" ]]; then
                            echo "Added message to end"
                        fi
                        
                        ;;
                    "Exit")
                        echo "Exited from Edit menu" | tee out.log
                        break
                        ;;
                    *)
                        echo "Unavailable option"
                        ;;
                esac
            done
            ;;
            
            
            
            
            "List file size")
            echo "List size of files modified before (ex. mm/dd/yyyy or 10 day/month/year etc): "
            read date
            
            if [[ "$date" =~ ^(0[1-9])|1[012]/(0[1-9])|([1-3][0-9])/[0-9]{4}$ ]]; then 
                parsed_date=$(date -d "$date" +"%Y-%m-%d")
                find /home/$USER/Documents -type f -newermt "$parsed_date" -exec du -ch {} + 
                
                echo "Found date of type: month/day/year" >> out.log
                if [[ DEBUG == "on" ]]; then
                    echo "Found date of type: month/day/year"
                fi
                
            else
                if [[ "$date" =~ ^[0-9]*[[:space:]](zile|days) ]] || [[ "$date" =~ ^[0-9]*[[:space:]](zi|day) ]]; then
                    value=$(echo $date | awk -F ' ' '{print $1}')
                    parsed_date=$(date -d "$value days ago" +"%Y-%m-%d")
                    find /home/$USER/Documents -type f -newermt "$parsed_date" -exec du -ch {} +
                    
                    echo "Found date of type 'x' days" >> out.log
                    if [[ DEBUG == "on" ]]; then
                        echo "Found date of type 'x' days"
                    fi
                    
                fi
                
                if [[ "$date" =~ ^[0-9]*[[:space:]](luni|months) ]] || [[ "$date" =~ ^[0-9]*[[:space:]](luna|month) ]]; then
                    value=$(echo $date | awk -F ' ' '{print $1}')
                    parsed_date=$(date -d "$value months ago" +"%Y-%m-%d")
                    find /home/$USER/Documents -type f -newermt "$parsed_date" -exec du -ch {} +
                    
                    echo "Found date of type 'x' moths" >> out.log
                    if [[ DEBUG == "on" ]]; then
                        echo "Found date of type 'x' months"
                    fi
                    
                    
                fi
                
                if [[ "$date" =~ ^[0-9]*[[:space:]](ani|years) ]] || [[ "$date" =~ ^[0-9]*[[:space:]](an|year) ]]; then
                    value=$(echo $date | awk -F ' ' '{print $1}')
                    parsed_date=$(date -d "$value years ago" +"%Y-%m-%d")
                    find /home/$USER/Documents -type f -newermt "$parsed_date" -exec du -ch {} +
                    
                    echo "Found date of type 'x' years" >> out.log
                    if [[ DEBUG == "on" ]]; then
                        echo "Found date of type 'x' years"
                    fi
                fi
                
                if [[ "$date" =~ ^[0-9]*[[:space:]](saptamani|weeks) ]] || [[ "$date" =~ ^[0-9]*[[:space:]](saptamana|week) ]]; then
                    value=$(echo $date | awk -F ' ' '{print $1}')
                    parsed_date=$(date -d "$value weeks ago" +"%Y-%m-%d")
                    find /home/$USER/Documents -type f -newermt "$parsed_date" -exec du -ch {} +
                    
                    echo "Found date of type 'x' weeks" >> out.log
                    if [[ DEBUG == "on" ]]; then
                        echo "Found date of type 'x' weeks"
                    fi
                    
                fi
            fi
            ;;
            
        "Search files by extension")
            echo "Enter directory path to search in: "
            read search_directory
            echo "Enter extension to search by: "
            read search_extension
            
            if [[ "$search_extension" =~ ^\.[A-Za-z0-9]* ]]; then 
                final_search_extension=$(echo $search_extension | awk -F '.' '{print $2}')
            else
                final_search_extension=$search_extension
            fi
            
            find $search_directory -regex ".*\.$final_search_extension$"
            ;;
            
        "Exit")
            break
            
            echo "Exited program" >> out.log
            if [[ DEBUG == "on" ]]; then
                echo "Exited program"
            fi
            
            ;;
        
        *)
            echo "Unavailable option"
            ;;
    esac    
done



## cauta toate fisierele cu extensia .old (sau altceva) din directorul dat, le muta in alt director si il arhiveaza
##/home/themartianx/Informatica/SO1/proiect/testfile


