%Test 
clear all, close all, clc

filename = 'Template_Caract_Vehicle.xlsx' ; %Name of the Excel file for the comparison of the different concepts
sheet = 'Feuil1' ; %Name of the sheet
xlRange = 'B2:D41' ; %Range for the value
matfileName = 'Vehicle_Parameters.mat' ; %Name of the .mat file

%get the values in the Excel using xlsread.
[num,txt,raw] = xlsread(filename,sheet,xlRange);
%combine data as you want:
AllData={txt;num};%as you want
%save in mat file
save(matfileName,'AllData');%In your matfile nae

N_Param = size(raw) ; 

txt = txt(:,1) ; %On ne récupère que la colonne des noms de variables

%___Conversion___
%On doit transformer toutes les cell générées par l'importation du fichier
%Excel en array de strings et num pour créer les variables et les mettre
%dans un .mat pour les utiliser dans les script de simulation. 

Var_Name = strings(size(txt));
[Var_Name{:}] = txt{:} ;

Concept_Name = strings(N_Param(2)-1,1);
[Concept_Name{:}] = raw{1,2:N_Param(2)} ;

Var_Value = strings(size(txt)-1) 
[Var_Value{:}] = raw{2:end,2}  %On ne récupère que les colonnes avec des valeurs numériques
Var_Value = str2num(Var_Value)  %On converti en num les strings

for i = 2:length(N_Param(1))
    assignin('base', Var_Name(i), Var_Value(i));
end
