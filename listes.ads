-- ***************************************************************************	
-- 
-- Ici : representation de la liste vide par le POINTEUR NULL
-- INVARIANTS:
--   -> liste vide si L = null
--   -> si L non vide et Der la cellule contenant le dernier element,
--      alors Der.Suiv = null
-- ***************************************************************************

package listes is

	type Liste is private;

	-- exceptions levees par ce package
	Erreur_Liste_Vide : Exception;

------------------------------------------------------------------------------
-- PROCEDURES FOURNIES DANS LE .ADB

	-- cree une nouvelle liste, vide, et la retourne.	
	function Cree_Liste return Liste;

	-- libere une liste (memoire), apres l'avoir videe
	procedure Libere_Liste (L : in out Liste);
	
------------------------------------------------------------------------------
-- PROCEDURES A IMPLANTER DANS LE .ADB
-- ***** DANS CET ORDRE, EN TESTANT AU FUR ET A MESURE! *****
		
-- BLOC 1:
	-- true si liste vide, false sinon
	function Est_Vide (L: in Liste) return Boolean;

	-- insertion d'un element V en tete de liste
	procedure Insere_Tete (E: Element; L: in out Liste);

	-- affichage de la liste, dans l'ordre de parcours
	procedure Affiche (L: in Liste);

	-- recherche sequentielle d'un element dans la liste
	function Est_Present (E: Element; L: Liste) return Boolean;


-- BLOC 2:
	-- Vide la liste
	procedure Vide (L: in out Liste);

	-- insertion d'un element V en queue de liste
	procedure Insere_Queue (E: Element; L: in out Liste);
	
-- BLOC 3:
	-- suppression de l'element en tete de liste
	procedure Supprime_Tete (L: in out Liste; E: out Element);
	
	-- suppression l'element en queue de liste
	procedure Supprime_Queue (L: in out Liste; E: out Element);
	
	-- suppression de la premiere occurence de V dans la liste
	procedure Supprime_Premiere_Occurence (E: in Element; L: in out Liste);

	-- suppression de toutes les occurences de V de la liste
	procedure Supprime (E: in Element; L: in out Liste);

-- BLOC 4: on ne reviendra pas dessus en cours, mais a finir pour vous!

	-- inversion de l'ordre des elements dans une liste
	-- (sans allocation et en temps lineaire)
	procedure Inverse (L: in out Liste);
	
private 	
	-- type Cellule prive: a definir dans le body du package, listes.adb
	type Cellule;	
	type Liste is access Cellule;
	type Tabp is array (0..255) of Liste;

end listes;

