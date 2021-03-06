with Liste_Generique;


generic
	NbLignes : Integer;
	NbColonnes : Integer;
	NbCoupsGagnant : Integer;
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
	procedure AfficheJoueur(J : in Joueur); -- Affiche l'identité du joueur J
	function TestCoup(G : in Grille; C : in Coup) return boolean; -- Fonction qui teste si le coup demandé par un joueur est autorisé
	
	function AjoutePion(G : in grille; C : in Coup) return Grille; -- Ajoute un pion dans la colonne Y donnée par le joueur J
	function Est_Gagnant(G : Grille; J : Joueur) return Boolean; -- Test si la grille G est gagnée par le joueur J
   	function Est_Nul(G : Grille) return Boolean; -- Test si la grille donne un match nul
	procedure AfficheGrille (G : in Grille); -- Affiche la grille de jeu
	procedure AfficheCoup(C : in Coup); -- Affiche le Coup C joué
	
	package Liste_Coups is new Liste_Generique(Coup, AfficheCoup);

	function CoupJoueur1(G : Grille) return Coup; -- Retourne un coup du joueur 1 sur la grille G 
	function CoupJoueur2(G : Grille) return Coup; -- Retourne un coup du joueur 2 sur la grille G
	function Evaluation(G: Grille; J : Joueur; Adv : Joueur)return Integer; --retourne un entier entre +9999 et 0
	function Coups_Disponibles (E : in Grille ; J : in Joueur) return Liste_Coups.Liste; --Retourne la liste des coups disponibles pour un joueur(Pas tres utile dans le puissnce 4 pour l'humain mais necessaire pour l'IA)
	
	-- Exceptions
	--
	
	AjoutIllegal : exception; -- Ajout de pion non autorisé.
	AjoutColonnePleine : exception; -- Ajout sur une colonne pleine.
	AjoutColonneInnexistante : exception; -- Ajout dans une colonne inexistante.

	
end Puissance4;
	

	
