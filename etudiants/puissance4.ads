generic
	NbLignes : Integer;
	NbColonnes : Integer;
	
package Puissance4 is 
	-- On choisi de limiter la taile des noms à 25 caractères
	NOM_MAX : Constant Integer := 25;

	-- Pour le puissance 4, nous allons créer une grille à l'aide d'un 
	-- tableau à 2 dimensions.
	-- Chaque case, ou cellule sera doté d'un entier :
	-- 0 si la case est vide
	-- 1 si la case est occupée par le pion du joueur 1
	-- 2 si la case est occupée par le pion du joueur 2
	type Grille is array(1..NbLignes,1..NbColonnes) of Integer;
	
	-- Pour le puissance 4, un joueur est une structure dotée d'un nom, de son 
	-- identifaint et de son signe de jeu	
	type Joueur is record
		Nom : String(1..6); 
		Signe : Character;
		Id : Integer;
	end record;

	procedure InitGrille ( G : in out Grille); -- Initialise une grille de jeu dont l'état de chaque cellule est égal à 0
	procedure AfficheGrille (G : in Grille);
	function ColonneVide (G : in Grille; Y : Integer) return boolean; -- Retourne un boléen qui indique la colonne X est vide
	
	procedure AfficheJoueur(J : in Joueur);
	
	procedure AjoutePion(G : in out grille; J : in Joueur; Y : Integer); -- Ajoute un pion dans la colonne Y donnée par le joueur J
	
	AjoutIllegal : exception; -- Ajout de pion non autorisé car colonne pleine.
	
end Puissance4;
	

	
