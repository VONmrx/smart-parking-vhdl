library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity deco_7seg is 
port (
     compte : in std_logic_vector(3 downto 0);
     segments : out std_logic_vector(6 downto 0)
);
end deco_7seg ;
architecture behav of deco_7seg is 
begin 
with compte select 
 segments <= "1111110" when "0000",
             "0110000" when "0001",
             "1101101" when "0010",
             "1111001" when "0011",
             "0110011" when "0100",
             "1011011" when "0101",
              "1011111" when "0110",
              "1110000" when "0111",
              "1111111" when "1000",
              "0000001" when others;
end behav;
               
