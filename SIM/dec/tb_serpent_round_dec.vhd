library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

entity tb_serpent_round_dec is
end tb_serpent_round_dec;

architecture behavior of tb_serpent_round_dec is

    constant inClkp : time := 10ns;
    signal in_clk : std_logic := '0';

    signal in_data      :  std_logic_vector (127 downto 0);
    signal in_key      :  std_logic_vector (127 downto 0);
    signal out_data      :  std_logic_vector (127 downto 0);
    signal in_round_number      :  std_logic_vector (7 downto 0);
    
    
begin
    in_clk <= not in_clk after inClkp/2;
    uut: entity work.serpent_round_fun_dec port map(in_data, in_key, in_round_number, out_data);
    process
        
    begin
        wait for 10 ns;
        wait for 10 ns;
        in_round_number<=x"1f";
        in_data<=x"ac242374f8fdc8f1e1984f253c9ea49d";
        in_key<=x"c8dd62aac68cf95466124123d1857613";

        wait for 10 ns;
        wait for 10 ns;
        stop;
    end process;

end behavior;
