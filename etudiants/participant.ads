package Participant is
   
    type Joueurjo is 
    record
    	Nom : String;
    	Signe : Character;
    	Id : Integer;
   end record;
    -- Retourne l'adversaire du joueur passé en paramètre
    function Adversaire(J : Joueur) return Joueur;
      
end Participant;
