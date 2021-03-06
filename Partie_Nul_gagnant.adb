with Ada.Text_IO, Ada.Integer_Text_IO;

use Ada.Text_IO, Ada.Integer_Text_IO;



package body Partie_Nul_gagnant is



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

		Put(" est le joueur N� ");

		Put(Integer'Image(J.Id));

		Put(" marqu� ");

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

			Put_Line ("L'ajout n'est pas autoris� !");

			Put_Line ("V�rifiez que la colonne dans la quelle vous souhaitez ajouter est vide");

			return G;

	end AjoutePion;



	--procedure Affiche_Coup(C : in Coup)



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
         --sous etape 1 : diagonales qui d�marrent sur le cot� vertical
      numColDepart := 0;
      numLigDepart := NbLignes -1;
      while (numLigDepart>=0) loop

            lig := numLigDepart ;
            col := numColDepart ;
            while (lig<NbLignes and col<NbColonnes) loop
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
      numLigDepart := 0;
      numColDepart := 1 ;
      while (numColDepart<NbColonnes) loop

            lig := numLigDepart ;
            col := numColDepart ;

            while (lig<NbLignes and col<NbColonnes) loop
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
         --sous etape 1 : diagonales qui d�marrent sur le cot� vertical
      numColDepart := 0;
      numLigDepart := NbLignes -1 ;
      while numLigDepart>=0 loop


         lig := numLigDepart ;
         col := numColDepart ;
         while (lig<NbLignes and col<NbColonnes) loop

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
     numLigDepart := NbLignes - 1;
      numColDepart := 1 ;
      while  numColDepart<NbColonnes loop


            lig := numLigDepart ;
            col := numColDepart ;

            while (lig<NbLignes and col<NbColonnes) loop
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

      col := 0;
      while col< NbColonnes loop
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








end Partie_Nul_gagnant;
