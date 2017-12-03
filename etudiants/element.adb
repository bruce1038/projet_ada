with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Text_Io; use Ada.Text_Io;

package body element is
   procedure Affiche_Int(E : in Integer) is
   begin
      Put(E,1);
   end Affiche_Int;

end element;
