with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

with Puissance4;

procedure P4test is
	Package MyPuissance4 is new Puissance4(4,6);
	J1 : MyPuissance4.Joueur;
	J2 : MyPuissance4.Joueur;
	G : MyPuissance4.Grille;
	C : MyPuissance4.Coup;
begin
	MyPuissance4.InitGrille(G);
	MyPuissance4.AfficheGrille(G);
	
	J1 := ('X',1);
	J2 := ('O',2);
	MyPuissance4.AfficheJoueur(J1);
	MyPuissance4.AfficheJoueur(J2);
	
	C := MyPuissance4.CoupJoueur1(G);
	while C.Y = -1 loop
		C := MyPuissance4.CoupJoueur1(G);
	end loop;
	G := MyPuissance4.AjoutePion(G,C);
	Put_Line("");
	MyPuissance4.AfficheCoup(C);
	
	C := MyPuissance4.CoupJoueur2(G);
	while C.Y = -1 loop
		C := MyPuissance4.CoupJoueur2(G);
	end loop;
	G := MyPuissance4.AjoutePion(G,C);
	Put_Line("");
	MyPuissance4.AfficheCoup(C);
	
	C := MyPuissance4.CoupJoueur1(G);
	while C.Y = -1 loop
		C := MyPuissance4.CoupJoueur1(G);
	end loop;
	G := MyPuissance4.AjoutePion(G,C);
	Put_Line("");
	MyPuissance4.AfficheCoup(C);
	
end P4test;

	
	
