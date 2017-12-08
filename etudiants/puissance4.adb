with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;
with Liste_Generique;
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
		Put_Line("");
		Put(" ");
		for Y in G'Range(2) loop
			if Y < 10 then 
				Put(" ");
				Put(Integer'Image(Y));
				Put(" ");
			else
				Put(Integer'Image(Y));
				Put(" ");
			end if;
		end loop;
				
		for X in G'Range(1) loop
				Put_Line("");
			for Y in G'Range(2) loop
				Put(" | ");
				if G(X,Y) = 1 then Put('X');
				else if G(X,Y) = 2 then Put('O');
				else Put(' ');
				end if;
				end if;
			end loop;
			Put(" |");
		end loop;
	end AfficheGrille;
	
	function ColonneVide (G : in Grille; Y : Integer) return boolean is
	begin
		if Y > NbColonnes or Y< 0 then raise AjoutColonneInnexistante; end if;

		if (G(1,Y)=0) then return true;
		end if;
		return false;
		exception when AjoutColonneInnexistante => Put("Ajout Colonne inexistante ====================================================");
							Put(Integer'Image(Y));
							return false;
	end ColonneVide;
	
	procedure AfficheJoueur(J : in Joueur) is
	begin
		Put_Line("");
		Put(" Joueur N° ");
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
		while X<(NbLignes+1)  and then G(X,C.Y) = 0 loop
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
	
   function Est_Gagnant(G : Grille; J : Joueur) return Boolean is
	  lig,col : Integer;
	  compteJ : Integer;
	  numJoueur : Integer;
	  numColDepart,numLigDepart : Integer;
   begin
	  numJoueur := J.Id;
	  compteJ := 0;
	  
	  --Etape 1 : horizontal
	  for lig in G'Range(1) loop
		 for col in G'Range(2) loop
			if G(lig,col)= numJoueur then
			   compteJ :=compteJ + 1;
			   if compteJ = NbCoupsGagnant then
			      return True;
			   end if ;
			else
			   compteJ := 0;
			end if;
		 end loop;
		 compteJ:=0;
	  end loop;
	  compteJ :=0;
	  
	  
	  --Etape 2 : horizontal
	  for col in G'Range(2) loop
		 for lig in G'Range(1) loop
			if G(lig,col)= numJoueur then
			   compteJ :=compteJ + 1;
			   if compteJ = NbCoupsGagnant then
			      return True;
			   end if ;
			else
			   compteJ := 0;
			end if;
		 end loop;
		 compteJ:=0;
	  end loop;
	  compteJ :=0;
	  
		 --Etape 3 : Diagonale descendante gauche droite
		 --sous etape 1 : diagonales qui démarrent sur le coté vertical
	  numColDepart := 1;
	  numLigDepart := NbLignes ;
	  while (numLigDepart>=1) loop

			lig := numLigDepart ;
			col := numColDepart ;
			while (lig<=NbLignes and col<=NbColonnes) loop
			   if G(lig,col)= numJoueur then
			      compteJ := compteJ + 1;
			      if compteJ = NbCoupsGagnant then
			         return True;
			      end if ;
			   else
			      compteJ :=0;
			   end if;
			   
			   col:=col+1;
			   lig :=lig + 1;
			   
			end loop;
			
			compteJ :=0;
			numLigDepart := numLigDepart - 1;
			
		 end loop;
		 
		 
		 --sous etape 2 : diagonales qui demarrent d'en haut
	  numLigDepart := 1;
	  numColDepart := 2 ;
	  while (numColDepart<=NbColonnes) loop

			lig := numLigDepart ;
			col := numColDepart ;
			
			while (lig<=NbLignes and col<=NbColonnes) loop
			   if G(lig,col)= numJoueur then
			      compteJ := compteJ + 1;
			      if compteJ = NbCoupsGagnant then
			         return True;
			      end if ;
			   else
			      compteJ :=0;
			   end if;
			   
			   col:=col+1;
			   lig :=lig + 1;
			   
		 end loop;
		 
		 
			compteJ :=0;
			numColDepart := numColDepart + 1;
		 end loop;
			
		--Etape 4 : Diagonale montante gauche - droite
		 --sous etape 1 : diagonales qui démarrent sur le coté vertical
	  numColDepart := 1;
	  numLigDepart := NbLignes ;
	  while numLigDepart>=1 loop


		 lig := numLigDepart ;
		 col := numColDepart ;
		 while (lig>=1 and col<=NbColonnes) loop
			
			if G(lig,col)= numJoueur then
			   compteJ := compteJ + 1;
			   if compteJ = NbCoupsGagnant then
			      return True;
			   end if ;
			else
			      compteJ :=0;
			end if;
			   
			   col:=col + 1;
			   lig:=lig - 1;
			   
		 end loop;
			
			compteJ :=0;
			numLigDepart := numLigDepart - 1;
	  end loop;
		 
		 
		 --sous etape 2 : diagonales qui demarrent d'en bas
	 numLigDepart := NbLignes ;
	  numColDepart := 2 ;
	  while  numColDepart<=NbColonnes loop


			lig := numLigDepart ;
			col := numColDepart ;
			
			while (lig<=NbLignes and col<=NbColonnes) loop
			   if G(lig,col)= numJoueur then
			      compteJ := compteJ + 1;
			      if compteJ = NbCoupsGagnant then
			         return True;
			      end if ;
			   else
			      compteJ :=0;
			   end if;
			   
			   col:=col + 1;
			   lig:=lig - 1;
			   
			end loop;
			compteJ :=0;
			numColDepart := numColDepart + 1;
		 end loop;
		 
		 
		 return False;
	 
	  
   end Est_Gagnant;
	
   function Est_Nul(G :Grille) return Boolean is
	  J : Joueur;
	  col : Integer;
   begin
	  
	  col := 1;
	  while col<= NbColonnes loop
		 if ColonneVide(G,col) then
			return False;
		 end if;
		 
		 col := col+1;
	  
	  end loop;
	  
	  
	  J.Id:=1;
	  if Est_Gagnant(G,J) then
		 return False;
	  end if;
	  
	  J.Id:=2;
	  if Est_Gagnant(G,J) then
		 return False;
	  end if;
	 
	  return true;
	  
   end Est_Nul;
   
	procedure AfficheCoup(C : in Coup) is 
	begin
		Put_Line("");
		Put("Le joueur");
		Put(Integer'Image(C.J.Id));
		Put(" a joué un coup colonne ");
		Put(Integer'Image(C.Y));
	end AfficheCoup;
	
	function CoupJoueur1(G : Grille) return Coup is
		C : Coup;
	begin 
		C.J.Id := 1;
		Put_Line("");
		Put_Line("Dans quelle colonne souhaitez vous placer votre pion ?");
		Get(C.Y);
		while not TestCoup(G,C) loop
			Get(C.Y);
		end loop;
		return C;
	end CoupJoueur1;
	
	function CoupJoueur2(G : Grille) return Coup is
		C : Coup;
	begin 
		C.J.Id := 2;
		Put_Line("");
		Put_Line("Dans quelle colonne souhaitez vous placer votre pion ?");
		Get(C.Y);
		while not TestCoup(G,C) loop
			Get(C.Y);
		end loop;
		return C;
	end CoupJoueur2;
	
	function TestCoup(G : Grille; C : Coup) return boolean is
	begin
		if not ColonneVide(G, C.Y) then raise AjoutColonnePleine;
		end if;
		if C.Y > NbColonnes or C.Y < 1 then raise AjoutColonneInnexistante;
		end if;
		
		return true; 
		
		exception 
			when AjoutColonnePleine =>
				Put_Line ("Oups, cette colonne est pleine.");
				return false; 
			when CONSTRAINT_ERROR =>
				Put_Line ("Hein ... Mais cette colonne n'existe pas ... ");
				return false;
	end TestCoup; 
	

	function Coups_Disponibles (E : in Grille ; J : in Joueur) return Liste_Coups.Liste is 
	n : Integer :=1;
	L : Liste_Coups.Liste := Liste_Coups.Creer_Liste;
	C : Coup;
	begin
	C.J := J;
	
	while n<= NbColonnes loop
		if ColonneVide(E, n) then
			C.Y :=n;
			Liste_Coups.Insere_Tete(C,L);
		end if;
		n :=n+1;
	end loop;
	return L;

	end Coups_Disponibles;


	function Evaluation(G : Grille; J : Joueur;Adv : Joueur) return integer is 
	begin
		return 0 ;

	end Evaluation;
	

end Puissance4;
