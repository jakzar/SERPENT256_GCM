library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

entity tb_serpent_round_fun is
end tb_serpent_round_fun;

architecture behavior of tb_serpent_round_fun is

    constant inClkp : time := 10ns;
    signal in_clk : std_logic := '0';

    signal in_data      :  std_logic_vector (127 downto 0);
    signal in_round_number      :  std_logic_vector (7 downto 0);
    signal in_key     :  std_logic_vector (127 downto 0);
    signal out_data     :  std_logic_vector (127 downto 0);

begin
    in_clk <= not in_clk after inClkp/2;
    uut: entity work.serpent_round_fun port map(in_data, in_key, in_round_number, out_data);
    process
        
    begin
        wait for 10 ns;
        wait for 10 ns;

        --testowanie funkcji rundy dla klucza skladajacego sie z samych zer oraz tekstu jawnego rowniez bedacego samymi zerami (pierwsze 6 rund)
        in_round_number<=x"00";
        in_data<=x"00000000000000000000000000000000";
        in_key<=x"6f5795d0a7e3a3cef2d998ed8ed77390";
        wait for 10 ns;
        if(out_data = x"44e299666e14114b71a546d8cc38d0b4") then
            report "Round output is correct";
        else
            report "Round output is incorrect";
        end if;


        in_round_number<=x"01";
        in_data<=out_data;
        in_key<=x"8092730aece6554a60a3ebd14113a999";
        wait for 10 ns;
        if(out_data = x"e15d96af958931dfecb0c36a0d143ae1") then
            report "Round output is correct";
        else
            report "Round output is incorrect";
        end if;



        in_round_number<=x"02";
        in_data<=out_data;
        in_key<=x"FA49CA6886E649C3EF402A3C5108D22A";
        wait for 10 ns;
        if(out_data = x"ce64cb17bb75099d355870ca633ec637") then
            report "Round output is correct";
        else
            report "Round output is incorrect";
        end if;


        in_round_number<=x"03";
        in_data<=out_data;
        in_key<=x"99EEBC8B8280A6732E1905B00FA9026F";
        wait for 10 ns;
        if(out_data = x"c4577cb830398a1eb3b0ef8599313a1e") then
            report "Round output is correct";
        else
            report "Round output is incorrect";
        end if;



        in_round_number<=x"04";
        in_data<=out_data;
        in_key<=x"3413B4B002913E20EA3F3D7A8F27BBF2";
        wait for 10 ns;
        if(out_data = x"cdeaae525bdf3c86606ac76b9eafbfed") then
            report "Round output is correct";
        else
            report "Round output is incorrect";
        end if;



        in_round_number<=x"05";
        in_data<=out_data;
        in_key<=x"FCA3985A238DC99C610536D287D980AF";
        wait for 10 ns;
        if(out_data = x"48cc11099893354c990e275a0cb7c118") then
            report "Round output is correct";
        else
            report "Round output is incorrect";
        end if;


        wait for 10 ns;
        stop;
    end process;

end behavior;
