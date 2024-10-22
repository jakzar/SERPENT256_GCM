----------------
--Jakub Zaroda--
----------------

--modul funkcje rundy szyfrujacej
-- sklada sie z dodania klucza rundowego
-- wykorzystania skrzynek podstawieniowych
-- przeksztalcenia liniowego

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_round_fun is port(
    in_data      : in std_logic_vector (127 downto 0);      --magistrala wejsciowa danych
    in_key      : in std_logic_vector (127 downto 0);       --magistrala wejsciowa klucza
    in_round_number : in std_logic_vector (7 downto 0);     --magistrala wejsciowa z numerem rundy
    out_data     : out std_logic_vector (127 downto 0)      --magistrala wyjsciowa danych
);
end serpent_round_fun;

architecture behaviour of serpent_round_fun is
    --rejestry pomocnicze
    signal temp_0 : std_logic_vector (127 downto 0);
    signal temp_1 : std_logic_vector (127 downto 0);

    signal out_s0 : std_logic_vector (127 downto 0);
    signal out_s1 : std_logic_vector (127 downto 0);
    signal out_s2 : std_logic_vector (127 downto 0);
    signal out_s3 : std_logic_vector (127 downto 0);
    signal out_s4 : std_logic_vector (127 downto 0);
    signal out_s5 : std_logic_vector (127 downto 0);
    signal out_s6 : std_logic_vector (127 downto 0);
    signal out_s7 : std_logic_vector (127 downto 0);
begin
    --dodawany jest klucz rundowy
    temp_0 <= in_data xor in_key;

    --nastepnie dane sa przetwarzane za pomoca Sboxow
    s0: entity work.serpent_sub_key_0_fun port map(temp_0, out_s0);
    s1: entity work.serpent_sub_key_1_fun port map(temp_0, out_s1);
    s2: entity work.serpent_sub_key_2_fun port map(temp_0, out_s2);
    s3: entity work.serpent_sub_key_3_fun port map(temp_0, out_s3);
    s4: entity work.serpent_sub_key_4_fun port map(temp_0, out_s4);
    s5: entity work.serpent_sub_key_5_fun port map(temp_0, out_s5);
    s6: entity work.serpent_sub_key_6_fun port map(temp_0, out_s6);
    s7: entity work.serpent_sub_key_7_fun port map(temp_0, out_s7);

    --w zaleznosci od numeru rundy wybierane jest wyjscie odpowiedniego sboxa
    temp_1 <= out_s0 when (in_round_number=x"00" or in_round_number=x"08" or in_round_number=x"10" or in_round_number=x"18")
            else out_s1 when (in_round_number=x"01" or in_round_number=x"09" or in_round_number=x"11" or in_round_number=x"19") 
            else out_s2 when (in_round_number=x"02" or in_round_number=x"0a" or in_round_number=x"12" or in_round_number=x"1a") 
            else out_s3 when (in_round_number=x"03" or in_round_number=x"0b" or in_round_number=x"13" or in_round_number=x"1b") 
            else out_s4 when (in_round_number=x"04" or in_round_number=x"0c" or in_round_number=x"14" or in_round_number=x"1c") 
            else out_s5 when (in_round_number=x"05" or in_round_number=x"0d" or in_round_number=x"15" or in_round_number=x"1d") 
            else out_s6 when (in_round_number=x"06" or in_round_number=x"0e" or in_round_number=x"16" or in_round_number=x"1e") 
            else out_s7 when (in_round_number=x"07" or in_round_number=x"0f" or in_round_number=x"17" or in_round_number=x"1f") 
            else x"00000000000000000000000000000000";

    --dane sa przeksztalcane za pomoca przeksztalcenia liniowego
    inst_linear: entity work.serpent_linear_transform port map(temp_1, out_data);

end behaviour;