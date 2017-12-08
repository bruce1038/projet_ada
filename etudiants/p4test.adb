with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

with Puissance4;
with Partie;
--with Ada.Numerics.Discrete_Random;
with Moteur_Jeu;

--with Liste_Generique; 


procedure P4test is

package MyPuissance4 is new Puissance4(8,7,4);
	
--package Liste_Coups is new Liste_Generique(MyPuissance4.Coup, MyPuissance4.AfficheCoup);
	J1 : MyPuissance4.Joueur := ('X',1);
	J2 : MyPuissance4.Joueur := ('O',2);
	--colonnes is Integer'range 1..NbColonnes;

	G : MyPuissance4.Grille;

--with package  is new Ada.Numerics.Discrete_Random(colonnes);


package MyAI is new Moteur_Jeu(
			MyPuissance4.Grille,
			MyPuissance4.Coup,
			MyPuissance4.Joueur,

			MyPuissance4.AjoutePion,
			MyPuissance4.Est_Gagnant,
			MyPuissance4.Est_Nul,
			MyPuissance4.AfficheCoup,
			MyPuissance4.Liste_Coups,
			MyPuissance4.Coups_Disponibles,
			MyPuissance4.Evaluation,
			MyPuissance4.ColonneVide,
			6,
			J2,
			J1
			--colonnes,
			--Aleatoire
			);

package MyAI2 is new Moteur_Jeu(
			MyPuissance4.Grille,
			MyPuissance4.Coup,
			MyPuissance4.Joueur,

			MyPuissance4.AjoutePion,
			MyPuissance4.Est_Gagnant,
			MyPuissance4.Est_Nul,
			MyPuissance4.AfficheCoup,
			MyPuissance4.Liste_Coups,
			MyPuissance4.Coups_Disponibles,
			MyPuissance4.Evaluation,
			MyPuissance4.ColonneVide,
			6,
			J1,
			J2);

package MyPartie is new Partie(
			MyPuissance4.Grille,
			MyPuissance4.Coup,
			MyPuissance4.Joueur, 
			"Jacquie",
			"Michel",
			MyPuissance4.AjoutePion,
			MyPuissance4.Est_Gagnant,
			MyPuissance4.Est_Nul,
			MyPuissance4.AfficheGrille,
			MyPuissance4.AfficheCoup,
			MyAI2.Choix_Coup,
			MyAI.Choix_Coup);



				  

begin
	MyPuissance4.InitGrille(G);
	
	J1 := ('X',1);
	J2 := ('O',2);
	
	Put(J1.Signe);
	
	MyPartie.Joue_Partie(G, J1, J2);
	

			
end P4test;

	
	
