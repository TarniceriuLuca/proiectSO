# Backup avansat de fisiere

 **Tarniceriu Luca si Albu David**

Proiectul are urmatoarele functionalitati:
 - Gasirea tuturor fisierelor mai vechi de o data calendaristica
 - Mutarea fisierelor
 - Stergerea periodica a fisierelor
 - Stergerea unui fisier
 - Redenumirea unui fisier (dupa extensie)
 - Editarea unui fisier
 - Afisarea spatiului de stocare utilizat de fisiere modificate mai noi de o data calendaristica
 - Cautarea fisierelor dupa extensie
 - Arhivarea fisierelor dupa extensie
 - Dezarhivarea unui fisier
 - Permite utilizarea urmatoarelor optiuni:
    * -h/ --help (informatii pentru utilizarea optiunilor)
    * -u/ --usage (exemplificare utilizare program)
    * --debug=on/off (setare mod debug on sau off)
    
    Functionalitatiile aplicatiei pot fi selectate dintr-un meniu realzat cu instructiunea "select" <br>
    Toata activitatea aplicatiei este monitorizata in fisierul out.log
    
1) ### Gasirea tuturor fisierelor mai vechi de o data calendaristica
    
    Tipul de data calendaristica este determinat folosind regex, iar in functie de tipul de data introdus se afiseaza fisierele dorite. <br>
    *out.log: tipul de data identificat.* <br>
    Tipurile de date recunoscute sunt:
        - mm/dd/yyyy
        - x day/month/week/year /zi/luna/saptamana/an singular si plural, unde x este un numar
        
2) ### Mutarea fisierelor
        
    Primeste calea catre un fisier, si calea catre folderul destinatie folosind instructiunea "mv"<br>
    *out.log: Moved $file_path to $new_location    /    Failed to move $file_path*

3) ### Stergerea periodica a fisierelor
    
    Citeste calea catre un folder si seteaza o intrare in corntab pentru stergerea fisierelor mai vechi de 60 de zile, la intervalul precizat<br>
    *out.log: File deletion has been initialised    /   Failed file deletion initialization*
    
   
4) ### Stergerea unui fisier
    
    Citeste calea catre un fisier si il sterge folosind instructiunea "rm"<br>
    *out.log: $file_to_delete deleted    /    Failed to delete $file_to_delete*
    
5) ### Redenumirea unui fisier

    Citeste calea catre un fisier.<br>
    Citeste extensia care sa fie adaugata la fisier. Este recunoscuta introducerea extensiei incluzand sau nu "."<br>
    Noua extensie este adaugata sau inlocuieste extensia deja existenta.<br>
    *out.log: $file_to_rename renamed    /    Failed to rename $file_to_rename*
    
6) ### Editarea unui fisier
    
    Citeste calea catre fisier.<br>
    Citeste mesajul dorit a fi adaugat.<br>
    Folosind select aplicatia creaza un meniu din care utilizatorul poate sa aleaga locatia adaugarii mesajului.<br>
    Adaugarea mesajului se poate face in mod repetat.<br>
    *out.log: Added message to beggining    /    Added message to end    Exited from Edit menu*
    
7) ### Afisarea spatiului de stocare utilizat de fisiere modificate mai noi de o data calendaristica

    Citeste calea catre folderul in care sa se execute cautarea.<br>
    Citeste o data calendaristica, recunoscuta folosind regex.<br>
    Afiseaza numele si spatiule de stocare utilizat a fisierelor modificate mai recent decat data introdusa<br>
    *out.log: tipul de data gasit*
    
8) ### Cautarea fisierelor dupa extensie

    Citeste calea catre folderul in care se executa cautarea.<br>
    Citeste extensia dupa care vor cauta fisierele.<br>
    Utilizand "find" impreuna cu "regex" afisam toate fisierele din folder cu extensia dorita.<br>
    *out.log: Found files with extension: $final_search_extension    /    Failed to find files with extension: $final_search_extension*
    
9) ### Arhivarea fisierelor dupa extensie

    Citeste calea catre folderul in care se executa cautarea.<br>
    Citeste extensia dupa care vor cauta fisierele.<br>
    Citeste numele arhivei care va fi creata.<br>
    Se creaza un folder temporar in care se muta fisierele gasite pentru a fi arhivate, se arhiveaza fisierele, si se sterge folderul temporar creat.<br>
    Arhiva se creaza in folderul in care ruleaza aplicatia, si este ulterior mutat in folderul in care s-a executat cautarea.<br>
    *out.log: Created archive: $archive_name.tar.gz    /    Failed to create archive: $archive_name.tar.gz*
    
10) ### Dezarhivarea unui fisier

    Citeste calea catre fisier.<br>
    Se dezarhiveaza fisierul in aceeasi locatie<br>
    *out.log: Extracted $file_to_extract successfully    /    Failed to extract $file_to_extract*
    
    
    
    
    
    
    
    
    
    
