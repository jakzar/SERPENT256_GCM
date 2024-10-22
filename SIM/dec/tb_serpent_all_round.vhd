library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

entity tb_serpent_all_round is
end tb_serpent_all_round;

architecture behavior of tb_serpent_all_round is

    constant inClkp : time := 10ns;
    signal in_clk : std_logic := '0';

    signal in_data      :  std_logic_vector (127 downto 0);
    signal in_key      :  std_logic_vector (255 downto 0);
    signal out_data      :  std_logic_vector (127 downto 0);

begin
    in_clk <= not in_clk after inClkp/2;
    uut: entity work.serpent_all_round port map(in_clk, in_data, in_key, out_data);
    process
        
    begin
        wait for 10 ns;
        wait for 10 ns;
        in_key<=x"000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F";
        in_data<=x"00112233445566778899AABBCCDDEEFF";

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
        stop;
    end process;

end behavior;
