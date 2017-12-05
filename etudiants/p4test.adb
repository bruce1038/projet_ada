with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

with Puissance4;
with Partie;

with Moteur_Jeu;
with Liste_Generique; 


procedure P4test is

package MyPuissance4 is new Puissance4(7,7,4);
	
package Liste_Coups is new Liste_Generique(MyPuissance4.Coup, MyPuissance4.AfficheCoup);

package MyAI is new Moteur_Jeu(
			MyPuissance4.Grille,
			MyPuissance4.Coup,
			MyPuissance4.Joueur,
		--	
			MyPuissance4.AjoutePion,
			MyPuissance4.Est_Gagnant,
			MyPuissance4.Est_Nul,
			MyPuissance4.AfficheCoup,
			Liste_Coups,
			MyPuissance4.Evaluation,
			MyPuissance4.ColonneVide,
			
			4);

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



				  
	J1 : MyPuissance4.Joueur;
	J2 : MyPuissance4.Joueur;
	G : MyPuissance4.Grille;
begin
	MyPuissance4.InitGrille(G);
	
	J1 := ('X',1);
	J2 := ('O',2);
	
	Put(J1.Signe);
	
	MyPartie.Joue_Partie(G, J1, J2);
	

			
end P4test;

	
	
