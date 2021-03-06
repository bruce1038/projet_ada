with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

with Puissance4;
with Partie;

with Moteur_Jeu;




procedure P4test is

package MyPuissance4 is new Puissance4(8,7,4);
	

	J1 : MyPuissance4.Joueur := ('X',1);
	J2 : MyPuissance4.Joueur := ('O',2);


	G : MyPuissance4.Grille;




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
			MyPuissance4.CoupJoueur1,
			MyAI.Choix_Coup);



				  

begin
	MyPuissance4.InitGrille(G);
	
	J1 := ('X',1);
	J2 := ('O',2);
	
	Put(J1.Signe);
	
	MyPartie.Joue_Partie(G, J1, J2);
	

			
end P4test;

	
	
