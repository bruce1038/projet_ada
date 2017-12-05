with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;
with liste_generique;


package body liste_generique is







   procedure Liberer_It is new Ada.Unchecked_Deallocation (Iterateur_Interne, Iterateur);
   procedure Liberer is new Ada.Unchecked_Deallocation (Cellule , Liste);


   procedure Affiche_Liste (L : in Liste) is
      I : Iterateur := Creer_Iterateur (L);
   begin
      if A_Suivant(I) then
         Put(I.Elt);
      end if;
      while A_Suivant(I) loop

         Suivant(I);
         Put(I.Elt);
      end loop;
      Libere_Iterateur(I);
   end Affiche_Liste;



   procedure Insere_Tete (E : in Element; L : in out Liste) is

      newCell : Liste := new Cellule;

   begin


      newCell.Suiv := L;
      newCell.Elt := E;
      L := newCell;

   end Insere_Tete;



   procedure Libere_Liste(L : in out Liste) is


      next,cour : Liste;


   begin

      if L/=null then

	cour := L;

	next := L.Suiv;

	while  next /= null loop

            cour:=next;

            next:=next.Suiv;

            Liberer(cour);

            cour:=null;

	end loop;

      end if;

      L:=null;

   end Libere_Liste;





	function Creer_Liste return Liste is

	begin

		return null;

	end Creer_Liste;





	function Creer_Iterateur (L : Liste) return Iterateur is

		I : Iterateur := new Iterateur_Interne;

	begin

		if L /= NULL then

			I.Elt := L.Elt;

			I.Suiv := L.Suiv;

		else

			I:=NULL;

		end if;

		return I;

	end Creer_Iterateur;





	procedure Libere_Iterateur(It : in out Iterateur) is

	begin

		Liberer_It(It);

		It:=NULL;

	end Libere_Iterateur;





	procedure Suivant(It : in out Iterateur) is

	begin
		if A_Suivant(It)=false then
			raise FinDeListe;
		end if;
		It.Elt := It.Suiv.Elt;
		It.Suiv := It.Suiv.Suiv;

	exception when FinDeListe =>
		Put_Line("\n un iterateur a été utilisé alors qu'il avait atteint la fin de la liste\n");
	end Suivant;





	function Element_Courant(It : Iterateur) return Element is
	begin
		return It.Elt;
	end Element_Courant;


	function A_Suivant(It : Iterateur) return Boolean is
	begin

		if It.Suiv = NULL then
			return false;
		else
			return true;
		end if;
	end A_Suivant;


	function Est_Vide(L : Liste)return Boolean is 
		if L=NULL then return True;
		end if;
		return False;
	end Est_Vide;

end liste_generique;
