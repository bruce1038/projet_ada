generic
	NbLignes : Integer;
	NbColonnes : Integer;
	
package Puissance4 is
	
	--
	-- Types
	--
	
	-- Pour le puissance 4, nous allons créer une grille à l'aide d'un 
	-- tableau à 2 dimensions.
	-- Chaque case, ou cellule sera doté d'un entier :
	-- 0 si la case est vide
	-- 1 si la case est occupée par le pion du joueur 1
	-- 2 si la case est occupée par le pion du joueur 2
	type Grille is array(1..NbLignes,1..NbColonnes) of Integer; 
		
	-- Pour le puissance 4, un joueur est une structure dotée de son 
	-- identifaint et de son signe de jeu	
	type Joueur is record
		Signe : Character;
		Id : Integer;
	end record;
	
	type Coup is record
		J : Joueur;
		Y : Integer;
	end record;
	
	--
	-- Procédures et fonctions
	--

	procedure InitGrille (G : in out Grille); -- Initialise une grille de jeu dont l'état de chaque cellule est égal à 0
	function ColonneVide (G : in Grille; Y : Integer) return boolean; -- Retourne un boléen qui indique la colonne X est vide
	procedure AfficheJoueur(J : in Joueur);
	
	function AjoutePion(G : grille; C : Coup) return Grille; -- Ajoute un pion dans la colonne Y donnée par le joueur J
	procedure AfficheGrille (G : in Grille);
	procedure AfficheCoup(C : in Coup); 
	function CoupJoueur1(G : Grille) return Coup;
	function CoupJoueur2(G : Grille) return Coup;
	
	--
	-- Exceptions
	--
	
	AjoutIllegal : exception; -- Ajout de pion non autorisé car colonne pleine.
	AjoutColonnePleine : exception;
	AjoutColonneInnexistante : exception;
	
end Puissance4;
	

	
