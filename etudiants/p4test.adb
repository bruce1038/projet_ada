with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

with Puissance4;

procedure P4test is
	Package MyPuissance4 is new Puissance4(3,3,3);
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
	
	for I in 1..9 loop 
		C := MyPuissance4.CoupJoueur1(G);
		G := MyPuissance4.AjoutePion(G,C);
		Put_Line("");
		MyPuissance4.AfficheCoup(C);
		if MyPuissance4.Est_Gagnant(G,J1) then Put ("COUCOU");
		end if;
	
		C := MyPuissance4.CoupJoueur2(G);
		G := MyPuissance4.AjoutePion(G,C);
		Put_Line("");
		MyPuissance4.AfficheCoup(C);
	end loop;
	
end P4test;

	
	
