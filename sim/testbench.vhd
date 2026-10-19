library ieee;
use ieee.std_logic_1164.all;

entity tb_parking is
end tb_parking;

architecture sim of tb_parking is

    signal clk             : std_logic := '0';
    signal reset           : std_logic := '0';
    signal capteur_entree  : std_logic := '0';
    signal capteur_sortie  : std_logic := '0';

    signal barriere_entree : std_logic;
    signal barriere_sortie : std_logic;
    signal plein           : std_logic;
    signal vide            : std_logic;
    signal segments        : std_logic_vector(6 downto 0);

    constant PERIODE_CLK : time := 20 ns;

begin

    uut : entity work.parking
        port map (
            clk             => clk,
            reset           => reset,
            capteur_entree  => capteur_entree,
            capteur_sortie  => capteur_sortie,
            barriere_entree => barriere_entree,
            barriere_sortie => barriere_sortie,
            plein            => plein,
            vide             => vide,
            segments         => segments
        );

    clk <= not clk after PERIODE_CLK / 2;

    process
    begin
        reset <= '1';
        wait for 40 ns;
        reset <= '0';
        wait for 40 ns;

        capteur_entree <= '1';
        wait for 60 ns;
        capteur_entree <= '0';
        wait for 60 ns;

        capteur_entree <= '1';
        wait for 60 ns;
        capteur_entree <= '0';
        wait for 60 ns;

        capteur_sortie <= '1';
        wait for 60 ns;
        capteur_sortie <= '0';
        wait for 60 ns;

        wait;
    end process;

end sim;
