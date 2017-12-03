package Participant is
   
    type Joueur is 
    record
    	Nom : String;
    	Signe : Character;
    	Id : Integer;
   
    -- Retourne l'adversaire du joueur passé en paramètre
    function Adversaire(J : Joueur) return Joueur;
      
end Participant;
