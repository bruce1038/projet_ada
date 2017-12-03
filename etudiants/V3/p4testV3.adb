with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

with Puissance4;



procedure P4test is
	Package MyPuissance4 is new Puissance4(3,11,3);
	J1 : MyPuissance4.Joueur;
	J2 : MyPuissance4.Joueur;
	G : MyPuissance4.Grille;
	C : MyPuissance4.Coup;
begin
	MyPuissance4.InitGrille(G);
	
	J1 := ('X',1);
	J2 := ('O',2);
	
	while true loop
		
		C := MyPuissance4.CoupJoueur1(G);
		G := MyPuissance4.AjoutePion(G,C);
		Put_Line("");
		MyPuissance4.AfficheCoup(C);
	
		if MyPuissance4.Est_Nul(G) then raise MyPuissance4.MatchNul;
		end if;
		if MyPuissance4.Est_Gagnant(G,J1) then raise MyPuissance4.J1Win;
		end if;
		
		C := MyPuissance4.CoupJoueur2(G);
		G := MyPuissance4.AjoutePion(G,C);
		Put_Line("");
		MyPuissance4.AfficheCoup(C);
		
		if MyPuissance4.Est_Nul(G) then raise MyPuissance4.MatchNul;
		end if;
		if MyPuissance4.Est_Gagnant(G,J2) then raise MyPuissance4.J2Win;
		end if;
		
	end loop;
	
	exception 
		when MyPuissance4.MatchNul => 
			Put_Line("");
			Put_Line("Match nul !");
			MyPuissance4.AfficheGrille(G);
		when MyPuissance4.J1Win => 
			Put_Line("");
			Put_Line("Match gagné par le joueur 1, Congrats ;) !");
			MyPuissance4.AfficheGrille(G);
		when MyPuissance4.J2Win => 
			Put_Line("");
			Put_Line("Match gagné par le joueur 2, Congrats ;) !");
			MyPuissance4.AfficheGrille(G);
			
end P4test;

	
	
