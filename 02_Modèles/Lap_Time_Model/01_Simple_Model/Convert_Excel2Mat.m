%__Objectifs__
% Créer des paramètres dans matlab à partir d'un fichier Excel
%

%__Backlog__
%*** Créer un fichier .mat par concept rentrée dans le fichier Excel
%*** Détecter automatiquement les lignes et colonnes du fichier Excel pour
%extraire toutes les informations

%clear all, close all, clc

filename = 'Template_Caract_Vehicle.xlsx' ; %Name of the Excel file for the comparison of the different concepts
sheet = 1 ; %Name of the sheet
xlRange = 'B2:E41' ; %Range for the value
% On ne détecte pas automatiquement les dernières lignes et colonnes, il
% fau rentrer la bonne plage de valeurs pour l'instant
matfileName = 'Vehicle_Parameters.mat' ; %Name of the .mat file

%get the values in the Excel using xlsread.
[num,txt,raw] = xlsread(filename,sheet,xlRange);
%combine data as you want:
%AllData={txt;num};%as you want

N_Param = size(raw) ; 

txt = txt(:,1) ; %On ne récupère que la colonne des noms de variables

%___Conversion___


Var_Name = strings(size(txt));
[Var_Name{:}] = txt{:} ;

Concept_Name = strings(N_Param(2)-1,1);
[Concept_Name{:}] = raw{1,2:N_Param(2)} ;

for j = 1:length(Concept_Name)
    Var_Value = num(:,j) ; %On extrait les valeurs des variables associées au concept i
    disp(strcat("On extrait les valeurs des variables assocées au concept ",num2str(j)))
    
    for i = 1:N_Param(1)-1
        %Var_Name(i+1) ;
        %Var_Value(i) ;
        if (i == 28) | (i == 31) | (i == 35) | (i == 36)
            a = 1 ; %Faut encore gérer les vecteurs pour courbes moteur et rapport et ...
            %Je propose de rentrer ces vecteurs directement dans le script de l'appli qui correspondent à des données
            %qui ne change pas souvent. Si on prend l'exemple de la courbe
            %moteur (qui est celle du moteur de Optimus après passage sur Banc)
            %si un jour on refait un passage sur banc avec ce meme moteur ou un
            %autre et qu'on obtient une nouvelle courbe moteur on la rentrera
            %dans l'appli et nommmera différamment les deux courbes moteur pour
            %pouvoir venir les selectionner en paramètre dans l'excel. Exemple
            %: Cmot_Optimus & Cmot_Invictus
        elseif (~isnan(Var_Value(i)))
            assignin('base', Var_Name(i+1), Var_Value(i))
        else
            assignin('base',Var_Name(i+1),raw{i+1,2}) 
        end 
    end
    %save in mat file
    save(Concept_Name(j)); 
end



