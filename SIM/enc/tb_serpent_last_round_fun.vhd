library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

entity tb_serpent_last_round_fun is
end tb_serpent_last_round_fun;

architecture behavior of tb_serpent_last_round_fun is

    constant inClkp : time := 10ns;
    signal in_clk : std_logic := '0';

    signal in_data      :  std_logic_vector (127 downto 0);
    signal in_key_1    :  std_logic_vector (127 downto 0);
    signal in_key_0     :  std_logic_vector (127 downto 0);
    signal out_data     :  std_logic_vector (127 downto 0);

begin
    in_clk <= not in_clk after inClkp/2;
    uut: entity work.serpent_last_round_fun port map(in_data, in_key_0, in_key_1, out_data);
    process
        
    begin
        wait for 10 ns;
        wait for 10 ns;

        --testowanie funkcji ostatniej rundy dla klucza skladajacego sie z samych zer oraz tekstu jawnego rowniez bedacego samymi zerami (po przetworzeniu przez poprzednie rundy)
        in_data<=x"407bd796f93c181777be1d175767f7fb";
        in_key_0<=x"3a2474103d862ba308e1e2b0441d77a7";
        in_key_1<=x"7BEBC4812F57267584A2550D60B526D6";
        wait for 10 ns;
        if(out_data = x"a82b6749f98dd9980418195089104945") then
            report "Round output is correct";
        else
            report "Round output is incorrect";
        end if;


        wait for 10 ns;
        stop;
    end process;

end behavior;
