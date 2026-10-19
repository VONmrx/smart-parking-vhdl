library ieee ;
use ieee.std_logic_1164.all;
entity parking is 
port (
    clk, reset , capteur_entree , capteur_sortie: in std_logic ;
    barriere_entree, barriere_sortie , plein , vide : out std_logic;
    segments : out std_logic_vector(6 downto 0 )

);
end parking ; 
architecture structurelle of parking is 
 signal fil_evnt_entree : std_logic ;
 signal fil_evnt_sortie : std_logic ;
signal fil_plein : std_logic ;
 signal fil_vide : std_logic ;
 signal fil_compte : std_logic_vector(3 downto 0)  ;
begin
inst_fsm : entity work.fsm 
  port map (
     clk => clk,
     reset => reset ,
     capteur_entree => capteur_entree,
     capteur_sortie => capteur_sortie ,
     plein => fil_plein ,
     vide => fil_vide ,
     evnt_entree => fil_evnt_entree ,
     evnt_sortie=> fil_evnt_sortie , 
     barriere_entree => barriere_entree, 
     barriere_sortie => barriere_sortie 

);
inst_compteur : entity work.compteur 
port map(
    clk =>clk ,
    reset => reset ,
    evnt_entree => fil_evnt_entree,
    evnt_sortie => fil_evnt_sortie ,
     vide => fil_vide ,
     plein => fil_plein ,
     compte => fil_compte
);
inst_decodeur: entity work.deco_7seg  
port map  (
   compte => fil_compte,
   segments => segments
);
plein <= fil_plein;
vide <= fil_vide;
end structurelle ; 