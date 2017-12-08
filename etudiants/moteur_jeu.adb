
with Liste_Generique;
with Ada.Text_IO;
with puissance4;
--with Ada.Numerics.Discrete_Random;
 --package nbr aléatoires
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
	
	Lcoups := Coups_Possibles(E, J );

	
	--Normalement ce cas ne se présente pas puisque le test se fait avant mais on ne sait jamais
	if ListeCoups.Est_Vide(Lcoups) then
		raise Fin_De_Partie;
	end if;

		
	--Initialisation
	It := ListeCoups.Creer_Iterateur(Lcoups);


		
	
	MaxVal := -9999;
		
	
	
	--Test pour chaque coup 
		--Appel de la fonction MIN pour evaluer les etats (Min appelle MAX), Cela revient à appeller MIN_Max mais le découpage en deux fonctions est plus facile à visualiser

	--premiere itération puis boucle
	
	grille_test := Etat_Suivant(E ,  ListeCoups.Element_Courant(It));
		val := min_max(grille_test,P-1,False);
	
		if val>MaxVal then 
			MaxVal:= Val;
			meilleur_coup := ListeCoups.Element_Courant(It);
		end if;

	while ListeCoups.A_Suivant(It) loop
		ListeCoups.Suivant(It);
		grille_test := Etat_Suivant(E ,  ListeCoups.Element_Courant(It));
		val := min_max(grille_test,P-1,False);

		

			if val> MaxVal then 
				MaxVal:= Val;
				meilleur_coup := ListeCoups.Element_Courant(It);
				

				
			--else if val = MaxVal then 
				
				

			--end if;
			end if;
			
	end loop;
		
	
		
	--A la fin de la boucle , tout l'arbre a été testé, on peut dire quel est le meilleur coup d'après la fonction d'évaluation
	Put_Line("");
	Put("===========");Put(Integer'Image(MaxVal));Put("===========");

	return meilleur_coup;
	
	exception when Fin_De_Partie => Put("Plus de coups à jouer, la partie est terminée");
		return meilleur_coup;
	end Choix_Coup;






	function min_max(E : Grille;prof : Natural ;bonJoueur : Boolean)return Integer is
		val,MeilleurVal : Integer;
		Lcoups : ListeCoups.Liste;
		It : ListeCoups.Iterateur;
		grille_test: Grille;
		meilleur_coup : Coup;
		
	begin



	--On a gagné
		if Est_Gagnant(E,J)then
			return 9999*prof;-- gagner vite c'est mieux
		end if;

	--On a perdu 
		if Est_Gagnant(E,Adversaire)then
			return -9999*prof;
		end if;
	--Match nul
		if Est_Nul(E)then
			return 0;
		end if; 




--========================== Sinon :




		if BonJoueur then 

			if prof=0 then-- on est arrivé au bout de l'arbre, maintenant, il faut evaluer
				return Eval(E,J,Adversaire);
			end if;	

			MeilleurVal:=-9999;
			Lcoups := Coups_Possibles(E, J );
			It := ListeCoups.Creer_Iterateur(Lcoups);
			grille_test := Etat_Suivant(E ,  ListeCoups.Element_Courant(It));
			val :=min_max(grille_test,prof-1,FALSE);
			if val>MeilleurVal then 
				MeilleurVal:= Val;
				meilleur_coup := ListeCoups.Element_Courant(It);
			end  if;

			while ListeCoups.A_Suivant(It) loop
				ListeCoups.Suivant(It);
				grille_test := Etat_Suivant(E ,  ListeCoups.Element_Courant(It));
				val := min_max(grille_test,prof-1,FALSE);

				--Affiche_Coup(ListeCoups.Element_Courant(It));
				--Put_Line(Integer'Image(val));


				if val>MeilleurVal then 
					MeilleurVal:= Val;
					meilleur_coup := ListeCoups.Element_Courant(It);
				end if;
			
			end loop;





			return MeilleurVal;
	

		else --adversaire
			if prof=0 then-- on est arrivé au bout de l'arbre, maintenant, il faut evaluer
				return Eval(E,J,Adversaire);
			end if;	


			MeilleurVal:=+9999;
			Lcoups := Coups_Possibles(E, Adversaire );
			It := ListeCoups.Creer_Iterateur(Lcoups);

			--premiere itération puis boucle
			grille_test := Etat_Suivant(E ,  ListeCoups.Element_Courant(It));
			val :=min_max(grille_test,prof-1,TRUE);
			if val<MeilleurVal then 
				MeilleurVal:= Val;
				meilleur_coup := ListeCoups.Element_Courant(It);
			end  if;

			while ListeCoups.A_Suivant(It) loop
				ListeCoups.Suivant(It);
				grille_test := Etat_Suivant(E ,  ListeCoups.Element_Courant(It));
				val := min_max(grille_test,prof-1,TRUE);



				if val<MeilleurVal then 
					MeilleurVal:= Val;
					meilleur_coup := ListeCoups.Element_Courant(It);
				end if;
			
			end loop;
			return MeilleurVal;

		end if;

	
	end min_max;

--================================================

end Moteur_Jeu;
