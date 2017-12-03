with Ada.Text_IO; 
with Ada.Integer_Text_IO;
with Puissance4;
with Partie;

use Ada.Text_IO;
use Ada.Integer_Text_IO;

package body partie is

	
    procedure Joue_Partie(E : in out Etat; J1 : in Joueur; J2 : in Joueur) is
    	C : Coup;
    begin
    	
		while true loop
			
			Affiche_Jeu(E);
			Put_Line("");
			Put("C'est à ");
			Put(Nom_Joueur1);
			Put(" de jouer");
			C := Coup_Joueur1(E);
			E := Etat_Suivant(E,C);
	
			if Est_Nul(E) then raise MatchNul;
			end if;
			if Est_Gagnant(E,J1) then raise J1Win;
			end if;
			
			Put_Line("");
			Affiche_Coup(C);
			
			Affiche_Jeu(E);
			Put_Line("");
			Put("C'est à ");
			Put(Nom_Joueur2);
			Put(" de jouer");
			C := Coup_Joueur2(E);
			E := Etat_Suivant(E,C);
		
			if Est_Nul(E) then raise MatchNul;
			end if;
			if Est_Gagnant(E,J2) then raise J2Win;
			end if;
			
			Put_Line("");
			Affiche_Coup(C);
		
		end loop;
	
		exception 
			when MatchNul => 
				Put_Line("");
				Put("Match nul !");
				Affiche_Jeu(E);
			when J1Win => 
				Put_Line("");
				Put("Match gagné par ");
				Put(Nom_Joueur1);
				Put(" , Congrats ;) !");
				Affiche_Jeu(E);
			when J2Win => 
				Put_Line("");
				Put("Match gagné par ");
				Put(Nom_Joueur2);
				Put(" , Congrats ;) !");
				Affiche_Jeu(E);
	end Joue_Partie;
	
	
End partie;
