--Moteur du jeu(IA)
with Liste_Generique;
with Ada.Text_IO; use Ada.Text_IO;

with Puissance4;
with Partie;




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
	J : Joueur;-- joueur de l'IA
	Adversaire : Joueur;--Son adversaire
	

package Moteur_Jeu is


    
    -- Choix du prochain coup par l'ordinateur. 
    -- E : l'etat actuel du jeu;
    -- P : profondeur a laquelle la selection doit s'effetuer
    function Choix_Coup(E : Grille) return Coup;
	
    Fin_De_Partie : exception;
private 
    -- Evaluation d'un coup a partir d'un etat donne
    -- E : Etat courant
    -- prof : profondeur a laquelle cette evaluation doit etre réalisée
	--booleen pour savoir si on est dans la partie min ou dans la partie max


	function min_max(E : Grille;prof : Natural ;bonJoueur : Boolean)return Integer ;
	-- function Eval_Min(E :Grille ; prof : Natural )return Integer;
	-- function Eval_Max(E :Grille ; prof : Natural )return Integer;

  
       
   
end Moteur_Jeu;
