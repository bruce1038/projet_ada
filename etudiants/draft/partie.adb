with Ada.Text_IO; 
with Ada.Integer_Text_IO;
with Puissance4;
with Participant;
with Partie;
with Liste_Generique;
with Moteur_Jeu;

use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Participant;

package body partie is

	
    procedure Joue_Partie(E : in out Etat; J : in Joueur) is
    	C : Coup;
    begin
		C := Coup_Joueur1(E);
		E := Etat_Suivant(E,C);
		C := Coup_Joueur2(E);
		E := Etat_Suivant(E,C);
	end Joue_Parie;
	
	
End partie;

		while C.Y = -1 loop
			C := MyPuissance4.CoupJoueur1(G);
		end loop;
		G := MyPuissance4.AjoutePion(G,C);
		Put_Line("");
		MyPuissance4.AfficheCoup(C);
