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
			MyPuissance4.CoupJoueur2);



				  

begin
	MyPuissance4.InitGrille(G);
	
	J1 := ('X',1);
	J2 := ('O',2);
	
	Put(J1.Signe);
	
	MyPartie.Joue_Partie(G, J1, J2);
	

			
end P4test;

	
	
