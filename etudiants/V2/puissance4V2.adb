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
		Put(" est le joueur N° ");
		Put(Integer'Image(J.Id));
		Put(" marqué ");
		Put(J.Signe);
	end AfficheJoueur;
	
	function AjoutePion(G : Grille; C : Coup) return Grille is
		X : Integer;
		NewG : Grille;
	begin
		if not ColonneVide(G,C.Y) then 
			raise AjoutIllegal;
		end if;
		
		NewG := G;
		X := 1;
		while X<5  and then G(X,C.Y) = 0 loop
			X := X+1;
		end loop;
		for X in G'Range(1) loop
			if G(X,C.Y) /= 0 then 
				NewG(X-1,C.Y) := C.J.Id;
				return NewG;
			end if;
		end loop;
		NewG(X-1,C.Y) := C.J.Id;
		return NewG;
		
		exception when AjoutIllegal => 
			Put_Line ("");
			Put_Line ("L'ajout n'est pas autorisé !"); 
			Put_Line ("Vérifiez que la colonne dans la quelle vous souhaitez ajouter est vide");
			return G;
	end AjoutePion; 
	
	procedure AfficheCoup(C : in Coup) is 
	begin
		Put_Line("");
		Put("Le joueur ");
		Put(Integer'Image(C.J.Id));
		Put(" a joué un coup colonne ");
		Put(Integer'Image(C.Y));
	end AfficheCoup;
	
	function CoupJoueur1(G : Grille) return Coup is
		C : Coup;
	begin 
		C.J.Id := 1;
		AfficheGrille(G);
		Put_Line("");
		Put_Line("Dans quelle colonne souhaitez vous placer votre pion ?");
		Get(C.Y);
		
		if not ColonneVide(G, C.Y) then raise AjoutColonnePleine;
		end if;
		if C.Y > 6 or C.Y < 1 then raise AjoutColonneInnexistante;
		end if; 
		
		return C;
		
		exception 
			when AjoutColonnePleine =>
				Put_Line ("Oups, cette colonne est pleine.");
				C.Y := -1;
				return C; 
			when CONSTRAINT_ERROR =>
				Put_Line ("Hein ... Mais cette colonne n'existe pas ... ");
				C.Y := -1;
				return C;
	end CoupJoueur1;
	
	function CoupJoueur2(G : Grille) return Coup is
		C : Coup;
	begin 
		C.J.Id := 2;
		AfficheGrille(G);
		Put_Line("");
		Put_Line("Dans quelle colonne souhaitez vous placer votre pion ?");
		Get(C.Y);
		
		if not ColonneVide(G, C.Y) then raise AjoutColonnePleine;
		end if;
		if C.Y > 6 or C.Y < 1 then raise AjoutColonneInnexistante;
		end if; 
		
		return C;
		
		exception 
			when AjoutColonnePleine =>
				Put_Line ("Oups, cette colonne est pleine.");
				C.Y := -1;
				return C; 
			when CONSTRAINT_ERROR =>
				Put_Line ("Hein ... Mais cette colonne n'existe pas ... ");
				C.Y := -1;
				return C;
	end CoupJoueur2;

				
		
		
	
end Puissance4;
	
	
				
 
