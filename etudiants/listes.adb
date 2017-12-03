with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;

with Ada.Unchecked_Deallocation;

package body listes is

	-- a partir de ce type on peut faire diverse hypotheses sur la facon
	-- dont la liste est representee, notamment en ce qui concerne la
	-- liste vide
	
	type Cellule is record
		Elt: Element;
		Suiv: Liste;
	end record;

	-- Procedure de liberation d'une Cellule (accedee par Liste)
	procedure Liberer is new Ada.Unchecked_Deallocation (Cellule, Liste);


	-- creation: init a null
	function Cree_Liste return Liste is
	begin
		return null;
	end Cree_Liste;

	-- liberation: vider et c'est tout...
	procedure Libere_Liste (L : in out Liste) is
	begin
		Vide(L);
	end Libere_Liste;


------------------------------------------------------------------------------
-- BLOC 1:
-------- true si liste vide, false sinon------
	function Est_Vide (L: in Liste) return Boolean is
	begin
	
	if (L=null)then		
		return true;
	else 
		return false;
	end if;
	
	
	end Est_Vide;


----------- insertion d'un element V en tete de liste-------
	procedure Insere_Tete (E: Element; L: in out Liste) is

	listeC : Liste;

	begin
		listeC :=  new Cellule;

		listeC.Val := V;
		listeC.Suiv := L;

		L := listeC  ;

	end Insere_Tete;

	-- affichage de la liste, dans l'ordre de parcours
	procedure Affiche (L: in Liste) is 
		Cell : Liste;
	begin
		Cell:=L;
		while Cell /= null loop
			put (Cell.Val) ;
			Cell:=Cell.Suiv;
		end loop;
		
	end Affiche;

	-- recherche sequentielle d'un element dans la liste
	function Est_Present (V: Element; L: Liste) return Boolean is
		Cell : Liste;
	begin
		Cell:=L;
		while Cell /= null loop
			if Cell.Val=V then 
				return true;
			else
				Cell:=Cell.Suiv;
			end if;
			
		end loop;
			
		return false;
	end Est_Present;


------------------------------------------------------------------------------
-- BLOC 2:

	-- Vide la liste
	procedure Vide (L: in out Liste) is
		Cell : Liste;
	begin
		if L/=null then
			Cell:=L.Suiv;
			while L /= null loop
					Liberer(L);
					L:=Cell;
					if L/=null then
						Cell:=L.Suiv;
					end if;
			end loop;
		end if;
	end Vide;


	-- insertion d'un element V en queue de liste
	procedure Insere_Queue (V: Element; L: in out Liste) is
		Cell : Liste;
	begin
		Cell:=L;
		if Cell/=null then
			Cell:=L.Suiv;
			if Cell/=null then
			
				while Cell.suiv/=null loop
					
					Cell:=Cell.Suiv;
				end loop;
	
				Cell.Suiv:=new Cellule;
				Cell:=Cell.Suiv;

				Cell.Val:=V;
				Cell.Suiv:=null;
			else
				Cell:=new Cellule;
				Cell.Val:=V;
				Cell.Suiv:=null;
			end if;
		else 
			Insere_tete(V,L);
		end if;
	end Insere_Queue;
	
	
------------------------------------------------------------------------------
-- BLOC 3:

	-- suppression de l'element en tete de liste
	procedure Supprime_Tete (L: in out Liste; E: out Element) is
	
	Cell : Liste;	
	begin
		Cell:=L;
		V:=L.Val;
		L:=L.Suiv;
		
		Liberer(Cell);
		
	end Supprime_Tete;
	
	
	-- suppression de l'element en queue de liste

--#######################Desindex la liste
 
	procedure Supprime_Queue (L: in out Liste; E: out Element) is
		Cell : Liste;
	
	begin

		Cell:=L;
		if L=null then  
		null;

		else if L.suiv = null then

			V:=Cell.val;
			Liberer(Cell);
			L:=null;

		else 
			
			while Cell.suiv.suiv /= null loop

				Cell:=Cell.suiv;

			end loop;
			
			V := Cell.suiv.val;
			Liberer(Cell.suiv);
			Cell.Suiv := null;
			
		end if;
		end if;


	end Supprime_Queue;
	
	

	procedure Supprime_Premiere_Occurence (E: in Integer; L: in out Liste) is
		Cell : Liste;
		Cell2 : Liste;
		I : integer;
	begin
		Cell:=L;
		if Cell.Val=V then
			Supprime_tete(L,I);
		else
			while Cell.suiv /= null loop
				if Cell.Suiv.Val = V then
					Cell2:=Cell.suiv;
					Cell.suiv:=Cell.suiv.suiv;
					Liberer(Cell2);
				else	
					Cell:=Cell.Suiv;
				end if;
			end loop;
		end if;
		

	end Supprime_Premiere_Occurence;


	-- suppression de toutes les occurences de V de la liste
	procedure Supprime (E: in Element; L: in out Liste) is
	begin
		while Est_Present (V,L)loop
			Supprime_Premiere_Occurence(V,L);
		end loop;
		
	end Supprime;


------------------------------------------------------------------------------
-- BLOC 4:

	-- inverse l'ordre des elements dans une liste
	-- (sans allocation et en temps lineaire)
	procedure Inverse (L: in out Liste) is
		Cell : Liste;	
		tab : Tabp;
		I,K:integer;
		
	begin
		if not Est_Vide(L)then
			Cell :=L;
			I:=0;
	
			K:=0;
			while Cell /= null loop --sauvegarde la liste des pointeurs dans l ordre dans le tableau
				tab(I):=Cell;
				Cell :=Cell.Suiv;
				I:=I+1;
			end loop;
		
			Cell:=tab(I-1);
		
			while K<I loop  --inverse l'ordre de la liste 
				Cell.Suiv:=tab(I-K-1);
				Cell := Cell.Suiv;
				K:=K+1;
			end loop;

			Cell.Suiv:=null;
			
			L:=tab(I-1);
		end if;
	end Inverse;

	

end listes;


	
