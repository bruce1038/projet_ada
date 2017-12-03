generic

	NbLignes : Integer;

	NbColonnes : Integer;

	NbCoupsGagnant : Integer;

package Partie_Nul_gagnant is



	--

	-- Types

	--



	-- Pour le puissance 4, nous allons cr�er une grille � l'aide d'un

	-- tableau � 2 dimensions.

	-- Chaque case, ou cellule sera dot� d'un entier :

	-- 0 si la case est vide

	-- 1 si la case est occup�e par le pion du joueur 1

	-- 2 si la case est occup�e par le pion du joueur 2

	type Grille is array(1..NbLignes,1..NbColonnes) of Integer;



	-- Pour le puissance 4, un joueur est une structure dot�e de son

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

	-- Proc�dures et fonctions

	--



	procedure InitGrille (G : in out Grille); -- Initialise une grille de jeu dont l'�tat de chaque cellule est �gal � 0

	function ColonneVide (G : in Grille; Y : Integer) return boolean; -- Retourne un bol�en qui indique la colonne X est vide

	procedure AfficheJoueur(J : in Joueur);



	function AjoutePion(G : grille; C : Coup) return Grille; -- Ajoute un pion dans la colonne Y donn�e par le joueur J

	procedure AfficheGrille (G : in Grille);

	--procedure AfficheCoup(C : in Coup);

   function Est_Gagnant(G : Grille; J : Joueur) return Boolean;
   function Est_Nul(G : Grille) return Boolean;
	AjoutIllegal : exception; -- Ajout de pion non autoris� car colonne pleine.



end Partie_Nul_gagnant;
