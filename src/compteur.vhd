library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compteur is 
generic (
   capacite : natural:= 8 

);
port(
     clk , reset , evnt_entree , evnt_sortie : in std_logic ; 
     vide ,plein : out std_logic;
     compte : out std_logic_vector(3 downto 0)
);
end compteur;
architecture rtl of compteur is 
signal reg_compte : unsigned(3 downto 0 ) := (others =>'0');
constant compte_zero : unsigned(3 downto 0):=(others => '0');
constant compte_max  : unsigned(3 downto 0) := to_unsigned(capacite, 4);
begin 
compte <= std_logic_vector(reg_compte);
plein <= '1' when reg_compte = compte_max else '0';
vide <='1' when reg_compte = compte_zero else '0';
process(clk)
begin 
if rising_edge(clk) then 
   if reset = '1' then
      reg_compte <= (others =>'0');
   elsif evnt_entree = '1' and evnt_sortie = '0'then 
      if reg_compte < compte_max then
           reg_compte <= reg_compte +1;
       end if ;
   elsif evnt_entree ='0' and evnt_sortie='1' then
       if reg_compte > compte_zero then 
            reg_compte <= reg_compte -1 ;
        end if ;
    end if ; 
end if ; 
end process;
end  rtl; 

   
           
 
