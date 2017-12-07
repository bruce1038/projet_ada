--with Participant; use Participant; 
with Liste_Generique;
with Ada.Text_IO;
with puissance4;
--with Moteur_Jeu;

package body Moteur_Jeu is
 
--===
	--Choisit un Coup pour le joueur J avec l'algorithme MIN MAX à partir de la fonction EVAL
	function Choix_Coup(E : Grille) return Coup is
	    grille_test: Grille;
		Lcoups : ListeCoups.Liste;
		Val,MaxVal  : Integer;
		meilleur_coup : Coup;
		It : ListeCoups.Iterateur;
	begin
		Put("Debut Choix coup");
		Lcoups := Coups_Possibles(E, J );

		Put_Line("Liste Coups :");
		ListeCoups.Affiche_Liste(LCoups);
		Put_Line("Fin Liste Coups :");
		Put_Line("");
	--Normalement ce cas ne se présente pas puisque le test se fait avant mais on ne sait jamais
		if ListeCoups.Est_Vide(Lcoups) then
			raise Fin_De_Partie;
		end if;

		
	--Initialisation
		It := ListeCoups.Creer_Iterateur(Lcoups);
		meilleur_coup := ListeCoups.Element_Courant(It);
	
		MaxVal := -9999;
		
	
		Put_Line("Debut Boucle Choix coup");
	--Test pour chaque coup 
			--Appel de la fonction MIN pour evaluer les etats (Min appelle MAX), Cela revient à appeller MIN_Max mais le découpage en deux fonctions est plus facile à visualiser
		while ListeCoups.A_Suivant(It) loop
			grille_test := Etat_Suivant(E ,  ListeCoups.Element_Courant(It));
			val := Eval_Min(grille_test,P-1);--Attention de bien choisir le bon J à chaque appel de Min ou de max, on peut transmettre toujours le meme J et considerer que c'est le joueur en question dans Min et l'adversaire dans max 
				if val>MaxVal then 
					MaxVal:= Val;
					meilleur_coup := ListeCoups.Element_Courant(It);
				end if;
			ListeCoups.Suivant(It);
		end loop;
		Put_Line("Fin Boucle Choix coup");
	
		
	--A la fin de la boucle , tout l'arbre a été testé, on peut dire quel est le meilleur coup d'adrès la fonction d'évaluation
		return meilleur_coup;

		exception when Fin_De_Partie => Put("Plus de coups à jouer, la partie est terminée");
			return meilleur_coup;
	end Choix_Coup;



--======
	--La fonction Min représente la moitié de l'algorithme Min-Max
	function Eval_Min(E : Grille;prof : Natural )return Integer is 
		val : Integer;
		min_val : Integer := 9999;
		grille_test: Grille;
		It: ListeCoups.Iterateur;
		Lcoups : ListeCoups.Liste :=ListeCoups.Creer_Liste; 
	begin
		Put_Line("Debut Eval_Min");
	-- on est arrivé au bout de l'arbre, maintenant, il faut evaluer
		if prof=0 then
			return Eval(E,J);
		end if;

	--On a gagné
		if Est_Gagnant(E,J)then
			return 9999;
		end if;

	--On a perdu
		if Est_Gagnant(E,Adversaire)then
			return -9999;
		end if;
	--Match nul
		if Est_Nul(E)then
			return 0;
		end if; 

		Lcoups := Coups_Possibles(E,J);


	-- Encore une fois, normalement ce cas ne se produit pas mais si c'est le cas ca va poser un problème
		if ListeCoups.Est_Vide(Lcoups) then
			raise Fin_De_Partie;
		end if;
		
		
		It := ListeCoups.Creer_Iterateur(Lcoups);
		min_val := 9999;


		Put_Line("Debut Boucle Eval_Min");
	--Test pour chaque coup 
			--Appel de la fonction Max pour evaluer les etats (Max appelle min si la profondeur le permet, Eval sinon), Cela revient à appeller MIN_Max mais le découpage en deux fonctions est plus facile à visualiser
	
	
		while ListeCoups.A_Suivant(It) loop
			grille_test := Etat_Suivant(E ,ListeCoups.Element_Courant(It));
			val := Eval_Max(grille_test,prof-1);
				if val<min_val then 
					min_val:= Val;
				end if;
			ListeCoups.Suivant(It);
		end loop;

	return min_val;

	end Eval_Min;
	
--===========================
	function Eval_Max(E : Grille;prof : Natural)return Integer is

		val : Integer;
		max_val : Integer := -9999;
		grille_test: Grille;
		It: ListeCoups.Iterateur;
		Lcoups : ListeCoups.Liste :=ListeCoups.Creer_Liste; 
	begin
	
		Put_Line("Debut Eval_Max");


	-- on est arrivé au bout de l'arbre, maintenant, il faut evaluer
		if prof=0 then
			return -Eval(E,Adversaire);
		end if;

	--On a gagné
		if Est_Gagnant(E,J) then
			return 9999;
		end if;

	--On a perdu
		if Est_Gagnant(E,Adversaire) then
			return -9999;
		end if;
	--Match nul
		if Est_Nul(E)then
			return 0;
		end if; 

		Lcoups := Coups_Possibles(E,Adversaire);


	-- Encore une fois, normalement ce cas ne se produit pas mais si c'est le cas ca va poser un problème
		if ListeCoups.Est_Vide(Lcoups) then
			raise Fin_De_Partie;
		end if;
		
		
		It := ListeCoups.Creer_Iterateur(Lcoups);
		max_val := -9999;


		Put_Line("Debut Boucle Eval_Max");

	--Test pour chaque coup 
			--Appel de la fonction Min pour evaluer les etats (Min appelle max si la profondeur le permet, Eval sinon)
		while ListeCoups.A_Suivant(It) loop
			grille_test := Etat_Suivant(E ,ListeCoups.Element_Courant(It));
			val := Eval_Min(grille_test,prof-1);
				if val>max_val then 
					max_val:= Val;
				end if;
			ListeCoups.Suivant(It);
		end loop;

	return max_val;


	end Eval_Max;


--================================================

--La fonction Liste coups possibles renvoie une liste de tous les coups jouables sur la grille.
--	function ListeCoupsPossibles(E : in Grille; J : in Joueur) return Liste_Coups.Liste is
--		Lcoups : Liste_Coups.Liste ;
--		nouveauCoup : Coup;
--		i : Integer;
--	begin

--		nouveauCoup.J:= J;
--		Lcoups := Liste_Coups.Creer_Liste;
--		for i in range (1,  NbColonnes) loop
--			if Colonne_Pas_Pleine(E,i) then 
--				nouveauCoup.Y := i ;
--				Liste_Coups.Insere_tete(nouveauCoup,Lcoups);				
--			end if;
--			
--		end loop;
--
--		return Lcoups;
--
--	end ListeCoupsPossibles;


end Moteur_Jeu;
