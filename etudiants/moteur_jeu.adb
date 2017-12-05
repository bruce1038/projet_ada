--with Participant; use Participant; 
with Liste_Generique;
with Ada.Text_IO;
with puissance4;
--with Moteur_Jeu;

package body Moteur_Jeu is
 
--===
	--Choisit un Coup pour le joueur J avec l'algorithme MIN MAX à partir de la fonction EVAL
	function Choix_Coup(E : Grille;J : Joueur) return Coup is
	    grille_test: Grille;
		Lcoups : Liste_Coups.Liste;
		Val,MaxVal  : Integer;
		meilleur_coup : Coup;
		It : Liste_Coups.Iterateur;
		profondeur : Natural := P;
	begin
		Lcoups := ListeCoupsPossibles(E );

	--Normalement ce cas ne se présente ps puisque le test se fait avant mais on ne sait jamais
		if Liste_Coups.Est_Vide(Lcoups) then
			raise Fin_De_Partie;
		end if;

	--Initialisation
		meilleur_coup := Liste_Coups.Element_Courant(It);
		It := Liste_Coups.Creer_Iterateur(Lcoups);
		MaxVal := -9999;

	--Test pour chaque coup 
			--Appel de la fonction MIN pour evaluer les etats (Min appelle MAX), Cela revient à appeller MIN_Max mais le découpage en deux fonctions est plus facile à visualiser
		while Liste_Coups.A_Suivant(It) loop
			grille_test := Etat_Suivant(E ,  Liste_Coups.Element_Courant(It));
			val := MIN(grille_test,P-1,J);--Attention de bien choisir le bon J à chaque appel de Min ou de max, on peut transmettre toujours le meme J et considerer que c'est le joueur en question dans Min et l'adversaire dans max 
				if val>MaxVal then 
					MaxVal:= Val;
					meilleur_coup := Liste_Coups.Element_Courant(It);
				end if;
			Liste_Coups.Suivant(It);
		end loop;
		
	--A la fin de la boucle , tout l'arbre a été tésté, on peut dire quel est le meilleur coup d'adrès la fonction d'évaluation
		return meilleur_coup;

		exception when Fin_De_Partie => Put("Plus de coups à jouer, la partie est terminée");
			return meilleur_coup;
	end Choix_Coup;



--======
	--La fonction Min représente la moitié de l'algorithme Min-Max
	function Eval_Min(E : Grille;prof : Natural ; J : Joueur)return Integer is 
		val : Integer;
		min_val : Integer := 9999;
		grille_test: Grille;
		adversaire : Joueur;
	begin

	-- on est arrivé au bout de l'arbre, maintenant, il faut evaluer
		if prof=0 then
			return Eval(E,J);
		end if;

	--On a gagné
		if Est_Gagnant(E,J)then
			return 9999;
		end if;

	--On a perdu
		if Est_Gagnant(E,Adversaire(J))then
			return -9999;
		end if;
	--Match nul
		if Est_Nul(E,J)then
			return 0;
		end if; 

		Lcoups := ListeCoupsPossibles(E);


	-- Encore une fois, normalement ce cas ne se produit pas mais si c'est le cas ca va poser un problème
		if Liste_Coups.Est_Vide(Lcoups) then
			raise Fin_De_Partie;
		end if;
		
		
		It := Liste_Coups.Creer_Iterateur(Lcoups);
		min_val := 9999;

	--Test pour chaque coup 
			--Appel de la fonction Max pour evaluer les etats (Max appelle min si la profondeur le permet, Eval sinon), Cela revient à appeller MIN_Max mais le découpage en deux fonctions est plus facile à visualiser
		while Liste_Coups.A_Suivant(It) loop
			grille_test := Etat_Suivant(E ,Liste_Coups.Element_Courant(It));
			val := Eval_Max(grille_test,prof-1,J);
				if val<min_val then 
					min_val:= Val;
				end if;
			Liste_Coups.Suivant(It);
		end loop;

	return min_val;

	end Eval_Min;
	
--===========================
	function Eval_Max(E : Grille;prof : Natural; J : Joueur)return Integer is

		val : Integer;
		min_val : Integer := 9999;
		grille_test: Grille;
		
	begin
	
		
	-- on est arrivé au bout de l'arbre, maintenant, il faut evaluer
		if prof=0 then
			return -Eval(E,Adversaire(J));
		end if;

	--On a gagné
		if Est_Gagnant(E,J) then
			return 9999;
		end if;

	--On a perdu
		if Est_Gagnant(E,Adversaire(J)) then
			return -9999;
		end if;
	--Match nul
		if Est_Nul(E,J)then
			return 0;
		end if; 

		Lcoups := ListeCoupsPossibles(E);


	-- Encore une fois, normalement ce cas ne se produit pas mais si c'est le cas ca va poser un problème
		if Liste_Coups.Est_Vide(Lcoups) then
			raise Fin_De_Partie;
		end if;
		
		
		It := Liste_Coups.Creer_Iterateur(Lcoups);
		min_val := 9999;

	--Test pour chaque coup 
			--Appel de la fonction Min pour evaluer les etats (Min appelle max si la profondeur le permet, Eval sinon)
		while Liste_Coups.A_Suivant(It) loop
			grille_test := Etat_Suivant(E ,Liste_Coups.Element_Courant(It));
			val := Eval_Min(grille_test,prof-1,J);
				if val>max_val then 
					max_val:= Val;
				end if;
			Liste_Coups.Suivant(It);
		end loop;

	return max_val;


	end Eval_Max;


--================================================

--La fonction Liste coups possibles renvoie une liste de tous les coups jouables sur la grille.
	function ListeCoupsPossibles(E : in Grille; J : in Joueur) return Liste_Coups.Liste is
		Lcoups : Liste_Coups.Liste ;
		nouveauCoup : Coup;
		i : Integer;
	begin

		nouveauCoup.J:= J;
		Lcoups := Liste_Coups.Creer_Liste;
		for i in range (1,  NbColonnes) loop
			if Colonne_Pas_Pleine(E,i) then 
				nouveauCoup.Y := i ;
				Liste_Coups.Insere_tete(nouveauCoup,Lcoups);				
			end if;
			
		end loop;

		return Lcoups;

	end ListeCoupsPossibles;


end Moteur_Jeu;
