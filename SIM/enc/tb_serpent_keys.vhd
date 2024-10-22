library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.stop;

entity tb_serpent_keys is
end tb_serpent_keys;

architecture behavior of tb_serpent_keys is

    constant inClkp : time := 10ns;
    signal in_clk : std_logic := '0';

    signal in_data      :  std_logic_vector (255 downto 0);
    signal in_round_number      :  std_logic_vector (7 downto 0);
    signal out_key     :  std_logic_vector (127 downto 0);
    signal out_key_2     :  std_logic_vector (127 downto 0);

begin
    in_clk <= not in_clk after inClkp/2;
    uut: entity work.serpent_keys port map(in_clk, in_data, in_round_number, out_key, out_key_2);
    process
        
    begin
        wait for 10 ns;
        wait for 5 ns;

        --testowanie generowania klucz dla klucza skladajacego sie z samych zer
        in_round_number<=x"00";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"6F5795D0A7E3A3CEF2D998ED8ED77390") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;


        in_round_number<=x"01";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"8092730AECE6554A60A3EBD14113A999") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"02";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"FA49CA6886E649C3EF402A3C5108D22A") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"03";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"99EEBC8B8280A6732E1905B00FA9026F") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"04";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"3413B4B002913E20EA3F3D7A8F27BBF2") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"05";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"FCA3985A238DC99C610536D287D980AF") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"06";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"35F660F85D8751BBFE9B100C415297C6") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"07";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"EE42D6EDD6766CEB41B4F7D7E97FD458") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"08";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"F6C9CCA8EA423134D4EC2645BCF648C7") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"09";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"46D1E86C0B5661246B736DB9EC2D2132") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"0a";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"32B84C52AB5DA91E7BFF737FACEC090B") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"0b";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"8482BB59D7A0187AB89DD6737ED5EA77") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"0c";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"D8E083A1106F0679F555C2762B2A6DF9") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"0d";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"6A3EB5707EDA461C074B0765D3692B4F") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"0e";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"0AB5FE41ECDE7CE5F9D5D5B0D7FA42E1") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"0f";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"D2442936EEB113FF1D07F1065E4F43DE") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"10";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"CE6367628365CD7962773B2FA3FBCB18") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"11";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"A7DD8D94D72C46C8E8ACD04631B4BFDB") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"12";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"E15FA63E056ABCE9016D671B81F0FF69") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"13";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"9DD3267B8E142C053F29596E6B152640") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"14";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"9B0B05A432FCE59AAA5A880F03722FB5") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"15";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"D6D3AC8A227497F1E1F9B18DE135BA06") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"16";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"69E65C1759EE37138D26C9BBCAB80081") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"17";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"D2A92687CB6E4C546BB274EE576A5C11") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"18";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"82B76E530DC644AF58B92C6DE6712892") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"19";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"497861661C008534E9E89F0553A44454") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"1a";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"5C7D40D97D1054A5E45422E5FD9652A6") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"1b";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"FB9CFFB044B250C1049DDF9E307836D4") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"1c";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"4E25CA80EC3B40C67D89514D2E67F4D9") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"1d";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"0C5028EDDCE119ECE1258A5C614CF840") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"1e";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"A9031CC4EFE0E0875C02CC6E566D1DCB") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;



        in_round_number<=x"1f";
        in_data<=x"0000000000000000000000000000000000000000000000000000000000000000";
        wait for 10 ns;
        if(out_key = x"3A2474103D862BA308E1E2B0441D77A7") then
            report "Key is correct";
        else
            report "Key is incorrect";
        end if;

        if(out_key_2 = x"7BEBC4812F57267584A2550D60B526D6") then
            report "Last Key is correct";
        else
            report "Last Key is incorrect";
        end if;


        wait for 10 ns;
        stop;
    end process;

end behavior;
