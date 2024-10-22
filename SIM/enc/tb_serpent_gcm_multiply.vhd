library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

entity tb_serpent_gcm_multiply is
end tb_serpent_gcm_multiply;

architecture behavior of tb_serpent_gcm_multiply is

    constant inClkp : time := 10ns;
    signal in_clk : std_logic := '0';

    signal A      :  std_logic_vector (127 downto 0);
    signal B      :  std_logic_vector (127 downto 0);
    signal out_data      :  std_logic_vector (127 downto 0);


begin
    in_clk <= not in_clk after inClkp/2;
    uut: entity work.serpent_gcm_multiply port map(A, B, out_data);
    process
        
    begin
        --testowanie modulu mnozacego na podstawie wektorow w dokumentacji Test Case 16, mnozenie A1 * H
        wait for 10 ns;
        A <= x"feedfacedeadbeeffeedfacedeadbeef";
        B <= x"acbef20579b4b8ebce889bac8732dad7";
        wait for 10 ns;
        if(out_data = x"5165d242c2592c0a6375e2622cf925d2") then
            report "Multiplying works correctly";
        else
            report "Multiplying doesn't work correctly";
        end if;
        wait for 10 ns;

        stop;
    end process;

end behavior;
