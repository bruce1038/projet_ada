with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

package body Puissance4 is
	
	procedure InitGrille (G : in out Grille) is
	begin	
		for X in G'Range(1) loop
			for Y in G'Range(2) loop
				G(X,Y):=0;
			end loop;
		end loop;
	end InitGrille;
	
	procedure AfficheGrille (G : in Grille) is
	begin	
		for X in G'Range(1) loop
				Put_Line("");
			for Y in G'Range(2) loop
				Put(" |");
				Put(Integer'Image(G(X,Y)));
			end loop;
			Put(" |");
		end loop;
	end AfficheGrille;
	
	function ColonneVide (G : in Grille; Y : Integer) return boolean is
	begin
		if (G(1,Y)=0) then return true;
		end if;
		return false;
	end ColonneVide;
	
	procedure AfficheJoueur(J : in Joueur) is
	begin
		Put_Line("");
		Put(J.Nom);
		Put(" est le joueur N° ");
		Put(Integer'Image(J.Id));
		Put(" marqué ");
		Put(J.Signe);
	end AfficheJoueur;
	
	procedure AjoutePion(G : in out grille; J : in Joueur; Y : Integer) is
		X : Integer;
	begin
		if not ColonneVide(G,Y) then 
			raise AjoutIllegal;
		end if;
		
		X := 1;
		while X<5  and then G(X,Y) = 0 loop
			X := X+1;
		end loop;
		for X in G'Range(1) loop
			if G(X,Y) /= 0 then 
				G(X-1,Y) := J.Id;
				return;
			end if;
		end loop;
		G(X-1,Y) := J.Id;
		
		exception when AjoutIllegal => 
			Put_Line ("");
			Put_Line ("L'ajout n'est pas autorisé !"); 
			Put_Line ("Vérifiez que la colonne dans la quelle vous souhaitez ajouter est vide");
	end AjoutePion; 
	
	function Est_Gagnant(G : Grille; J : Joueur) return Boolean is
		-- 2 3 4
		-- 1 C 5
		-- 8 7 6
	begin
		for I in 1..9 loop
			
			
				
		
		
		
	
end Puissance4;
	
	
				
 
