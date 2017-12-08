--with Participant; use Participant; 
with Liste_Generique;
with Ada.Text_IO; use Ada.Text_IO;

with Puissance4;
with Partie;
--with Moteur_Jeu;



generic
	

    type Grille is private;
    type Coup is private;
    type Joueur is private;
	
	

    -- Calcule l'etat suivant en appliquant le coup
    with function Etat_Suivant(E : Grille; C : Coup) return Grille;
    -- Indique si l'etat courant est gagnant pour J
    with function Est_Gagnant(E : Grille; J : Joueur) return Boolean; 
    -- Indique si l'etat courant est un status quo (match nul)
    with function Est_Nul(E : Grille) return Boolean; 

    -- Affiche a l'ecran le coup passe en parametre
    with procedure Affiche_Coup(C : in Coup);
 -- Implantation d'un package de liste de coups
	with package  ListeCoups  is new Liste_Generique(Coup,Affiche_Coup);
	
	
    -- Retourne la liste des coups possibles pour J a partir de l'etat 
    with function Coups_Possibles(E : Grille; J : Joueur)return ListeCoups.Liste; 
    -- Evaluation statique du jeu du point de vue de l'ordinateur
    with function Eval(E :in Grille; J: Joueur; Adv : Joueur) return Integer;  
	with function Colonne_Pas_Pleine(E :in  Grille ; Colonne : in Integer)return Boolean;
	

 
    -- Profondeur de recherche du coup
    P : Natural;
	J : Joueur;
	Adversaire : Joueur;
	--colonnes : Integer'Range;
	--with package Aleatoire is new Ada.Numerics.Discrete_Random(colonnes);


package Moteur_Jeu is


    
    -- Choix du prochain coup par l'ordinateur. 
    -- E : l'etat actuel du jeu;
    -- P : profondeur a laquelle la selection doit s'effetuer
    function Choix_Coup(E : Grille) return Coup;
	
    Fin_De_Partie : exception;
private 
    -- Evaluation d'un coup a partir d'un etat donne
    -- E : Etat courant
    -- P : profondeur a laquelle cette evaluation doit etre réalisée
    -- C : Coup a evaluer
    -- J : Joueur qui realise le coup

	function min_max(E : Grille;prof : Natural ;bonJoueur : Boolean)return Integer ;
	-- function Eval_Min(E :Grille ; prof : Natural )return Integer;
	-- function Eval_Max(E :Grille ; prof : Natural )return Integer;

    --function Eval_Min_Max(E :Grille; P : Natural; C : Coup; J : Joueur) return Integer;
       
   
end Moteur_Jeu;
