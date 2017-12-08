	    grille_test: Grille;
		Lcoups : ListeCoups.Liste;
		Val,MaxVal  : Integer;
		meilleur_coup : Coup;
		It : ListeCoups.Iterateur;
	begin
		--Put("Debut Choix coup");
		Lcoups := Coups_Possibles(E, J );

		--Put_Line("Liste Coups :");
		--ListeCoups.Affiche_Liste(LCoups);
		--Put_Line("Fin Liste Coups :");
		--Put_Line("");
	--Normalement ce cas ne se présente pas puisque le test se fait avant mais on ne sait jamais
		if ListeCoups.Est_Vide(Lcoups) then
			raise Fin_De_Partie;
		end if;

		
	--Initialisation
		It := ListeCoups.Creer_Iterateur(Lcoups);


		
	
		MaxVal := -9999;
		
	
		--Put_Line("Debut Boucle Choix coup");
	--Test pour chaque coup 
			--Appel de la fonction MIN pour evaluer les etats (Min appelle MAX), Cela revient à appeller MIN_Max mais le découpage en deux fonctions est plus facile à visualiser

		--premiere itération puis boucle
		Affiche_Coup(ListeCoups.Element_Courant(It));
			if val>MaxVal then 
				MaxVal:= Val;
				meilleur_coup := ListeCoups.Element_Courant(It);
			end if;

		while ListeCoups.A_Suivant(It) loop
			ListeCoups.Suivant(It);
			grille_test := Etat_Suivant(E ,  ListeCoups.Element_Courant(It));
			val := Eval_Min(grille_test,P-1);

			Affiche_Coup(ListeCoups.Element_Courant(It));
			Put_Line(Integer'Image(val));
				if val>MaxVal then 
					MaxVal:= Val;
					meilleur_coup := ListeCoups.Element_Courant(It);
				end if;
			
		end loop;
		--Put_Line("Fin Boucle Choix coup");
	
		
	--A la fin de la boucle , tout l'arbre a été testé, on peut dire quel est le meilleur coup d'adrès la fonction d'évaluation
		Put_Line("");
		Put("===========");Put(Integer'Image(MaxVal));Put("===========");
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
		--Put_Line("Debut Eval_Min");
	-- on est arrivé au bout de l'arbre, maintenant, il faut evaluer
		if prof=0 then
			return Eval(E,J);
		end if;

	--On a gagné
		if Est_Gagnant(E,J)then
			Put_Line("+9999");
			Put(Integer'Image(prof) );
			return 9999*prof;
		end if;

	--On a perdu 
		if Est_Gagnant(E,Adversaire)then
			Put_Line("-9999");
			return -9999*prof;
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


		--Put_Line("Debut Boucle Eval_Min");
	--Test pour chaque coup 
			--Appel de la fonction Max pour evaluer les etats (Max appelle min si la profondeur le permet, Eval sinon), Cela revient à appeller MIN_Max mais le découpage en deux fonctions est plus facile à visualiser
	

		--premiere itération
		grille_test := Etat_Suivant(E ,ListeCoups.Element_Courant(It));
		val := Eval_Max(grille_test,prof-1);
			if val<min_val then 
				min_val:= Val;
			end if;



		while ListeCoups.A_Suivant(It) loop
			ListeCoups.Suivant(It);
			grille_test := Etat_Suivant(E ,ListeCoups.Element_Courant(It));
			val := Eval_Max(grille_test,prof-1);
				if val<min_val then 
					min_val:= Val;
				end if;
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
	
		--Put_Line("Debut Eval_Max");


	-- on est arrivé au bout de l'arbre, maintenant, il faut evaluer
		if prof=0 then
			return -Eval(E,Adversaire);
		end if;

	--On a gagné  (Sauf que c'était le tour de l'adversaire donc c'est peu probable)
		if Est_Gagnant(E,J) then
			Put_Line("Gagnant Max J=========");
			return 9999;
		end if;

	--On a perdu
		if Est_Gagnant(E,Adversaire) then
			Put_Line("-9999");
			Put(Integer'Image(prof) );
			return -9999*prof; --si l'adversaire gagne vite c'est mal!
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


		--Put_Line("Debut Boucle Eval_Max");

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
