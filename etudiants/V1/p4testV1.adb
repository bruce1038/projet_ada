with Ada.Text_IO, Ada.Integer_Text_IO;
with Puissance4;

use Ada.Text_IO, Ada.Integer_Text_IO;
Use Puissance4;

procedure P4test is
	G : Grille(1..4,1..8);
	J1 : Joueur;
	J2 : Joueur;
begin
	InitGrille(G);
	AfficheGrille(G);
	
	J1 := ("Michel",'X',1);
	J2 := ("Jaquie",'O',2);
	AfficheJoueur(J1);
	AfficheJoueur(J2);
	
	AjoutePion(G,J1,1);
	
	Put_Line("");
	AfficheGrille(G);
	AjoutePion(G,J2,1);
	
	Put_Line("");
	AfficheGrille(G);
	AjoutePion(G,J1,1);
	
	Put_Line("");
	AfficheGrille(G);
	AjoutePion(G,J2,1);
	
	Put_Line("");
	AfficheGrille(G);
	AjoutePion(G,J1,1);
	
	Put_Line("");
	AfficheGrille(G);
	
end P4test;

	
	
