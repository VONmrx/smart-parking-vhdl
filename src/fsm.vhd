library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity fsm is 
port(
    clk , reset , capteur_entree , capteur_sortie , plein , vide :in std_logic ;
    evnt_entree , evnt_sortie , barriere_entree , barriere_sortie  : out std_logic 
);
end fsm ;
architecture behav1 of fsm is 
type type_etat is (repos , passage_entree , passage_sortie);
signal etat_actuel : type_etat := repos;
begin 
process(clk)
begin 
    if rising_edge(clk) then
        if reset = '1' then 
           etat_actuel <= repos;
           evnt_entree <= '0';
           evnt_sortie <= '0';
           barriere_entree <= '0';
           barriere_sortie <= '0';
        else 
           evnt_entree <= '0';
           evnt_sortie <= '0';
           case etat_actuel is 
           when repos => 
                barriere_entree <= '0';
                barriere_sortie <= '0';
                if capteur_entree= '1' and plein = '0' then 
                     etat_actuel <= passage_entree;
                     barriere_entree <= '1';
                elsif capteur_sortie ='1'  and vide ='0' then
                   etat_actuel <= passage_sortie ;
                   barriere_sortie <='1';
                end if ;

          when passage_entree =>
             barriere_entree <= '1';
             if capteur_entree = '0' then 
                 evnt_entree <= '1';
                 barriere_entree<= '0';
                 etat_actuel <= repos ;
             end if ;
           when passage_sortie =>
              barriere_sortie <='1';
              if capteur_sortie ='0' then 
                  evnt_sortie <= '1';
                  barriere_sortie <='0';
                  etat_actuel <= repos ;
              end if ;
           end case ;

      end if ;
 end if ; 
end process ;
end behav1 ;


