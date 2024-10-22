library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

entity tb_serpent_keys_dec is
end tb_serpent_keys_dec;

architecture behavior of tb_serpent_keys_dec is

    constant inClkp : time := 10ns;
    signal in_clk : std_logic := '0';

    signal in_data      :  std_logic_vector (255 downto 0);
    signal in_key      :  std_logic_vector (127 downto 0);
    signal out_key      :  std_logic_vector (127 downto 0);
    signal out_key_2      :  std_logic_vector (127 downto 0);
    signal in_round_number      :  std_logic_vector (7 downto 0);
    
    
begin
    in_clk <= not in_clk after inClkp/2;
    uut: entity work.serpent_keys_dec port map(in_clk, in_data, in_round_number, out_key, out_key_2);
    process
        
    begin
        wait for 10 ns;
        wait for 10 ns;
        in_round_number<=x"00";
        in_data<=x"3F9EE37D9EA55DAA6AB3911773F9C3E3EE74FED44397F0B6CF202CA0FE0903B7";

        wait for 10 ns;
        in_round_number<=x"01";
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;
        wait for 10 ns;        wait for 10 ns;
        wait for 10 ns;
        stop;
    end process;

end behavior;
