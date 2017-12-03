with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

with Puissance4;
with Partie;

procedure P4test is
	Package MyPuissance4 is new Puissance4(3,3,3);
	
	Package MyPartie is new Partie(MyPuissance4.Grille,
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

	
	
