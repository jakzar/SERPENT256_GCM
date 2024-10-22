----------------
--Jakub Zaroda--
----------------

--modul realizujacy skrzynke podstawieniowa s7

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity serpent_round_fun is port(
    in_clk       : in std_logic;
    in_data      : in std_logic_vector (127 downto 0);
    in_key      : in std_logic_vector (127 downto 0);
    in_round_number : in std_logic_vector (7 downto 0);
    out_data     : out std_logic_vector (127 downto 0)
);
end serpent_round_fun;

architecture behaviour of serpent_round_fun is
    signal temp_test : std_logic_vector (127 downto 0);
    signal temp_0 : std_logic_vector (127 downto 0);
    signal temp_1 : std_logic_vector (127 downto 0);
    signal temp_2 : std_logic_vector (127 downto 0);

    signal out_s0 : std_logic_vector (127 downto 0);
    signal out_s1 : std_logic_vector (127 downto 0);
    signal out_s2 : std_logic_vector (127 downto 0);
    signal out_s3 : std_logic_vector (127 downto 0);
    signal out_s4 : std_logic_vector (127 downto 0);
    signal out_s5 : std_logic_vector (127 downto 0);
    signal out_s6 : std_logic_vector (127 downto 0);
    signal out_s7 : std_logic_vector (127 downto 0);
begin
    temp_0 <= in_data xor in_key;

    s0: entity work.serpent_sub_key_0_fun port map(temp_0, out_s0);
    s1: entity work.serpent_sub_key_1_fun port map(temp_0, out_s1);
    s2: entity work.serpent_sub_key_2_fun port map(temp_0, out_s2);
    s3: entity work.serpent_sub_key_3_fun port map(temp_0, out_s3);
    s4: entity work.serpent_sub_key_4_fun port map(temp_0, out_s4);
    s5: entity work.serpent_sub_key_5_fun port map(temp_0, out_s5);
    s6: entity work.serpent_sub_key_6_fun port map(temp_0, out_s6);
    s7: entity work.serpent_sub_key_7_fun port map(temp_0, out_s7);


    -- process(in_round_number)
    -- begin
    --     case in_round_number is
    --         when x"00" => temp_1 <= out_s0;
    --         when x"01" => temp_1 <= out_s1;
    --         when x"02" => temp_1 <= out_s2;
    --         when x"03" => temp_1 <= out_s3;
    --         when x"04" => temp_1 <= out_s4;
    --         when x"05" => temp_1 <= out_s5;
    --         when x"06" => temp_1 <= out_s6;
    --         when x"07" => temp_1 <= out_s7;

    --         when x"08" => temp_1 <= out_s0;
    --         when x"09" => temp_1 <= out_s1;
    --         when x"0a" => temp_1 <= out_s2;
    --         when x"0b" => temp_1 <= out_s3;
    --         when x"0c" => temp_1 <= out_s4;
    --         when x"0d" => temp_1 <= out_s5;
    --         when x"0e" => temp_1 <= out_s6;
    --         when x"0f" => temp_1 <= out_s7;

    --         when x"10" => temp_1 <= out_s0;
    --         when x"11" => temp_1 <= out_s1;
    --         when x"12" => temp_1 <= out_s2;
    --         when x"13" => temp_1 <= out_s3;
    --         when x"14" => temp_1 <= out_s4;
    --         when x"15" => temp_1 <= out_s5;
    --         when x"16" => temp_1 <= out_s6;
    --         when x"17" => temp_1 <= out_s7;

    --         when x"18" => temp_1 <= out_s0;
    --         when x"19" => temp_1 <= out_s1;
    --         when x"1a" => temp_1 <= out_s2;
    --         when x"1b" => temp_1 <= out_s3;
    --         when x"1c" => temp_1 <= out_s4;
    --         when x"1d" => temp_1 <= out_s5;
    --         when x"1e" => temp_1 <= out_s6;
    --         when x"1f" => temp_1 <= out_s7;

    --         when others => temp_1 <= x"00000000000000000000000000000000";
    --     end case;
    -- end process;

    -- temp_1 <= out_s0 when (in_round_number=x"00" or in_round_number=x"08" or in_round_number=x"10" or in_round_number=x"18")
    --         else (out_s1 when (in_round_number=x"01" or in_round_number=x"09" or in_round_number=x"11" or in_round_number=x"19") else
    --             (out_s2 when (in_round_number=x"02" or in_round_number=x"0a" or in_round_number=x"12" or in_round_number=x"1a") else 
    --             (out_s3 when (in_round_number=x"03" or in_round_number=x"0b" or in_round_number=x"13" or in_round_number=x"1b") else 
    --             (out_s4 when (in_round_number=x"04" or in_round_number=x"0c" or in_round_number=x"14" or in_round_number=x"1c") else
    --                 (out_s5 when (in_round_number=x"05" or in_round_number=x"0d" or in_round_number=x"15" or in_round_number=x"1d") else
    --                     (out_s6 when (in_round_number=x"06" or in_round_number=x"0e" or in_round_number=x"16" or in_round_number=x"1e") else
    --                         (out_s7 when (in_round_number=x"07" or in_round_number=x"0f" or in_round_number=x"17" or in_round_number=x"1f") else x"00000000000000000000000000000000")))))))


    temp_1 <= out_s0 when (in_round_number=x"00" or in_round_number=x"08" or in_round_number=x"10" or in_round_number=x"18")
            else out_s1 when (in_round_number=x"01" or in_round_number=x"09" or in_round_number=x"11" or in_round_number=x"19") 
            else out_s2 when (in_round_number=x"02" or in_round_number=x"0a" or in_round_number=x"12" or in_round_number=x"1a") 
            else out_s3 when (in_round_number=x"03" or in_round_number=x"0b" or in_round_number=x"13" or in_round_number=x"1b") 
            else out_s4 when (in_round_number=x"04" or in_round_number=x"0c" or in_round_number=x"14" or in_round_number=x"1c") 
            else out_s5 when (in_round_number=x"05" or in_round_number=x"0d" or in_round_number=x"15" or in_round_number=x"1d") 
            else out_s6 when (in_round_number=x"06" or in_round_number=x"0e" or in_round_number=x"16" or in_round_number=x"1e") 
            else out_s7 when (in_round_number=x"07" or in_round_number=x"0f" or in_round_number=x"17" or in_round_number=x"1f") 
            else x"00000000000000000000000000000000";



    inst_linear: entity work.serpent_linear_transform port map(temp_1, out_data);


    -- process(in_clk)
    -- begin
    --     if(rising_edge(in_clk)) then
    --         out_data<=temp_2;
    --     end if;
    -- end process;
    


end behaviour;